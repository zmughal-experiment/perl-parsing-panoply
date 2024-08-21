package Local::Type::Color;
# ABSTRACT: Color type library

use strict;
use warnings;

use Type::Library 0.008 -base,
	-declare => [qw(
		ColorElem8
		ColorRGB24
		ColorRGBA32

		ColorRGBA32OptAlpha

		MyColorRGBA
	)];
use Type::Utils -all;

# Listed here so that scan-perl-deps can find them
use Types::Common        qw(IntRange Dict Optional);

use Type::Libraries;
Type::Libraries->setup_class(
	__PACKAGE__,
	qw(
		Types::Common
	)
);

my $ColorElem8 =
declare ColorElem8 =>
	as IntRange[0,255];

my @rgb_keys = qw(red green blue);
my $alpha_key = q'alpha';

my $ColorRGB24 =
declare ColorRGB24 => as
	Dict[ map { $_ => $ColorElem8 } @rgb_keys ];

my $ColorRGBA32 =
declare ColorRGBA32 => as
	Dict[
		( map { $_ => $ColorElem8 } @rgb_keys ),
		 $alpha_key => $ColorElem8,
	];

# Default alpha to opaque when coerced from ColorRGB24.
my $ColorRGBA32OptAlpha =
declare_coercion ColorRGBA32OptAlpha =>
	to_type 'ColorRGBA32',
	from 'ColorRGB24',
	q{ +{ %$_, alpha => 255 } };

declare 'MyColorRGBA',
	as $ColorRGBA32->plus_coercions($ColorRGBA32OptAlpha),
	coercion => 1;

1;
