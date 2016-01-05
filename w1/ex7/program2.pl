#!/usr/bin/perl
use v5.18;
use strict;
use warnings;
use EightSided;
use Point;
use Data::Dumper;

my %arguments;

#parse the points...
my $i = 0;
while(my $arg = shift @ARGV){
    my ($x, $y) = split(",", $arg);

    if($x > 300 || $y > 300){
        die "allowed grid is 300x300 so x and y both must be lower than 300";
    }

    my $point = Point::->new('x' => $x, 'y' => $y);
    $arguments{'p' . $i} = $point;
    $i++;
}

my $es = EightSided::->new(%arguments);
$es->save();
