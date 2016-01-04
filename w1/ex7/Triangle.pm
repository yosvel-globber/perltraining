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

    #todo check it it is a triangle... will make some assumptions here as time is against me!

    $self->{'a'} = $params{'p1'};
    $self->{'b'} = $params{'p2'};
    $self->{'c'} = $params{'p3'};

    return $self;
}

sub area {
    my $self = shift;
    my $s1 = $self->{'a'}->distance("point" => $self->{'b'});
    my $s2 = $self->{'b'}->distance("point" => $self->{'c'});
    my $s3 = $self->{'c'}->distance("point" => $self->{'a'});

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
    $img->bgcolor('black');
    $img->fgcolor('black');

    #draw the triangle...
    my $poly = GD::Polygon::->new();
    $poly->addPt($self->{'a'}->{'x'}, $self->{'a'}->{'y'});
    $poly->addPt($self->{'b'}->{'x'}, $self->{'b'}->{'y'});
    $poly->addPt($self->{'c'}->{'x'}, $self->{'c'}->{'y'});
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
