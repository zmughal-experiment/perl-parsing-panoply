package B::PPP::Util;
# ABSTRACT: Utilities

use strict;
use warnings;

use B;

our @PHASES = qw(
	BEGIN
	UNITCHECK
	CHECK
	INIT
	END
);

our %PHASE_TO_AV = (
	BEGIN     => B::begin_av,
	UNITCHECK => B::unitcheck_av,
	CHECK     => B::check_av,
	INIT      => B::init_av,
	END       => B::end_av,
);

sub get_phase_av {
	my ($class, $phase_name) = @_;
	die "Phase $phase_name does not exist"
		unless exists $PHASE_TO_AV{$phase_name};
	return $PHASE_TO_AV{$phase_name};
}

sub get_phases_in_order { return @{[ @PHASES ]} };

1;
