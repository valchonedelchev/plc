use Mojo::Base -strict;

use Test::More tests => 14;
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

get '/over' => (mobile=>1) => sub {
  my $self = shift;
  $self->render(text=>"over mobile");
};

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('normal');
for (qw(nokia 1207 6310 blackberry)) {
  $t->ua->name($_);
  $t->get_ok('/')->content_is("mobile");
}
$t->get_ok('/over')->status_is(200)->content_is('over mobile');

