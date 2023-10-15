#!/usr/bin/env perl
use v5.14;
use Future::AsyncAwait;

async sub do_a_thing
{
   my $first = await do_first_thing();

   my $second = await do_second_thing();

   return combine_things( $first, $second );
}

do_a_thing()->get;
