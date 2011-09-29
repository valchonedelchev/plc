package Mojolicious::Plugin::GoogleAnalytics;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Plugin';
use Mojo::ByteStream 'b';

__PACKAGE__->attr('urchin');

=head1 NAME

Mojolicious::Plugin::GoogleAnalytics - google analytics plugin for mojolicious.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    plugin 'google_analytics' => { urchin => 'XX-12345-1' };

=head1 ATTRIBUTES

=head2 C<urchin>

=head1 METHODS

=head2 

=cut

sub register
{
    my ($self, $app, $args) = @_;
    $app->hook(
        after_dispatch => sub {
            my $self = shift;
            return unless $args->{urchin};
            my $body = $self->res->body;
            $self->stash(urchin => $args->{urchin});
            my $ga_script = $self->render_partial(
                'template',
                format         => 'html',
                template_class => __PACKAGE__,
                handler        => 'ep'
            );
            $ga_script = b($ga_script)->encode('utf-8');
            $body =~ s{</body>}{$ga_script</body>};
            $self->res->body($body);
        }
    );
}

=head1 SEE ALSO

L<Mojo>, L<Mojolicious>

=head1 AUTHOR

Vulcho Nedelchev, C<< <kumcho at vulcho.com> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Mojolicious::Plugin::GoogleAnalytics

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Vulcho Nedelchev.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;    # End of Mojolicious::Plugin::GoogleAnalytics

__DATA__

@@ template.html.ep

<script type="text/javascript"><!--
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("<%= $urchin %>");
pageTracker._trackPageview();
} catch(err) {}
--></script>

