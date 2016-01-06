package Rectangle;

use strict;
use warnings;
use parent "Shape";
use Point;
use Data::Dumper;
use Scalar::Util "blessed";
use GD::Simple;

sub new {
    my $invocant = shift;
    my $self = bless ( {}, ref $invocant || $invocant );
    my %params = @_;

    if (!("Point" eq (blessed $params{'p1'})) or !("Point" eq (blessed $params{'p2'})) or !("Point" eq (blessed $params{'p3'})) or !("Point" eq (blessed $params{'p4'}))) {
        die "Check parameters passed to Rectangle::new, they must be references to Point\n";
    }

    $self->SUPER::new(@_);
    #todo check it it is a rectangle... will make some assumptions here as time is against me!
    $self->{'color'} = "blue";
    return $self;
}

sub area {
    my $self = shift;
    my $a = $self->{'points'}->[0]->distance("point" => $self->{'points'}->[1]);
    my $b = $self->{'points'}->[1]->distance("point" => $self->{'points'}->[2]);

    my $area = $a * $b;

    return $area;
}

sub draw {
    my $self = shift;
    my $area = $self->area();

    my $img = GD::Simple::->new(400, 400);
    $img->bgcolor($self->{'color'});
    $img->fgcolor($self->{'color'});

    my $a = $self->{'points'}->[0];
    my $c = $self->{'points'}->[2];

    #draw the rectangle...
    $img->rectangle($a->{'x'}, $a->{'y'}, $c->{'x'}, $c->{'y'});

    #draw the text...
    $img->moveTo(50, 300);
    $img->font('Times:italic');
    $img->fontsize(10);
    $img->string("Rectangle area is ${area}");

    my $filename = "rectangle_" . time() . ".png";
    open(my $fh, ">", $filename );
    print $fh $img->png;
    close($fh);

    print "rectangle image writen to ${filename}\n";
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
