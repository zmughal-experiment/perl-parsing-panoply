package PPP::Prolog::DumpConfig;
# ABSTRACT: Dump Perl config as Prolog terms

use strict;
use warnings;
use feature qw(say postderef);

use Exporter qw( import );
our @EXPORT_OK = qw( dump_terms );

use List::Util qw(pairmap);

use Language::Prolog::Types qw(:ctors);
use Language::Prolog::Types::overload;
use Language::Prolog::Sugar functors => [ qw(
	perl_config
) ];


use Config ();

sub A {
	my ($n) = @_;
	return prolog_nil() unless defined $n;
	return $n if $n=~/^[a-z][A-Za-z0-9_]*$/;
	my $escaped = $n =~ s/([\\'])/\\$1/gr;
	return "'$escaped'"
}

sub get_terms {
	[ pairmap {
		perl_config( A($a), A($b) );
	} %Config::Config ];
}

sub dump_terms {
	say "[\n" .  join( ",\n", sort(get_terms()->@*) )
		. "\n].";

}


1;
