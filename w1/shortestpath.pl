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
    #print "\n\n---- INSIDE DIJKTRA ----\n";

    my (%params)    = @_;

    #this is a tricky and headache prone line for newbies... as the matter of fact: what was really passed in this 
    #hash value was a reference to an array (inside a hash) created in the call to dijktra, so to get the real
    #array I had to de-reference the hash value in here in a list context. 
    my @graph 	    = @{ $params{'graph'} };
    
    my $origin 	    = $params{'origin'};
    my $destination = $params{'destination'};

    my @vertexs;        #list of vertex
    my %distance;       #distance from source to  to each vertex.
    my %previous;       #previous node in optimal path.

    #print Dumper(@graph);
    #print Dumper($origin);
    #print Dumper($destination);

    #dumping ....
    #print Dumper(%params);
    #the process subroutines...
    for my $idx (0..$#graph) {
        
        #Again here as this is a nested array reference there is mandatory de-reference the value in $edge.
        my @edge = @{ $graph[$idx] };
        
        for my $v (@edge) {
            my %hystack = map { $_ => 1 } @vertexs;
            
            if(!exists($hystack{$v})) {
                $hystack{$v} = 1;
                @vertexs = keys %hystack;
                $distance{$v} = -1;
                $previous{$v} = -1;
            }
        }
    }

    print "dijktra: vertex list!\n";
    print @vertexs;
    print "\n";
    print "dijktra: distance list\n";
    print %distance;
    print "\n";
    print "dijktra: previous list\n";
    print %previous;
    print "\n";
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
	print "\t$s => $e pointed by $graph[$edge]\n";

}

dijktra(( 'graph' => \@graph, 'origin' => $orig, 'destination' => $dest ));

say "\ndone!...";
