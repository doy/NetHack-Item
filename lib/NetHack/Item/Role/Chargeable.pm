#!/usr/bin/env perl
package NetHack::Item::Role::Chargeable;
use Moose::Role;
use MooseX::AttributeHelpers;

has recharges => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has charges => (
    metaclass => 'Number',
    is        => 'rw',
    isa       => 'Int',
    predicate => 'charges_known',
    clearer   => 'set_charges_unknown',
    provides  => {
        'sub' => 'subtract_charges',
    },
);

has charges_spent_this_recharge => (
    metaclass => 'Number',
    is        => 'rw',
    isa       => 'Int',
    default   => 0,
    provides  => {
        add => 'add_charges_spent_this_recharge',
    },
);

sub spend_charge {
    my $self = shift;
    my $count = shift || 1;

    $self->add_charges_spent_this_recharge($count);

    return unless $self->charges_known;
    $self->subtract_charges($$count);
    if ($self->charges < 0) {
        $self->charges(0);
    }
}

sub recharge {
    my $self = shift;

    $self->set_charges_unknown;
    $self->recharges($self->recharges + 1);
}

sub chance_to_recharge {
    my $self = shift;
    my $n = $self->recharges;

    # can always recharge at 0 recharges
    return 100 if $n == 0;

    # can recharge /oW only once
    return 0 if $self->match(identity => 'wand of wishing');

    # (n/7)^3
    return 100 - int(100 * (($n/7) ** 3));
}

no Moose::Role;

1;
