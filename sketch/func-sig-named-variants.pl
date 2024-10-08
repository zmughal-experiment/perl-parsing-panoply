#!/usr/bin/env perl

=head1 DESCRIPTION

Demonstrate different ways of working with named parameters while knowing what
the keys/variables are from inside of the function body.

Note that this example using colors may not be ideal for showing the named
parameters feature as parameters are not always related to each other in terms
of sharing types. In particular, RGB elements represent different dimensions of
an RGB cube, so it would be better to create an C<Object> or C<ArrayRef> and
pass that around as single C<Ref>.

=cut

use v5.28;

use FindBin;
use lib "$FindBin::Bin/lib";

use Syntax::Construct qw(state-array);
use stable v0.032 qw(postderef);
use experimental qw(signatures);

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

{
use Function::Parameters v2;
fun _dump_color_driver( (ArrayRef[Any,(4*2)x2] & CycleTuple[StrLength[1,1],ColorElem8] ) $pairs ) {
	say sprintf "Color: [ %s ]",
		join(", ",
			pairmap { sprintf("%s: 0x%02X", $a, $b) }
			@$pairs );
}
}

=head2 dump_color_base_perl_slurpy_hash

Uses base Perl signatures with C<Type::Tiny> coercion inside.

=cut
sub dump_color_base_perl_slurpy_hash(
		%color
	) {

	state $container_type = MyColorRGBA;
	state @keys = pairkeys( $container_type->find_parent(sub { $_->has_parameters })->parameters->@* );
	# @keys = qw(red green blue alpha)
	%color = $container_type->assert_coerce(\%color)->%*;

	_dump_color_driver([
		map { uc substr($_,0,1) => $color{$_} } @keys
	]);
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
{
use Function::Parameters v2;
fun dump_color_func_params_slurpy_hash(
		ColorElem8 %color
	) {

	state $container_type = MyColorRGBA;
	state @keys = pairkeys( $container_type->find_parent(sub { $_->has_parameters })->parameters->@* );
	# @keys =  qw(red green blue alpha)
	%color = $container_type->assert_coerce(\%color)->%*;

	_dump_color_driver([
		map { uc substr($_,0,1) => $color{$_} } @keys
	]);
}
}

=head2 dump_color_func_params_named_params

Using L<Function::Parameters> with named parameters.

Uses L<Function::Parameters> introspection to get the names of the variables.
Assumes that the order needed for output is required parameters followed by
optional parameters.

=cut
{
use Function::Parameters v2;
fun dump_color_func_params_named_params(
		ColorElem8 :$red,
		ColorElem8 :$green,
		ColorElem8 :$blue,
		ColorElem8 :$alpha = (1<<8)-1
	) {

	state $info = Function::Parameters::info(__SUB__);
	state @vars = map { $_->name } $info->named_required, $info->named_optional;
	# @vars = qw($red $green $blue $alpha)

	# Yes, this is bad...
	my $pad = peek_my(0);
	_dump_color_driver([
		map { uc substr($_,1,1) => $pad->{$_}->$* } @vars
	]);
}
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
	state @keys = pairkeys( $container_type->find_parent(sub { $_->has_parameters })->parameters->@* );
	# @keys = qw(red green blue alpha)

	_dump_color_driver([
		map { uc substr($_,0,1) => $color->{$_} } @keys
	]);
}
}

=head2 dump_color_type_params_named_params

Uses L<Type::Params> to define signature types with named parameters.

Introspection of signature not possible here since L<Type::Params> only works
with C<CodeRef>s.

=cut
{
# Stored here for introspection while keeping the order.
my $named = [
	red   => [ ColorElem8 ],
	green => [ ColorElem8 ],
	blue  => [ ColorElem8 ],
	alpha => [ ColorElem8, { default => (1<<8)-1 } ],
];
signature_for dump_color_type_params_named_params => (
	named => [ pairmap { $a => @$b } @$named ],
	bless => !!1,
);
sub dump_color_type_params_named_params( $args )  {
	state @keys = pairkeys @$named;
	# @keys = qw(red green blue alpha)

	_dump_color_driver([
		map { uc substr($_,0,1) => $args->{$_} } @keys
	]);
}
}

=head2 dump_color_moox_struct_slurpy_hash

This uses a slurpy hash, but puts it into a L<MooX::Struct> object (which uses
a blessed C<ArrayRef>). Since these parameters do go together, they are better
stored in a single object.

