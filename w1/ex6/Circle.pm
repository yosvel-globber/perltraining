package Circle;

use strict;
use warnings;
use parent "Shape";
use Point;
use Data::Dumper;
use constant PI    => 4 * atan2(1, 1);
use Scalar::Util "blessed";

sub new {
    my $invocant = shift;
    my $self = bless ( {}, ref $invocant || $invocant );
    my (%params) = @_;

    if (!("Point" eq (blessed $params{center})) or !("Point" eq (blessed $params{point}))) {
        die "Check parameters passed to Circle::new, they must be references to Point\n";
    }

    $self->{center}   = $params{center};
    $self->{radius}   = $self->{center}->distance('point' => $params{point});

    if(0 == $self->{radius}) {
        die "Not a circle but a point\n";
    }

    return $self;
}

sub draw {
    my $self = shift;
    print "Drawing a circle \n";
    print "center is at ($self->{center}->{x},$self->{center}->{y}) with radius $self->{radius}\n";
}

sub area {
    my $self = shift;
    my $area = PI * ($self->{radius}**2);

    print "Circle area is ${area}\n";
}

for my $field (qw(center point)) {
    my $slot = __PACKAGE__ . "::$field";
    no strict "refs";
    *$slot = sub {
        my $self = shift;
        $slot->{$field} = shift if @_;
        return $slot->{$field};
    }
}

1;
