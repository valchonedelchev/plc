#!/usr/bin/perl

use strict;
use warnings;
use lib '/home/weby/Development/Perl';
use App::Dispatcher;


chdir '/home/weby/Development/Perl';

new App::Dispatcher->dispatch();

