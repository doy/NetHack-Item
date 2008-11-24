#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 9;
use NetHack::ItemPool;

my $pool = NetHack::ItemPool->new;
my $tracker = $pool->tracker_for($pool->new_item("a scroll labeled KIRJE"));
is(scalar($tracker->possibilities), 21, "there are 21 randomized scrolls");
ok($tracker->includes_possibility('scroll of fire'), "KIRJE is possibly fire");

$tracker->rule_out('scroll of fire');
is(scalar($tracker->possibilities), 20, "we ruled out scroll of fire");
is((grep { $_ eq 'scroll of fire' } $tracker->possibilities), 0, "no scroll of fire possibilities");
ok(!$tracker->includes_possibility('scroll of fire'), "KIRJE is not fire");

$tracker->identify_as('scroll of genocide');
is(scalar($tracker->possibilities), 1, "we identified as genocide");
ok(!$tracker->includes_possibility('scroll of fire'), "KIRJE is not fire");
ok(!$tracker->includes_possibility('scroll of punishment'), "KIRJE is not punishment");
ok($tracker->includes_possibility('scroll of genocide'), "KIRJE is genocide!");

