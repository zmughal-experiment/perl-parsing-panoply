package B::PPP::Dump;
# ABSTRACT: Dump optree

use strict;
use warnings;
use B qw( class ppname main_cv main_root );
use B::Utils 0.27 qw(walkoptree_simple all_roots );
use B::PPP::Util;

use Scalar::Util qw(reftype);
use JSON::MaybeXS qw(encode_json);
use IO::File;

sub new {
	my $class = shift;

	my @params = @_;

	my %this;
	while( @params ) {
		my $switch = shift @params;
		if( $switch eq '-o' ) {
			$this{params}{output} = shift @params;
		}
	}

	die "Must specify output file with -o" unless $this{params}{output};

	my $file = IO::File->new($this{params}{output}, 'w')
		or die "Could not open file $this{params}{output}";
	$this{params}{output_file} = $file;

	$this{todo} = [];
	$this{data} = [];

	bless \%this, $class;
}

sub add_phase {
	my ($self, $name) = @_;
	my $phase_av = B::PPP::Util->get_phase_av( $name );
	return unless $phase_av->isa('B::AV');
	my @phase_cvs = $phase_av->ARRAY;
	for my $index (0..$#phase_cvs) {
		push @{ $self->{todo} }, {
			cv => $phase_cvs[$index],
			metadata => {
				type        => 'phase',
				phase       => $name,
				phase_index => $index,
			},
		};
	}
}

sub add_start {
	my $self = shift;
	my $start = shift;
	if( reftype($start) eq 'CODE' ) {

	}
}

sub compile {
	my @args = @_;
	return sub {
		my $self = __PACKAGE__->new(@args);
		$self->add_phase('BEGIN');

		push @{ $self->{todo} }, {
			cv       => main_cv,
			root     => main_root,
			metadata => {
				type => 'main',
			}
		};

		while( my $next = shift @{ $self->{todo} }) {
			local $self->{cur_cv} = delete $next->{cv};
			local $self->{cur_root} = exists $next->{root}
				? delete $next->{root}
				: $self->{cur_cv}->ROOT;
			$next->{tree} = walkops($self->{cur_root}, $self);
			push @{ $self->{data} }, $next;
		}

		for my $file ($self->{params}{output_file}) {
			print {$file} encode_json($self->{data});
			$file->close;
		}
	};
}

sub padname_sv {
    my ($self, $targ) = @_;
    return $self->{cur_cv}->PADLIST->ARRAYelt(0)->ARRAYelt($targ);
}

sub padname {
    my ($self, $targ) = @_;
    return padname_sv($self, $targ)->PVX;
}

sub walkops {
	my ($op, $self) = @_;

	my $data = {};

	return $data unless $$op;

	$data->{node} = {
		name     => $op->name,
		meta     => {
			flags    => $op->flags,
			class    => class($op),
			(
				$op->name eq 'padsv'
					? ( padname  => padname($self, $op->targ ) )
					: ()
			),
			(
				$op->name eq 'const'
					? ( sv  => {
						( $op->sv->can('as_string')
							? ( as_string => $op->sv->as_string ) : () ),
						( $op->sv->can('NV')
							? ( NV => $op->sv->NV ) : () ),
						type   => $op->sv->SvTYPE,
					})
					: ()
			),
		},
		children => [
			map walkops($_, $self), $op->kids,
		]
	};

	return $data;
}

1;
