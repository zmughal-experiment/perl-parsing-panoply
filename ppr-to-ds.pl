#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/../lib";

use strict;
use warnings;

use PPR::X;
use List::UtilsBy qw(nsort_by);

my $base_grammar = $PPR::X::GRAMMAR;

sub main {
	my @rule_names = $base_grammar =~ /<PerlStd([^>]+)>/msg;

	my @extraction_re_parts = map {
		my $name = $_;
		qq{
			(?<Perl$name>
				(?{ local \$parent = \\%match })
				(?{ local %match = ( name => $name => , position => pos(), parent => \$parent, ) })
				( (?>(?&PerlStd$name)) )
				(?{ \$match{text} = \$^N })
				(?{ push \@matches, \\%match })
			|
				(?!)
			)
		};
	} grep $_ !~ /^(Label|PodSequence|OWS|NWS)$/, @rule_names;

	our (@matches, $parent, %match);
	local @matches = ();
	local $parent;
	local %match = undef;
	my $re = do {
		use re 'eval';
		my $zz = qq{
			(?>(?&PerlEntireDocument))

			(?(DEFINE)
				@extraction_re_parts
			)

			$base_grammar
		};
		qr{$zz}xmso;
	};

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
		my @sorted = nsort_by { $_->{position} } @matches;
		use Data::Dumper::Concise; print Dumper(\@sorted);
	}

}

main;
