#!/usr/bin/perl
use v5.18;
use strict;
use warnings;
use Circle;

#working on the circle figure...
my $circleCenter = Point::->new('x' => 0, 'y' => 0);
my $circlePoint = Point::->new('x' => 4, 'y' => 4);

my $c = Circle::->new(('center' => $circleCenter, 'point' => $circlePoint));

$c->draw();
$c->area();



