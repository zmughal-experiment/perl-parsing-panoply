#!/usr/bin/env perl
# PODNAME: dump-opcodes
# ABSTRACT: Dump opcodes and their args

use strict;
use warnings;

use Opcode;
use Opcodes qw(argnum opname opdesc opcodes);
use List::Util qw(max);

my %argflags = (
	1 => { sym => 'S', desc => 'scalar', },
	2 => { sym => 'L', desc => 'list', },
	3 => { sym => 'A', desc => 'array value', },
	4 => { sym => 'H', desc => 'hash value', },
	5 => { sym => 'C', desc => 'code value', },
	6 => { sym => 'F', desc => 'file value', },
	7 => { sym => 'R', desc => 'scalar reference', },
);

sub to_args {
	my $op = shift;
	my $argnum = argnum( $op );
	my @args;
	while( $argnum > 0 ) {
		my $this_arg = $argnum & 0xF;
		push @args, $argflags{ $this_arg & 0x7 }{sym} . '?'x!!($this_arg & 0x8);
		$argnum >>= 4;
	}
	join ",", @args;
}

sub main {
	my $max_len = max map length opname($_), 1..opcodes()-1;
	print join "\n", map {
		sprintf "%${max_len}s%-12s  | %s",
			opname($_), "(".to_args($_).")" , opdesc($_)
	} 1..opcodes()-1;
	print "\n";
}

main;
