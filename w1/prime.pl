#!/usr/bin/perl
use v5.18;
use strict;


say "Welcome to prime number generator, please enter a number between 2 and 1000000";
my $number;

chomp($number = <STDIN>);

$number = 0 + $number;

if(2 <= $number && 1000000 >= $number) {
  OUTER: for my $n (2 .. $number) {
    #say "analizing number ${n}";
    my $break = 0;
    INNER: for my $k (2 .. (($n > 2) ? $n - 1 : 2)) {
        #say "\t... probing ${k}";
        $break = ($n % $k == 0);
        last INNER if $break;
    }

    if($n < $number){
      if(!$break){
        say "${n}";
      }
    }
    else{
      last OUTER;
    }
  }
}
