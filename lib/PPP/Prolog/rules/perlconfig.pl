% vim: ft=prolog

:- use_module(library(process)).

:- dynamic perl_config/2.
:- dynamic perl_config_data/1.

read_perl_config_dump_terms(Terms) :-
        setup_call_cleanup(
            process_create(
                path(perl), [
                        '-Mlib::projectroot=lib',
                        '-MPPP::Prolog::DumpConfig=dump_terms',
                        '-e', 'dump_terms'
                    ],
                    [ stdout(pipe(Out)) ]),
            parse_perl_config_as_terms(Out, Terms),
            close(Out)).

parse_perl_config_as_terms(Out, Terms) :-
            read_stream_to_codes(Out, Codes),
            read_term_from_codes(Codes, Terms, [character_escapes(true)] ).

assert_perl_config_data :-
    read_perl_config_dump_terms(Terms), assertz( perl_config_data(Terms) ).

%%
%% bagof( [X, Y], D^( perl_config_data(D), member(X, [ivtype, uvtype, nvtype]), member( perl_config(X, Y), D) ) , Vs).
%%
