package App::Request;

use strict;
use warnings;
use CGI;

sub new {
    my $class   = shift;
    my $session = shift;
    my $this    = {};
    bless $this, $class;
    $this->{_session} = $session;
    $this->{_cgi}     = new CGI;
    return $this;
}

sub session {
    my ($this) = @_;
    return $this->{_session};
}

sub cgi {
	my ($this) = @_;
	return $this->{_cgi};
}

1;

__END__

