package Mojolicious::Plugin::Widget;
use Mojo::Base 'Mojolicious::Plugin';
use Model::Widgets;

our $VERSION = '0.01';

sub register {
    my ( $self, $app ) = @_;
    $app->helper(
        widget => sub {
            my $self = shift;
            my $name = shift;
            my $widget = Model::Widgets->search( name => $name )->next;
            if ($widget) {
                return
                    "<!-- Widget \"$name\" begin -->\n"
                  . $widget->content
                  . "\n<!--// Widget \"$name\" end -->\n";
            }
        }
    );
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::Widget - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('Widget');

  # Mojolicious::Lite
  plugin 'Widget';

  # @@ index.html.ep
  <%== widget('widget_name') %>

=head1 DESCRIPTION

L<Mojolicious::Plugin::Widget> is a L<Mojolicious> plugin.

Database and tables:

 CREATE TABLE IF NOT EXISTS `widgets` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `name` varchar(255) NOT NULL,
   `content` text NOT NULL,
   PRIMARY KEY (`id`),
   UNIQUE KEY `name` (`name`)
 ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;

Use schema2model-mysql.pl helper to create Model::Widgets

=head1 METHODS

L<Mojolicious::Plugin::Widget> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 C<register>

  $plugin->register;

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
