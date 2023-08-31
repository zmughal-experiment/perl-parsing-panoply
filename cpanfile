requires 'B';
requires 'B::Utils', '0.27';
requires 'Babble::Grammar';
requires 'Config';
requires 'Data::Dumper::Concise';
requires 'Exporter';
requires 'IO::File';
requires 'JSON::MaybeXS';
requires 'Language::Prolog::Sugar';
requires 'Language::Prolog::Types';
requires 'Language::Prolog::Types::overload';
requires 'List::Util';
requires 'List::UtilsBy';
requires 'Moo::Role';
requires 'Opcode';
requires 'Opcodes';
requires 'PPR::X';
requires 'Role::Tiny';
requires 'Scalar::Util';
requires 'feature';
requires 'lib::projectroot';
requires 're';
requires 'strict';
requires 'warnings';

on develop => sub {
    requires 'Perl::PrereqScanner::NotQuiteLite';
};
