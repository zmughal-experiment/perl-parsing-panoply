#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use experimental qw( declared_refs );

my $d = [ [ 1, 2], [3,4] ];
my (\@v1, \@v2) = @$d;

{
        local $" = ', ';
        say "v1: (@v1)";
        say "v2: (@v2)";
}
