#!/usr/bin/perl
use v5.18;
use strict;
use warnings;
use Shape;
use Circle;
use Rectangle;
use Square;
use Triangle;
use Data::Dumper;
use DBI;

my $command = shift @ARGV;
my @points;
my $f;
my $created = 0;
my $dbh = DBI->connect("DBI:mysql:database=ex7;host=localhost", 'root', '', { 'RaiseError' => 1, 'AutoCommit' => 0 });

unless ($command eq 'list') {
    #parse the points...
    while(my $arg = shift @ARGV){
        my ($x, $y) = split(",", $arg);

        if($x > 300 || $y > 300){
            die "allowed grid is 300x300 so x and y both must be lower than 300";
        }

        my $point = Point::->new('x' => $x, 'y' => $y);
        $points[scalar @points] = $point;

    }
}

#main logic...
given($command){
    when('circle'){
        if(scalar @points < 2) {
            die "to create a circle you must supply the center and the radius\n";
        }

        $f = Circle::->new(('p1' => $points[0], 'p2' => $points[1]));
        $f->save(('dbh' => $dbh));
        $created = 1;
    }
    when('rectangle') {
        if(scalar @points < 4) {
            die "to create a circle you must supply the center and the radius\n";
        }

        $f = Rectangle::->new(('p1' => $points[0], 'p2' => $points[1], 'p3' => $points[2], 'p4' => $points[3]));
        $f->save(('dbh' => $dbh));
        $created = 1;
    }
    when('triangle') {
        if(scalar @points < 3) {
            die "to create a triangle you must supply 3 points\n";
        }

        $f = Triangle::->new(('p1' => $points[0], 'p2' => $points[1], 'p3' => $points[2]));
        $f->save(('dbh' => $dbh));
        $created = 1;
    }
    when('square') {
        if(scalar @points < 4) {
            die "to create a square you must supply the 4 points\n";
        }

        $f = Square::->new(('p1' => $points[0], 'p2' => $points[1], 'p3' => $points[2], 'p4' => $points[3]));
        $f->save(('dbh' => $dbh));
        $created = 1;
    }
    when('list') {
        my $stmt    = $dbh->prepare("SELECT * FROM figure");
        my $stmt2   = $dbh->prepare("SELECT * FROM point WHERE id_figure=?");
        $stmt->execute();
        while( my $row = $stmt->fetchrow_hashref()) {
            my %h = %{ $row };
            $stmt2->execute($h{'id'});
            my %points;

            my $i = 1; #TODO: finish the point collection and jump into figure creation...
            while(my $prow = $stmt2->fetchrow_hashref()) {
                my %h2 = %{ $prow };
                $
            }

            given($h{'type'}) {
                when('Circle') {

                }
                when('Rectangle') {

                }
                when('Square') {

                }
                when('Triangle') {

                }
                default{
                    die "Unregistered figure type, do not know how to handle a $h{'type'}\n";
                }
            }
        }
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

$dbh->disconnect();
