#!/usr/bin/perl
use v5.18;
use strict;
use Lingua::EN::Words2Nums;

my $fn = $ARGV[0] || die "Must pass the data filename";
my %engNrs;

open(my $fh, "<", $fn) || die "can't open $fn: $!";;

# load every line of the file. and convert it to a number. then add the line to a hash with the number as a key.
while(my $line  = <$fh>) {
  my $number = words2nums($line);
  $engNrs{$number} = $line;
}

#sort the lists
my @sorted = reverse sort {$a <=> $b} keys %engNrs;

#print them back sorted.
for my $k (@sorted){
  print "$engNrs{$k}\n";
}
