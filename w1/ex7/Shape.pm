package Shape;

use strict;
use warnings;
use Data::Dumper;
use Scalar::Util "blessed";
use Point;

sub draw{ print "a generic shape can not be drawn \n"; };
sub area{ print "a generic shape does not have area\n"; };
sub init{};

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


sub load {
        my $self    = shift;
        my %params  = @_;
        my $dbh     = $params{'dbh'};
        my $id      = $params{'id'};
        my $class   = blessed $self;
        my $ret     = 0;
        my $stmt    = $dbh->prepare("SELECT * FROM figure WHERE id=?");

        $stmt->execute($id);

        if(my $h = $stmt->fetchrow_hashref()) {
            my %row = %{$h};
            $self->{'id'}   = $row{'id'};
            $self->{'type'} = $row{'type'};
            $self->{'color'} = $row{'color'};

            my $stmt2 = $dbh->prepare("SELECT * FROM point WHERE id_figure=?");
            $stmt2->execute($id);

            my @points;
            while(my $hp = $stmt2->fetchrow_hashref()) {
                my %p = %{$hp};
                my $pt = Point::->new('x' => $p{'x'}, 'y' => $p{'y'});
                $points[scalar @points] = $pt;
            }

            $self->{'points'} = \@points;
            $ret = 1;

            $self->init();
        }

        print "load called sucessfully for class $class with id $params{'id'}\n";

        return $ret;
}

1;
