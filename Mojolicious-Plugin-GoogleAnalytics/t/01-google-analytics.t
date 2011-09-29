#!perl
use Test::More tests => 2;
use Test::Mojo;
use Mojolicious::Lite;

# My unique code
my $urchin = 'XX-12345-0';

# Load plugin
plugin 'Mojolicious::Plugin::GoogleAnalytics' => {urchin => $urchin};

# configure routing
get '/' => 'index';

# Make real test
Test::Mojo->new->get_ok('/')->content_like(qr/$urchin/, 'Different content');

__DATA__
@@ index.html.ep
</body>Passed
