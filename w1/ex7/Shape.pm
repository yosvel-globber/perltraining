package Shape;

use strict;
use warnings;
use Data::Dumper;
use Scalar::Util "blessed";

sub draw{ print "a generic shape can not be drawn \n"; };
sub area{ print "a generic shape does not have area\n"; };
sub load{ print "can not load a generic chape\n"; }

sub new {
    my $self = shift;
    my %params = @_;
    my @points;

    $self->{'type'} = blessed $self;

    for my $key (sort keys %params) {
        $points[scalar @points] = $params{$key};
    }

    $self->{'points'} = \@points;
    $self->{'id'} = undef;
    $self->{'color'} = "yellow";
}

sub save {
    my $self = shift;
    my %params = @_;
    my $dbh = $params{'dbh'};   #database handler...
    my $q;

    if(!defined $dbh) {
        die "passed an undefined database handler to save routine for object of type $self->{'type'}\n";
    }

    print "saving the object of type $self->{'type'}\n";

    $q = "INSERT INTO figure (type, color) VALUES (?, ?)";
    my $sth = $dbh->prepare($q);
    $sth->execute($self->{'type'}, $self->{'color'});
    $self->{'id'} = $dbh->last_insert_id(undef, undef, undef, undef);
    $dbh->commit();

    my $qp = "INSERT INTO point (id_figure, x, y) VALUES (?, ?, ?)";
    $sth = $dbh->prepare($qp);

    #take care of the points...
    for my $point (@{$self->{'points'}}) {
        $sth->execute($self->{'id'}, $point->{'x'}, $point->{'y'});
        $dbh->commit();
    }
}

1;
