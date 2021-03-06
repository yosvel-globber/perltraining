#!/usr/bin/perl
# a better implementation would be done via cpan Path::Graph but that would be cheat myself in the process of learn perl.
use v5.18;
use strict;
use Data::Dumper;

#uniform cost variation ( all path cost 1 ).
sub dijktra {
    my ( %params )    = @_;

    #this is a tricky and headache prone line for newbies... as the matter of fact: what was really passed in this
    #hash value was a reference to an array (inside a hash) created in the call to dijktra, so to get the real
    #array I had to de-reference the hash value in here in a list context.
    my @graph 	    = @{ $params{'graph'} };
    my $origin 	    = $params{'origin'};
    my $destination = $params{'destination'};
    my $inf         = -1;

    my @vertexs;        #list of vertex
    my %distance;       #distance from source to  to each vertex.
    my %previous;       #previous node in optimal path.
    my %adj;            #adjacency matrix.

    #initialization of vertex list, distances, and path.
    for my $idx ( 0..$#graph ) {
        #Again here as this is a nested array reference there is mandatory de-reference the value in $edge.
        my @edge = @{ $graph[$idx] };

        for my $i ( 0..$#edge ) {
            my %hystack = map { $_ => 1 } @vertexs;
            my $v = $edge[$i];

            if ( undef == $hystack{$v} ) {
                $hystack{$v} = 1;
                @vertexs = keys %hystack;
                $distance{$v} = $inf;
                $previous{$v} = $inf;
            }
        }
    }

    #build adjacency matrix.
    for my $idx ( 0..$#graph ) {
       my @edge = @{ $graph[$idx] };
        if ( undef == $adj{$edge[0]} ) {
            $adj{$edge[0]} = [];
        }
        push( $adj{$edge[0]}, $edge[1] );
    }

    $distance{$origin} = 0;

    my $solution  = 0;
    my $iteration = 0;
    MAIN: while( $#vertexs ) {
        my $v = 'undefined';
        #find the vertex with lower dist from source.
        FINDER: for my $k ( @vertexs ) {
            next FINDER if $inf == $distance{$k};

            #if undef == $v it means we are starting a new iteration so assing the first non infinit value and jump to the next for comparisons.
            if ( undef == $v ) {
                $v = $k;
                next FINDER;
            }

            if ( $distance{$k} < $distance{$v} ) {
                $v = $k;
            }
        }

        #a forced stop contition because the distance list was not updated properly.
        last MAIN if 'undefined' eq $v;

        #stop condition found
        if ( $v eq $destination ) {
            $solution = 1;

            my $steps = 0;
            SOLUTION: while($v) {

                print "${v}";
                last SOLUTION if $origin eq $v;
                if ( $previous{$v} ) {
                    print " <- ";
                    $v = $previous{$v};
                }
                else {
                  $v = undef;
                }

                $steps++;
            }

            print "\nsolution found in ${steps} steps";

            last MAIN;
        }

        #remove the current vertex from the vertex list...
        my %tvs = map { $_ => 1 } @vertexs;
        delete $tvs{$v};
        @vertexs = keys %tvs;

        #update solution and distance matrix if needed.
        for my $n ( @{ $adj{$v} } ) {
            my $calc = $distance{$n} == $inf ? 1 : $distance{$v} + 1;       #normally this is not just 1 because this is the cost to go from $v -> $n but as this is uniform cost i leaved it that way.
            if (($distance{$n} == $inf) || ($calc < $distance{$n})) {
                $distance{$n} = $calc;
                $previous{$n} = $v;
            }
        }
    }

    if ( !$solution ) {
        print "-1\n";
        print "solution not found\n";
    }
}

my @graph;
my $line;
my $fn = $ARGV[0] || die "enter a filename with target and graph definition";

open(my $fh, "<", $fn) || die "can't open $fn: $!";

chomp($line = <$fh>);

my ($orig, $dest) = split(" ", $line);

while($line = <$fh>) {
	chomp($line);
    last if !$line;
	my ($v1, $v2) = split(" ", $line);
	$graph[scalar(@graph)] = [ $v1, $v2 ];
}

dijktra(( 'graph' => \@graph, 'origin' => $orig, 'destination' => $dest ));

say "\ndone!...";
