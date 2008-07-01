#!/usr/bin/env perl
package NetHack::Item;
use Moose;

our $VERSION = '0.01';

has raw => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

sub BUILDARGS {
    my $class = shift;

    if (@_ == 1) {
        return $_[0] if ref($_[0]) eq 'HASH';
        return { raw => $_[0] } if !ref($_[0]);
    }
    else {
        return { @_ };
    }

    confess "I don't know how to handle $class->new(@_)";
}

sub BUILD {
    my $self = shift;
    my $args = shift;

    if ($args->{type}) {
        my $class = "NetHack::Item::" . ucfirst lc $args->{type};
        my $meta = Class::MOP::load_class($class);
        $meta->rebless_instance($self);
    }
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=head1 NAME

NetHack::Item - ???

=head1 VERSION

Version 0.01 released ???

=head1 SYNOPSIS

    use NetHack::Item;

=head1 DESCRIPTION



=head1 AUTHOR

Shawn M Moore, C<< <sartak at gmail.com> >>

=head1 BUGS

No known bugs.

Please report any bugs through RT: email
C<bug-nethack-item at rt.cpan.org>, or browse
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=NetHack-Item>.

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Shawn M Moore.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

