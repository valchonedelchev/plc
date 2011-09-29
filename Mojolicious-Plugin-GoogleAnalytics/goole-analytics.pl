#!/usr/bin/env perl
use lib 'lib';
use Mojolicious::Lite;

plugin 'google_analytics' => { urchin => 'XX-12345-1' }; 
get '/' => 'index';
app->start;

__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
Welcome to Mojolicious!

@@ layouts/default.html.ep
<!doctype html><html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
