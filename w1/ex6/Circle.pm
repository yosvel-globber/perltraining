package Circle;

use strict;
use warnings;
use parent "Shape";
use Point;
use Data::Dumper;
use constant PI    => 4 * atan2(1, 1);
use Scalar::Util "blessed";
use GD::Simple;

sub new {
    my $invocant = shift;
    my $self = bless ( {}, ref $invocant || $invocant );
    my (%params) = @_;

    if (!("Point" eq (blessed $params{'center'})) or !("Point" eq (blessed $params{'point'}))) {
        die "Check parameters passed to Circle::new, they must be references to Point\n";
    }

    $self->{'center'}   = $params{'center'};
    $self->{'radius'}   = $self->{'center'}->distance('point' => $params{'point'});

    if(0 == $self->{'radius'}) {
        die "Not a circle but a point\n";
    }

    return $self;
}

sub draw {
    my $self = shift;
    my $area = $self->area();

    my $img = GD::Simple::->new(400, 400);
    $img->bgcolor('red');
    $img->fgcolor('red');

    #draw the ellipse...
    $img->moveTo(200, 200);
    $img->ellipse($self->{'radius'} * 2, $self->{'radius'} * 2);

    #draw the text...
    $img->moveTo(50, 300);
    $img->font('Times:italic');
    $img->fontsize(10);
    $img->string("Circle area is ${area}");

    my $filename = "circle_" . time() . ".png";
    open(my $fh, ">", $filename );
    print $fh $img->png;
    close($fh);

    print "circle image writen to ${filename}\n";
}

sub area {
    my $self = shift;
    my $area = PI * ($self->{'radius'}**2);
    return $area;
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
