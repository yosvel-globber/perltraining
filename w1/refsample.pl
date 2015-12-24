#!/bin/perl -w

use strict;

sub PrintAA
{
    my($test, %aa) = @_;
    print $test . "\n";
    foreach (keys %aa)
    {
        print $_ . " : " . $aa{$_} . "\n";
    }
}

my(%hash) = ( 'aaa' => 1, 'bbb' => 'balls', 'ccc' => \&PrintAA );

PrintAA("test", %hash);
