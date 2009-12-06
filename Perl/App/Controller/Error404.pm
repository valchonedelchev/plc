package App::Controller::Error404;

use strict;
use warnings;
use base 'App::Controller';

sub dispatch {
	my ($this, $request, $response) = @_;
	$response->append("<h1>404</h1>");
}


1;
