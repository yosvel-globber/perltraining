package Rectangle;

use strict;
use warnings;
use parent "Shape";
use Point;
use Data::Dumper;

sub new {
    my $invocant = shift;
    my $self = bless ( {}, ref $invocant || $invocant );
    $self->init();
    return $self;
}

sub init {
    my $self = shift;
    $self->{center}   = Point::->new( 'x' => 100, 'y' => 100);
    $self->{point}    = Point::->new( 'x' => 200, 'y' => 100);
}

sub area {
    my $self = shift;
    my $r = $self->{center}->distance("point" => $self->{point});

    print "Circle radius has been calculated $r\n";
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