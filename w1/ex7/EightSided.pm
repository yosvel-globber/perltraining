package EightSided;

use strict;
use warnings;
use parent "Shape";

sub new {
    my $invocant = shift;
    my $self = bless({}, ref $invocant || $invocant);
    $self->SUPER::new(@_);    #this is not a call to a constructor in the super class but an initializer.

    return $self;
}

sub save {
    my $self = shift;
    $self->SUPER::save();
    print "Saved an eightsided figure with id $self->{'id'} of type $self->{'type'}\n";
}

1;
