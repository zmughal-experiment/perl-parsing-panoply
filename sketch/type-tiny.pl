#!/usr/bin/env perl

use strict;
use warnings;

use B::Deparse;
use Types::Common qw(-types);

my %info = map {
        my $type = $_; ## no critic ControlStructures::ProhibitMutatingListFunctions
        my $var_name = '$_OUTER';
        $type => {
                deparse => B::Deparse->new->coderef2text(  $type->constraint ),
                (
                        inlined_check => $type->inline_check($var_name),
                        map {
                                my $inlined = $_;
                                local $_ = $var_name; ## no critic ControlStructures::ProhibitMutatingListFunctions
                                defined $inlined ? ( inlined       =>  [$inlined->($type, $var_name) ] ) : ()
                        } $_->inlined
                )x!!( $_->can_be_inlined ),
        }
} Int, PositiveInt, PositiveOrZeroInt, Str, HashRef, Dict[key => Str], Map, Num;
use DDP; p %info;
