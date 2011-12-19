use Mojo::Base -strict;

use Test::More tests => 11;
use lib 'lib';

use Mojo::UserAgent;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'Mobi';

get '/' => sub {
  my $self = shift;
  if ($self->is_mobile) {
    $self->render_text('mobile');
  } else {
    $self->render_text('normal');
  }
};

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('normal');

for (qw(nokia 1207 6310 blackberry)) {
  $t->ua->name($_);
  $t->get_ok('/')->content_is("mobile");
}

