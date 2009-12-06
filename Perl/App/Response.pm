package App::Response;

use strict;
use warnings;
use HTML::Template;

sub new {
    my $class = shift;
    my $this  = {};
    bless $this, $class;
    $this->{_request}     = shift;
    $this->{_body}        = '';
    $this->{_tmpl_params} = {};
    return $this;
}

sub send_response {
    my ($this) = @_;

    print $this->request->cgi->header(
        -cookie => $this->request->cgi->cookie(
            $this->request->session->name => $this->request->session->id
        )
    );

    my $layout =
      $this->load( 'layout.html',
        { app_title => '$APP->title', app_content => $this->get_content } );

    if ($layout) {
        print $layout->output;
    }
    else {
        print $this->get_content;
    }
}

sub load {
    my ( $this, $file, $bind_params ) = @_;

    my $path = 'App/Templates';

    if ( not -f $path . '/' . $file ) {
        return undef;
    }

    my $template = new HTML::Template(
        filename          => $file,
        path              => $path,
        case_sensitive    => 0,
        die_on_bad_params => 0
    );

    foreach my $param_name ( keys %{$bind_params} ) {
        $template->param( $param_name, $bind_params->{$param_name} );
    }

    return $template;
}

sub bind {
    my ( $this, $name, $value ) = @_;
    $this->{_tmpl_params}->{$name} = $value;
}

sub append {
    my ( $this, $content ) = @_;
    $this->{_body} .= $content;
}

sub get_content {
    my ($this) = @_;
    $this->{_body};
}

sub request {
    my ($this) = @_;
    $this->{_request};
}

1;

