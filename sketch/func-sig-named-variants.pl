#!/usr/bin/env perl

=head1 DESCRIPTION

Demonstrate different ways of working with named parameters while knowing what
the keys/variables are from inside of the function body.

=cut

use v5.24;

use FindBin;
use lib "$FindBin::Bin/lib";

use feature qw(signatures);
use experimental 'signatures';
use Function::Parameters v2;
use Type::Params -sigs;

use PadWalker qw(peek_my);
use Sub::Util v1.40 qw(subname);

use List::Util v1.29 qw(pairkeys pairmap);

use Local::Type::Color qw(
	Slurpy
	CodeRef
	Any
	ColorElem8
	MyColorRGBA

	CycleTuple
	StrLength
	Int
	ArrayRef
);

=head1 FUNCTIONS

=cut

fun _dump_color_driver( (ArrayRef[Any,(4*2)x2] & CycleTuple[StrLength[1,1],ColorElem8] ) $pairs ) {
	say "Color: [ "
		. join(", ",
			pairmap { sprintf("%s: 0x%02X", $a, $b) }
			@$pairs )
		. " ]";

}

=head2 dump_color_func_params_slurpy_hash

Using L<Function::Parameters> with slurpy value then uses coercion over the
whole container inside of the function body.

NOTE: Using C<< ColorElem8 >> here because slurpy types are not checked as
C<ArrayRef>s or C<HashRef>s by L<Function::Parameters>, but by
the elements or values of the containers.

The container type is introspected to find the keys.

This differs from L<Type::Params>. See L</dump_color_type_params_slurpy_hash>.

=cut
fun dump_color_func_params_slurpy_hash(
		ColorElem8 %color
	) {

	state $container_type = MyColorRGBA;
	state $keys = [ pairkeys( $container_type->find_parent(sub { $_->has_parameters })->parameters->@* ) ];
	# $keys = [ qw(red green blue alpha) ]
	%color = $container_type->assert_coerce(\%color)->%*;

	_dump_color_driver([
		map { uc substr($_,0,1) => $color{$_} } @$keys
	]);
}

=head2 dump_color_func_params_named_params

Using L<Function::Parameters> with named parameters.

Uses L<Function::Parameters> introspection to get the names of the variables.
Assumes that the order needed for output is required parameters followed by
optional parameters.

=cut
fun dump_color_func_params_named_params(
		ColorElem8 :$red,
		ColorElem8 :$green,
		ColorElem8 :$blue,
		ColorElem8 :$alpha = 255
	) {

	state $info = Function::Parameters::info(__SUB__);
	state $vars = [ map { $_->name } $info->named_required, $info->named_optional ];
	# $vars = [ qw($red $green $blue $alpha) ]

	my $pad = peek_my(0);
	_dump_color_driver([
		map {
			uc substr($_,1,1) =>
			# Yes, this is bad...
			$pad->{$_}->$*
		} @$vars
	]);
}

=head2 dump_color_type_params_slurpy_hash

Uses L<Type::Params> to define signature types with coercion.

Introspection of signature not possible here since L<Type::Params> only works
with C<CodeRef>s.

=cut
{
# no introspection of signature :-(
my $container_type = MyColorRGBA;
signature_for dump_color_type_params_slurpy_hash => (
	pos => [ Slurpy[ $container_type ] ]
);
sub dump_color_type_params_slurpy_hash( $color )  {
	state $keys = [ pairkeys( $container_type->find_parent(sub { $_->has_parameters })->parameters->@* ) ];
	# $keys = [ qw(red green blue alpha) ]

	_dump_color_driver([
		map { uc substr($_,0,1) => $color->{$_} } @$keys
	]);
}
}


fun run_dump( CodeRef $cb ) {
	say "@{[ '='x80 ]}\nUsing @{[ subname($cb) ]}";

	my $fmt = "%45s: ";
	print sprintf($fmt, "Optional alpha");
	$cb->( red => 255, green => 50, blue => 100 );

	print sprintf($fmt, "All keys");
	$cb->( red => 255, green => 50, blue => 100, alpha => 10 );

	eval { $cb->( ); 1 }
		or warn sprintf("$fmt%s", "Expect failure from empty", $@ =~ /(.*)/);

	eval { $cb->( red => 255 ); 1 }
		or warn sprintf("$fmt%s", "Expect failure from missing green and blue", $@ =~ /(.*)/);

	eval { $cb->( red => 1024, green => 1024, blue => 1024 ); 1 }
		or warn sprintf("$fmt%s", "Expect failure from out of bounds values", $@ =~ /(.*)/);
}

sub main {
	run_dump( \&dump_color_func_params_slurpy_hash );

	run_dump( \&dump_color_func_params_named_params );

	run_dump( \&dump_color_type_params_slurpy_hash );
}

main;
