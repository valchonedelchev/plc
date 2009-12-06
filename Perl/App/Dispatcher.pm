package App::Dispatcher;

use strict;
use warnings;
use App::Session;
use App::Request;
use App::Response;
use App::Controller;

sub new {
    my $class = shift;
    my $this  = {};
    bless $this, $class;
    return $this;
}

sub dispatch {
    my ($this) = @_;

    #$ENV{REQUEST_URI} |= '/Root_/Admin/Root';

    my @uri = split '/', ( $ENV{REQUEST_URI} || '' );
    shift @uri if scalar @uri > 1;

	my $session    = new App::Session();
	my $request    = new App::Request($session);
	my $response   = new App::Response($request);
    my $controller = new App::Controller( \@uri );
    
    $controller->dispatch($request, $response);

    $response->send_response;

}

1;

