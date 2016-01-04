#!/usr/bin/perl
use v5.18;
use strict;
use warnings;
use Circle;
use Rectangle;
use Square;
use Triangle;

#working on the circle figure...
my $circleCenter = Point::->new('x' => 0, 'y' => 0);
my $circlePoint = Point::->new('x' => 50, 'y' => 50);

my $c = Circle::->new(('center' => $circleCenter, 'point' => $circlePoint));

$c->draw();
$c->area();

#working on a rectangle now...
my $r1p = Point::->new('x' => 60, 'y' => 60);
my $r2p = Point::->new('x' => 320, 'y' => 60);
my $r3p = Point::->new('x' => 320, 'y' => 120);
my $r4p = Point::->new('x' => 60, 'y' => 120);

my $rect = Rectangle::->new(('p1' => $r1p, 'p2' => $r2p, 'p3' => $r3p, 'p4' => $r4p));

$rect->draw();
$rect->area();

#working on a square now...
my $s1p = Point::->new('x' => 100, 'y' => 100);
my $s2p = Point::->new('x' => 200, 'y' => 100);
my $s3p = Point::->new('x' => 200, 'y' => 200);
my $s4p = Point::->new('x' => 100, 'y' => 200);

my $square = Square::->new(('p1' => $s1p, 'p2' => $s2p, 'p3' => $s3p, 'p4' => $s4p));

$square->draw();
$square->area();

#working on a triangle now...
my $t1p = Point::->new('x' => 100, 'y' => 100);
my $t2p = Point::->new('x' => 100, 'y' => 260);
my $t3p = Point::->new('x' => 230, 'y' => 280);

my $triangle = Triangle::->new(('p1' => $t1p, 'p2' => $t2p, 'p3' => $t3p));

$triangle->draw();
$triangle->area();
