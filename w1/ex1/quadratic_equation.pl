#!/usr/bin/perl 
use v5.18;
use strict;
use Math::Complex;

say "Welcome to quadratic equation solver\n";

my $a = ($ARGV[0]) || 0;
my $b = ($ARGV[1]) || 0;
my $c = ($ARGV[2]) || 0;

if(0 != $a) {

	my $d = $b**2-4*$a*$c;
	my $x1;
	my $x2;

	$x1 = 1/(2*$a) * (-$b + sqrt($d));
	$x2 = 1/(2*$a) * (-$b - sqrt($d));

	print STDOUT "the equation roots are x1=$x1 and x2=$x2\n";		
	exit 0;
}
	
print STDERR "the quadratic equation can not be solved as A = 0\n";

exit 1;	
