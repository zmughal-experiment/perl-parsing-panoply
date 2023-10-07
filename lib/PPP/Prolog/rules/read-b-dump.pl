% vim: ft=prolog

:- use_module(library(http/json)).
:- use_module(library(gv)).
:- use_module(library(term_ext)).
:- use_module(library(apply)).
:- use_module(library(yall)).

read_b_dump(JsonFile, Dict) :-
    setup_call_cleanup(open(JsonFile, read, In),
        json_read_dict(In, Dict, [ value_string_as(atom) ]),
        close(In)).

find_main_root(OpTreeDump, MainOpRoot) :-
    member(MainOpRoot, OpTreeDump),
    _{ metadata:_{ type: main } } :< MainOpRoot.

process_files(Files, Goal) :-
    member(File, Files),
    read_b_dump(File, OpTreeDump),
    find_main_root(OpTreeDump, MainOpRoot),
    call(Goal, MainOpRoot).

% GraphViz {{{
portray_op(Op, Label) :-
    Op.node.name = padsv,
    atomic_list_concat([Op.node.name, Op.node.padname], ', ', Label).
portray_op(Op, Label) :-
    Op.node.name = const,
    swritef(OpSvStr, '%t', [Op.node.sv]), atom_string(OpSvAtom, OpSvStr),
    atomic_list_concat([Op.node.name, OpSvAtom], ', ', Label).
portray_op(Op, Label) :-
    Label = Op.node.name.
export_optree(_, _{}, _).
export_optree(Out, OpTree, Id) :-
    once(portray_op(OpTree, Label)), Children  = OpTree.node.children,
    ascii_id(Id),
    dot_node_id(Out, Id, options{label: Label, ordering: "out"} ),
    maplist( export_optree(Out), Children, Ids ),
    include(ground, Ids, GroundIds),
    maplist( dot_arc_id(Out, Id), GroundIds ).

display_root_as_gv(Root) :-
    gv_view(
        {Root}/[Out0]>>export_optree(Out0, Root.tree, _),
        options{directed: true}
    ).

display_root_as_gv_dump(Root) :-
    dot_graph(
        current_output,
        {Root}/[Out0]>>export_optree(Out0, Root.tree, _),
        options{directed: true}
    ).

% }}}

main :-
    current_prolog_flag(argv, Files), process_files(Files, display_root_as_gv_dump), halt
    ; halt.

%% swipl -g main read-b-dump.pl FILE
