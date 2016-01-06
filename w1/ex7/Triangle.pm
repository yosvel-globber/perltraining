package Triangle;

use strict;
use warnings;
use parent "Shape";
use Point;
use Data::Dumper;
use Scalar::Util "blessed";
use GD::Simple;
use GD::Polygon;

sub new {
    my $invocant = shift;
    my $self = bless ( {}, ref $invocant || $invocant );
    my %params = @_;

    if (!("Point" eq (blessed $params{'p1'})) or !("Point" eq (blessed $params{'p2'})) or !("Point" eq (blessed $params{'p3'}))) {
        die "Check parameters passed to Triangle::new, they must be references to Point\n";
    }

    $self->SUPER::new(@_);
    $self->{'color'} = "black";
    #todo check it it is a triangle... will make some assumptions here as time is against me!

    return $self;
}

sub area {
    my $self = shift;
    my $s1 = $self->{'points'}->[0]->distance("point" => $self->{'points'}->[1]);
    my $s2 = $self->{'points'}->[1]->distance("point" => $self->{'points'}->[2]);
    my $s3 = $self->{'points'}->[2]->distance("point" => $self->{'points'}->[0]);

    #perimeter / 2
    my $s = ($s1 + $s2 + $s3) / 2;

    #using heron's formulae for the most general case as we have only the vertexs.
    my $area = sqrt($s * ($s - $s1) * ($s - $s2) * ($s - $s3));

    return $area;
}

sub draw {
    my $self = shift;
    my $area = $self->area();

    my $img = GD::Simple::->new(400, 400);
    $img->bgcolor($self->{'color'});
    $img->fgcolor($self->{'color'});

    #draw the triangle...
    my $poly = GD::Polygon::->new();
    $poly->addPt($self->{'points'}->[0]->{'x'}, $self->{'points'}->[0]->{'y'});
    $poly->addPt($self->{'points'}->[1]->{'x'}, $self->{'points'}->[1]->{'y'});
    $poly->addPt($self->{'points'}->[2]->{'x'}, $self->{'points'}->[2]->{'y'});
    $img->penSize(1,1);
    $img->polygon($poly);

    #draw the text...
    $img->moveTo(50, 300);
    $img->font('Times:italic');
    $img->fontsize(10);
    $img->string("Triangle area is ${area}");

    my $filename = "triangle_" . time() . ".png";
    open(my $fh, ">", $filename );
    print $fh $img->png;
    close($fh);

    print "triangle image writen to ${filename}\n";
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
