#!/usr/bin/perl
use v5.18;
use strict;
use Data::Dumper;

=pod

1  function Dijkstra(Graph, source):
2
3      create vertex set Q
4
5      for each vertex v in Graph:             // Initialization
6          dist[v] ← INFINITY                  // Unknown distance from source to v
7          prev[v] ← UNDEFINED                 // Previous node in optimal path from source
8          add v to Q                          // All nodes initially in Q (unvisited nodes)
9
10      dist[source] ← 0                        // Distance from source to source
11      
12      while Q is not empty:
13          u ← vertex in Q with min dist[u]    // Source node will be selected first
14          remove u from Q 
15          
16          for each neighbor v of u:           // where v is still in Q.
17              alt ← dist[u] + length(u, v)
18              if alt < dist[v]:               // A shorter path to v has been found
19                  dist[v] ← alt 
20                  prev[v] ← u 
21
22      return dist[], prev[]

=cut

#uniform cost variation ( all path cost 1 ).
sub dijktra {
	my (%params)    = @_;
    #my @graph 	    = $params{'graph'};
    #my $origin 	    = $params{'origin'};
    #my $destination = $params{'destination'};

    #my @vertexs;        #list of vertex
    #my %distance;       #distance from source to  to each vertex.
    #my %previous;       #previous node in optimal path.

    #dumping ....
    print Dumper(@_);
    #the process subroutines...
=pod
    for my $edge (0..@graph) {
        say "edge value  = $edge";
        
        my($v1, $v2) = @{ $graph[$edge] };
        
        #dumping ...
        say "edge $edge: $v1 -> $v2\n";
        #end dumping ...
    }
=cut
}

my @graph;
my $line;

my $fn = $ARGV[0] || die "enter a filename with target and graph definition";

open(my $fh, "<", $fn) || die "can't open $fn: $!";

chomp($line = <$fh>);

my ($orig, $dest) = split(" ", $line);

say "printing: origin -> $orig\n";
say "printing: destination -> $dest\n";

while($line = <$fh>) {
	chomp($line);
    last if !$line;
	my ($v1, $v2) = split(" ", $line);
	$graph[scalar(@graph)] = [ $v1, $v2 ];
}


for my $edge (0..$#graph) {

	my ($s, $e) = @{ $graph[$edge] };
	print "\t$s => $e\n";

}

my (%params) = [ 'graph' => \@graph, 'origin' => $orig, 'destination' => $dest ];

dijktra(%params);

say "done!...";
