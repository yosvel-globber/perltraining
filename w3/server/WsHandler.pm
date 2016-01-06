package WsHandler;

use strict;
use warnings;
use Apache2::RequestRec;                        #to handle request
use Apache2::RequestIO;                         #for printing output
use Apache2::Const -compile => ':common';       #make common constants available but do not import them ...

sub handler {
    my $r = shift;

    $r->content_type('text/plain');
    $r->print('Hello world!');

    return Apache2::Const::OK;
}
