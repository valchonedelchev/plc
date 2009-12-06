package App;

use strict;
use warnings;

use CGI;
use CGI::Cookie;
use CGI::Session;
#use CGI::Carp 'fatalsToBrowser';
use App::Response;
use App::Request;

my $CGI;
my $COOKIE;
my $SESSION;
my $INSTANCE;

sub new {
    my $class    = shift;
    my $INSTANCE = {};
    bless $INSTANCE, $class;
    $INSTANCE->{title} = 'default app title';
    $INSTANCE->{keywords} = 'default, keywords, goes, here';
    $INSTANCE->{description} = 'This is my lite-cgi-cms';
    $INSTANCE->{favicon} = '';
    $INSTANCE->{author} = 'lite-cgi-cms';
    return $INSTANCE;
}

sub getInstance {
    $INSTANCE = new App() unless defined $INSTANCE;
    return $INSTANCE;
}

sub dispatch {
    my ($this) = @_;

    my $content;
    my $response = new App::Response();

    my ( $controller, $action, $template );

    if ( $this->CGI->param('uri') ) {
        ( $controller, $action, $template ) = $this->dispatch_uri();
    }
    else {
        $controller = $this->CGI->param('controller') || 'Index';
        $action     = $this->CGI->param('action')     || 'default';
        $template   = $action . '.html';
    }

    my $controllerFile    = sprintf( 'App/Controllers/%s.pm', $controller );
    my $controllerPackage = sprintf( 'App::Controllers::%s',  $controller );
    eval { require "$controllerFile" };
    if ($@) {
        $content = $response->error_page( 'Controller not found', "<i>$@</i>" );
    }
    elsif ( not $controllerPackage->can($action) ) {
        $content =
          $response->error_page( 'Controller action error', 'Action error :(' );
    }
    else {
        $content = $controllerPackage->$action;
    }
    $response->render( $content->output );
}

sub dispatch_uri {
	$ENV{REQUEST_URI} =~ s|/+|/|g;
    my @segments = split '/', $ENV{REQUEST_URI};
    shift @segments;
    my $controller = shift @segments || 'Index';
    my $action     = shift @segments || 'default';
    my $template   = "$action.html";
    return ( $controller, $action, $template );
}

sub COOKIE {
    $COOKIE = new CGI::Cookie() unless defined $COOKIE;
    return $COOKIE;
}

sub CGI {
    $CGI = new CGI() unless defined $CGI;
    return $CGI;
}

sub SESSION {
    $SESSION = new CGI::Session() unless defined $SESSION;
    return $SESSION;
}

sub title {
	my ($this, $title) = @_;
	$this->{title} = $title if defined $title;
	return $this->{title};
}

sub favicon { my ($this) = @_; $this->{favicon} }
sub author { my ($this) = @_; $this->{author} }
sub description { my ($this) = @_; $this->{description} }


1;

__END__

