#!/usr/bin/env perl
package NetHack::Item::Weapon;
use Moose;
extends 'NetHack::Item';
with 'NetHack::Item::Role::Enchantable';

use constant type => "weapon";

__PACKAGE__->meta->make_immutable;
no Moose;

1;

