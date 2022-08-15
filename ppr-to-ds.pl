#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/../lib";

use strict;
use warnings;

use PPR::X;

my $base_grammar = $PPR::X::GRAMMAR;

sub main {
	our (@stack, %match);
	local @stack = ();
	local %match;
	my $re = qr{
		(?>(?&PerlEntireDocument))

		(?(DEFINE)
			(?<PerlSubroutineDeclaration>
				(?{ local %match = ( subroutine => pos() ) })
				( (?>(?&PerlStdSubroutineDeclaration)) )
				(?{ $match{text} = $^N })
				(?{ push @stack, \%match })
			|
				(?!)
			)

			(?<PerlStatement>
				(?{ local %match = ( statement => pos() ) })
				( (?>(?&PerlStdStatement)) )
				(?{ $match{text} = $^N })
				(?{ push @stack, \%match })
			|
				(?!)
			)
		)

		$base_grammar
	}xmso;

	my $code = q{
		sub where {
			my $test = 1 + 1;
			if( $test > 42 ) {
				return 'hey';
			}
			return $test;
		}
	};

	if( $code =~ $re ) {
		use DDP; p @stack;
	}

}

main;
