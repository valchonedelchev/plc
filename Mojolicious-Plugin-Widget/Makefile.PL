#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::Widget',
  VERSION_FROM => 'lib/Mojolicious/Plugin/Widget.pm',
  AUTHOR       => 'Vulcho Nedelchev <kumcho@vulcho.com>',
  PREREQ_PM    => {'Mojolicious' => '1.90'},
  test         => {TESTS => 't/*.t'}
);
