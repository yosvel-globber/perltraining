#!/usr/bin/perl
use v5.18;
use strict;
use bigrat;


#GCD, needed later for lcm calculation.
sub gcd {
	my %params = @_;
	my $a = $params{'A'} || undef;
	my $b = $params{'B'} || undef;
	my $d = 0;

	if( !defined($a) || !defined($b)) {
		print STDERR "Bad method call for gcd function, there is a missing parameter\n";
		exit 1;
	}

	if($a == 0) { 
		return $b 
	} elsif ($b == 0) { 
		return $a 
	} else {
	
		while ( $a % 2 == 0 && $b % 2 == 0 ) {
			$a /= 2;
			$b /= 2;
			$d += 1;
		}

		while ( $a != $b ) {
			if ($a % 2 == 0 ){
				$a /= 2;
			
			}
			elsif ( $b % 2 == 0 ) {
				$b /= 2;
			}
			elsif ( $a > $b ) {
				$a = ($a - $b) / 2;
			}
			else {
				$b = ($b - $a) / 2;
			}
		}

		return  $a * (2**$d);
	}
}

#LCM calculation
sub lcm {
	my %params = @_;
	my $a = $params{'A'};
	my $b = $params{'B'};

	my $lcm = $a * $b / gcd( A => $a, B => $b);	
}

#testing my code ....
#print "Greatest common divisor for 48 and 180 is " . gcd(A => 48, B => 180) . "\n";
#print "Least commom multiple for 48 and 180 is " . lcm(A => 48, B => 180) . "\n";

#calculate the nth prime number;
sub prime {
	my %params = @_;
	my $number = $params{'N'};

	if(1 == $number) {
		return 1;
	}
	else {
		my $prev;
		$prev = prime(N => $number - 1);
		return ($prev + gcd(A => $number, B => $prev)/$prev);
	}
}
#testing my code...

say "prime 5 is " . prime(N => 5);

__END__

say "Bring me a number between 2 and 1000000\n";

my $n;

chomp($n = <STDIN>);

unless( 0 + $n >= 2) {
	say "Asked you about a number between 2 and 1000000, and you bring $n :\nPlease try again...\n";
	chomp($n = <STDIN>);
}

say "Prime numbers < $n are:\n";

$p = 1
while($p){
	print "\t$p\n";
	$p = prime($p + 1);
	last if $p > $n; 
}

say "done!\n";

