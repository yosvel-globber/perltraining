#!/usr/bin/perl
use v5.18;
use strict;
use warnings;
use Circle;
use Rectangle;
use Square;
use Triangle;
use Data::Dumper;

my $command = shift @ARGV;
my @points;
my $f;
my $created = 0;

print Dumper $command;

#parse the points...
while(my $arg = shift @ARGV){
    my ($x, $y) = split(",", $arg);

    if($x > 300 || $y > 300){
        die "allowed grid is 300x300 so x and y both must be lower than 300";
    }

    my $point = Point::->new('x' => $x, 'y' => $y);
    $points[scalar @points] = $point;

}

print Dumper @points;
print Dumper scalar @points;

#main logic...
given($command){
    when('circle'){
        if(scalar @points < 2) {
            die "to create a circle you must supply the center and the radius\n";
        }

        $f = Circle::->new(('center' => $points[0], 'point' => $points[1]));
        $created = 1;
    }
    when('rectangle') {
        if(scalar @points < 4) {
            die "to create a circle you must supply the center and the radius\n";
        }

        $f = Rectangle::->new(('p1' => $points[0], 'p2' => $points[1], 'p3' => $points[2], 'p4' => $points[3]));
        $created = 1;
    }
    when('triangle') {
        if(scalar @points < 3) {
            die "to create a triangle you must supply 3 points\n";
        }

        $f = Triangle::->new(('p1' => $points[0], 'p2' => $points[1], 'p3' => $points[2]));
        $created = 1;
    }
    when('square') {
        if(scalar @points < 4) {
            die "to create a square you must supply the 4 points\n";
        }

        $f = Square::->new(('p1' => $points[0], 'p2' => $points[1], 'p3' => $points[2], 'p4' => $points[3]));
        $created = 1;
    }
    default {
        print "Usage:\n";
        print "perl program.pl <command> <arguments>\n";
        print "where command is one of rectangle, circle, triangle, square\n";
        print "and arguments are points in the form x,y\n";
        print "example: perl program.pl circle 40,40 70,70\n";
    }
}

if($created){
    $f->draw();
}
