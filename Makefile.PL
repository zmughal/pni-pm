use 5.008008008;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    ABSTRACT  => 'Node based visual programming via browser',
    AUTHOR    => 'G. Casati <fibo@cpan.org>',
    EXE_FILES => ['bin/pni'],
    NAME      => 'Perl-Node-Interface',
    PREREQ_PM => {
        # TODO commenta e metti (guarda coreutils)
        # da quando il modulo e' core
        # cosi tengo traccia delle dipendenze
        # considerando che supporto da 5.8.8 in poi
        # segna che altrimenti Mojolicious va in conflict con ppm, 
        # ho dovuto fare
        # ppm install Perl-Node-Interface -force
        #'File::Find'            => 0,
        #'File::Spec::Functions' => 0,
        #'List::Util'            => 0,
        'Config::YAML'            => 0,
        'DBD::SQLite'            => 0,
        'DBIx::Class'            => 0,
        'File::HomeDir'            => 0,
        'Module::Pluggable'     => 0,
        'Mojolicious'           => '3',
        'Path::Class'            => 0,
        #'Scalar::Util'          => 0,
        #'Test::More'            => 0,
        'UNIVERSAL::require'    => 0,
    },
    test         => { TESTS => 't/*.t t/node/*.t' },
    VERSION_FROM => 'lib/PNI.pm',
);
