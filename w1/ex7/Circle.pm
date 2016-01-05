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

    if (!("Point" eq (blessed $params{'p1'})) or !("Point" eq (blessed $params{'p2'}))) {
        die "Check parameters passed to Circle::new, they must be references to Point\n";
    }

    $self->SUPER::new(@_);

    $self->{'radius'}   = $self->{'points'}->[0]->distance('point' => $self->{'points'}->[1]);
    $self->{'color'}    = "red";

    if(0 == $self->{'radius'}) {
        die "Not a circle but a point\n";
    }

    return $self;
}

sub draw {
    my $self = shift;
    my $area = $self->area();

    my $center  = $self->{'points'}->[0];
    my $width   = int($center->{'x'} + $self->{'radius'} + 100);
    my $height  = int($center->{'y'} + $self->{'radius'} + 100);

    my $img = GD::Simple::->new($width, $height);
    $img->bgcolor($self->{'color'});
    $img->fgcolor($self->{'color'});

    #draw the ellipse...
    $img->moveTo($center->{'x'}, $center->{'y'});
    $img->ellipse($self->{'radius'}, $self->{'radius'});

    #draw the text...
    $img->moveTo(10, $height - 50);
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

sub load {
    my %params = @_;
    my $dbh = $params{'dbh'};
    my $id  = $params{'id'};




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