This does not use the C<MyColorRGBA> C<Type::Tiny> check for coercion.

=cut
use MooX::Struct -retain =>
	MyColorRGBA_Struct => [
		'red!'   => [ isa => ColorElem8 ],
		'green!' => [ isa => ColorElem8 ],
		'blue!'  => [ isa => ColorElem8 ],
		alpha    => [ isa => ColorElem8, default => (1<<8)-1 ],

		_dump_color_driver_args => sub {
			map { uc substr($_,0,1) => $_[0]->{$_} } $_[0]->FIELDS
		}
	];
sub dump_color_moox_struct_slurpy_hash( %color )  {
	my $_color = MyColorRGBA_Struct->new( %color );

	_dump_color_driver([
		$_color->_dump_color_driver_args
	]);
}

=head2 dump_color_kavorka_slurpy_hash

Uses L<Kavorka> to define a subroutine with a slurpy hash
parameter.

Note that the input is slurpy (a hash) and placed into a C<HashRef> container
which is checked and coerced all in the signature. As opposed to the approach
in L<Function::Parameters> at L</dump_color_func_params_slurpy_hash>, the whole
container type is used rather than just the values.

The signature is then introspected to get the keys.

Also note that the introspection provides all the parameters in order in a
single list instead of splitting into C<named_required> and C<named_optional>.

=cut
{
use Kavorka;
fun dump_color_kavorka_slurpy_hash ( MyColorRGBA $color is slurpy does coerce ) {
	state $info = Kavorka->info(__SUB__);
	state $container_type = $info->signature->params->[0]->type;
	state @keys = pairkeys( $container_type->find_parent(sub { $_->has_parameters })->parameters->@* );

	_dump_color_driver([
		map { uc substr($_, 0, 1) => $color->{$_} } @keys
	]);
}
}

=head2 dump_color_kavorka_named_params

Uses L<Kavorka> to define a subroutine with named parameters.

The signature is then introspected to get the variables.

Note that the named parameters without defaults must be marked as required via
a postfix C<!> otherwise they can be C<undef> despite the type not being
C<Maybe[ColorElem8]>.

=cut
{
use Kavorka;
fun dump_color_kavorka_named_params(
		ColorElem8 :$red!,
		ColorElem8 :$green!,
		ColorElem8 :$blue!,
		ColorElem8 :$alpha = (1<<8)-1
	) {

	state $info = Kavorka->info(__SUB__);
	state @vars = map { $_->name } $info->signature->params->@*;
	# @vars = qw($red $green $blue $alpha)

	# Yes, this is bad...
	my $pad = peek_my(0);
	_dump_color_driver([
		map { uc substr($_,1,1) => $pad->{$_}->$* } @vars
	]);
}
}

{
use Function::Parameters v2;
fun run_dump( CodeRef $cb ) {
	say "@{[ '='x80 ]}\nUsing @{[ subname($cb) ]}";

	my $fmt = "%60s: ";
	print sprintf($fmt, "Optional alpha");
	$cb->( red => 255, green => 50, blue => 100 );

	print sprintf($fmt, "All keys");
	$cb->( red => 255, green => 50, blue => 100, alpha => 10 );

	eval { $cb->( ); 1 }
		or warn sprintf("$fmt%s", "Expect failure from empty", $@ =~ /(.*)/);

	eval { $cb->( red => 255 ); 1 }
		or warn sprintf("$fmt%s", "Expect failure from missing green and blue", $@ =~ /(.*)/);

	eval { $cb->( red => 255, groen => 1, bleu => 65 ); 1 }
		or warn sprintf("$fmt%s", "Expect failure from missing green and blue (typo, thinko)", $@ =~ /(.*)/);

	eval { $cb->( red => 1024, green => 1024, blue => 1024 ); 1 }
		or warn sprintf("$fmt%s", "Expect failure from out of bounds values", $@ =~ /(.*)/);
}
}

sub main {
	for my $cb (
		\&dump_color_base_perl_slurpy_hash,

		\&dump_color_func_params_slurpy_hash,

		\&dump_color_func_params_named_params,

		\&dump_color_type_params_slurpy_hash,

		\&dump_color_type_params_named_params,

		\&dump_color_moox_struct_slurpy_hash,

		\&dump_color_kavorka_slurpy_hash,

		\&dump_color_kavorka_named_params,
	) {
		run_dump( $cb );
	}
}

main;
