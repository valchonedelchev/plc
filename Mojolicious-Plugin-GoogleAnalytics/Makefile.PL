use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Mojolicious::Plugin::GoogleAnalytics',
    AUTHOR        => q{Vulcho Nedelchev <kumcho@vulcho.com>},
    VERSION_FROM  => 'lib/Mojolicious/Plugin/GoogleAnalytics.pm',
    ABSTRACT_FROM => 'lib/Mojolicious/Plugin/GoogleAnalytics.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ('LICENSE' => 'perl')
        : ()),
    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More'        => 0,
        'Mojolicious::Lite' => 0,
        'Test::Mojo'        => 0,
        'Mojolicious'       => 0,
    },
    dist  => {COMPRESS => 'gzip -9f', SUFFIX => 'gz',},
    clean => {FILES    => 'Mojolicious-Plugin-GoogleAnalytics-* debian*'},
);
