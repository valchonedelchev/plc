package App::Controller;

use strict;
use warnings;

sub new {
    my $class       = shift;
    my $request_uri = shift;
    my $this        = {};
    bless $this, $class;
    $this->get_next($request_uri) || $this;
}

sub get_next {
    my ( $this, $request_uri ) = @_;

    if ( ref $request_uri ne 'ARRAY' or not scalar @{$request_uri} ) {
        return undef;
    }

    my $controller = shift @{$request_uri};

    if ( not defined $controller ) {
        return undef;
    }

    my $this_package       = ref $this;
    my $controller_package = $this_package . '::' . $controller;
    my $controller_file    = $controller_package;
    
    $controller_file =~ s|\:\:|/|g;
    $controller_file .= '.pm';

    if ( not -f $controller_file ) {
        use App::Controller::Error404;
        return App::Controller::Error404->new;
    }

    eval { require "$controller_file" };
    die $@ if $@;

    my $controller_instance = $controller_package->new($request_uri);

    return $controller_instance;
}

sub dispatch {
    my ($this, $request, $response) = @_;
}

1;

