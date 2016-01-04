package Point;

use strict;
use warnings;
use Data::Dumper;

sub new {
    my $invocant =  shift;
    my $self = bless({}, ref $invocant || $invocant);
    my %values = @_;

    $self->{x} =  $values{x};
    $self->{y} =  $values{y}; 
    
    return $self;
}

=pod
Calculate distance between 2 points.
=cut
sub distance {

    my $self = shift;
    my (%params) = @_;
    my $foreignPoint = $params{point};

    my $d = sqrt(($foreignPoint->{x} - $self->{x})**2 + ($foreignPoint->{y} - $self->{x})**2);
    return $d;
}


=pod
Dynamic getter/setter generators.
=cut
for my $field (qw(x y)){
    my $slot = __PACKAGE__ . "::$field";
    no strict "refs";   #make symbolic refs to typeglob works... this is the magic for getters/setters
    *$slot = sub{
        my $self = shift;
        $self->{$field} = shift if @_;
        return $self->{$field};
    }
}

1;
