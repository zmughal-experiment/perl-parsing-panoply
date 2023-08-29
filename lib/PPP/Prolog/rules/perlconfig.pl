% vim: ft=prolog

:- module(perlconfig, [
    read_perl_config_dump_terms/2,
    assert_perl_config_data/0
   ]).

:- use_module(library(process)).

:- dynamic perl_config/2.
:- dynamic perl_config_data/1.

read_perl_config_dump_terms(PerlPath, Terms) :-
    setup_call_cleanup(
        process_create(
            PerlPath, [
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
    read_perl_config_dump_terms(path(perl),Terms), assertz( perl_config_data(Terms) ).

%%
%% perl_config:assert_perl_config_data.
%% bagof( [X, Y], D^( perlconfig:perl_config_data(D), member(X, [ivtype, uvtype, nvtype]), member( perl_config(X, Y), D) ) , Vs).
%%
