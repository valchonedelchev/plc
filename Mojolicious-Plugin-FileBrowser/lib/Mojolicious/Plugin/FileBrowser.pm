package Mojolicious::Plugin::FileBrowser;
use Mojo::Base 'Mojolicious::Plugin';
use vars qw/ $VERSION $APP /;

$VERSION = '0.01';

sub register
{
    my $self = shift;
    $APP     = shift;
    $APP->helper(ls => sub { $self->nodeslist(@_) });
}

# since 0.01
sub nodeslist
{
    my ($self, $c, $path) = @_;
    my @nodes;
    $path = '.' unless defined $path;
    $path =~ s|/+$||;
    if (opendir(my $dir, $path)) {
        @nodes =
          map { {name => "$path/$_", size => -s "$path/$_", isdir => -d "$path/$_", mtime => (stat("$path/$_"))[9]} }
          grep { !/^\./ } readdir($dir);
        closedir($dir);
    } else {
        $APP->log->debug("Cannot open $path - $!");
    }
    return \@nodes;
}

=head1 NAME

Mojolicious::Plugin::FileBrowser - A Mojolicious Plugin for FS access.

=head1 DESCRIPTION

Helpers to access filesystem operations.

=head1 EXAMPLE

plugin 'FileBrowser';

%= dumper $self->ls()

=head1 AUTHOR

Vulcho Nedelchev, C<< <kumcho at vulcho.com> >>

=head1 ACKNOWLEDGEMENTS

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Vulcho Nedelchev.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;    # End of Mojolicious::Plugin::FileBrowser
