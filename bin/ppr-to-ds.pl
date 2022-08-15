#!/usr/bin/env perl

use FindBin;
use lib "$FindBin::Bin/../lib";

use strict;
use warnings;

use feature qw(say);

use PPR::X;
use Babble::Grammar;
use Role::Tiny ();

use List::UtilsBy qw(nsort_by);
use Data::Dumper::Concise;

sub main {
	my $grammar = Babble::Grammar->new;
	Role::Tiny->apply_roles_to_object( $grammar, qw(PPP::Babble::Grammar::Role::TryTiny) );
	my @rule_names = keys %{ $grammar->base_rule_names };

	my $grammar_re = $grammar->grammar_regexp;

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
	local %match = ();
	my $re = do {
		use re 'eval';
		my $zz = qq{
			\\A (?>(?&PerlEntireDocument)) \\Z

			(?(DEFINE)
				@extraction_re_parts
			)

			$grammar_re
		};
		qr{$zz}xmso;
	};

	my $code = do { local $/; <> };

	if( $code =~ $re ) {
		my @sorted = nsort_by { $_->{position} } @matches;
		print Dumper(\@sorted);
	} else {
		say "Error:";
		say $PPR::X::ERROR;
	}
}

main;
