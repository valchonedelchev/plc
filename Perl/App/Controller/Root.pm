package App::Controller::Root;

use strict;
use warnings;
use base 'App::Controller';


sub dispatch {
	my ($this, $request, $response) = @_;
	$response->append('I am root!!!');
	return $response;
}

1;
