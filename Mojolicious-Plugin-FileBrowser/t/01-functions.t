#!perl -T

use strict;
use warnings;
use Test::More tests => 3;


use_ok( 'Mojolicious::Plugin::FileBrowser' ) || print "Import failed!\n";
can_ok( 'Mojolicious::Plugin::FileBrowser', qw( register nodeslist ) );
isa_ok( Mojolicious::Plugin::FileBrowser->nodeslist, 'ARRAY' );



