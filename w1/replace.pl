#!/usr/bin/perl 
use v5.18;
use strict;

my %regexs;
my $subject;

say "replace: Please enter 1 line of text";
chomp($subject = <STDIN>);

say "replace: Please, enter space separated strings to match and replace (one pair per line)";
say "replace: Empty line will iterrupt input and start execution";

my $k = 0;
while(1) {
	my $line;
		
	chomp($line = <STDIN>);
	last if !$line;
	
	my ($pattern, $replacement) = split(" ", $line);

	if($pattern && $replacement) {
		$regexs{$pattern} = $replacement;
			
	}
	else {
		print STDERR "invalid rule pattern [ $pattern ] ->  [ $replacement ]  , this rule will be skipped\n";
	}
}

say "replace: starting with the following rules ...";
say "Subject $subject";

for my $key (sort keys %regexs) {
	print "$key => $regexs{$key} \n";
}

my $val;

($val = $subject) =~ s/(@{[join "|", keys %regexs]})/$regexs{$1}/g;

say "Result is $val\n";
say "Done";


