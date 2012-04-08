package PNI;

use strict;
use warnings;

# As recommended in permodstyle's "Version numbering" section
# considering version x.yy stable, a new release will be versioned
# as x.yy_zz so it will not be listed by CPAN.pm as the last.
# After test results will be ok, it can be officially released x.(yy+1) version.
our $VERSION = '0.29_01';
$VERSION = eval $VERSION;

use Exporter 'import';
use PNI::Edge;
use PNI::Finder;
use PNI::Node;
use PNI::Scenario;
use Time::HiRes;

# TODO fai PNI::Guides::Scripting dove spieghi
# use PNI ':-D' ... vedi se meglio fare use PNI ':-)' o tutti e due e anche :^) , use PNI '::'
# ma vedi anche se puoi esportare n e s r l invece di node edge scen root loop
# e poi spieghi che usi solo la root e ti viene fuori uno script che gia si puo lanciare
# ed usi tutti i nodi
#
# poi fai la parte avanzata dove spieghi che in realta si potrebbe usare tutto ... ma perche' non usare la GUI (dici alla fine)

# Smiling is better (:
our @EXPORT_OK = qw( edge node task );
our %EXPORT_TAGS = ( 'root' => \@EXPORT_OK );

# A PNI finder.
my $find = PNI::Finder->new;

# The root scenario.
my $root = PNI::Scenario->new;

sub edge {
    my $source_node   = shift;
    my $target_node   = shift;
    my $source_out_id = shift;
    my $target_in_id  = shift;

    # TODO POTENZIALMENTE PERICOLOSO !!!!!
    # se gli slot non esistono li creerebbe
    # considera se usare una cosa del tipo
    # my $source_out = $source_node->outs->elem->{$source_out_id};
    my $source_out = $source_node->out($source_out_id);
    my $target_in  = $target_node->in($target_in_id);

    return $root->add_edge(
        source => $source_out,
        target => $target_in
    );
}

sub files { return $find->files }

sub loop {

    while (1) {
        &task;
        Time::HiRes::usleep(1);
    }

    return;
}

sub node { return $root->add_node(@_); }

sub node_list { return $find->nodes; }

sub root { return $root; }

sub scen { return $root->add_scenario; }

sub task { return $root->task; }

1;

__END__

=head1 NAME

PNI - stands for Perl Node Interface

=head1 SYNOPSIS

    $ pni daemon

Then point your browser to http://localhost:3000 and use the gui.

=head1 DESCRIPTION

Hi all! I'm an italian mathematician.  I really like Perl philosophy as Larry jokes a lot even if he is one of the masters of hacking.

PNI stands for Perl Node Interface.

It is my main project, my contribution to the great Perl community. Node programming is really interesting since makes possible to realize a program even if you have no idea about programming. 

Think about genetic researchers, for example. They need to focus on protein chains, not on what a package is. Maybe they can do an extra effort and say the world "variable" or "string" or even "regular expression" and that makes them proud, but they don't care about inheritance.

They want things working and they need Perl ... but if you say L<Strawberry|http://strawberryperl.com/> they think about yogurt, not about Windows.

There are a lot of node programming languages (L<VVVV|http://vvvv.org/>, L<Puredata|http://puredata.info/>, L<Max/Msp|http://cycling74.com/>) but normally they target artists and interaction designers. I saw a lot of vjs and musicians do really complex programs with those software, and they never wrote a line of code.

This is my effort to provide a node interface that brings Perl power to people who don't know the Perl language.

Blah blah blah. ( this was the h2xs command :-)

=head1 METHODS

=head2 edge

    my $source_node = PNI::node 'Some::Node';
    my $target_node = PNI::node 'Another::Node';

    my $edge = PNI::edge $source_node         => $target_node , 
                         'source_output_name' => 'target_input_name';

Connects an output of a node to an input of another node.

=head2 files

    my @pni_files = PNI::files;

Returns a list of all .pni files in PNI.pm install dir and subdirs.

=head2 loop

    PNI::loop;

Starts the PNI main loop. It keeps calling C<task> as fast as it can.

=head2 node

    # Load PNI::Node::Foo::Bar node. 
    my $node = PNI::node 'Foo::Bar';

Creates a node by its PNI type, that is the name of a package under the
PNI::Node namespace, and adds it to the root scenario.


    my $empty_node = PNI::node;

If no type is provided, PNI creates an empty node.

=head2 node_list

    my @nodes = PNI::node_list;

Returns a list of available PNI nodes.

This method delegates to L<PNI::Finder> C<nodes> method.

=head2 root

    my $root = PNI::root;

Returns the root PNI::Scenario.

=head2 scen

    my $scen = PNI::scen;

Creates a brand new sub scenario of the root scenario.

=head2 task

    PNI::task;

Calls the task method for every loaded node.
This method delegates to the root scenario task method.

=head1 SEE ALSO

L<PNI::Guides>

L<PNI blog|http://perl-node-interface.blogspot.com>

L<PNI repository|http://github.com/fibo/pni-pm>

L<PNI class diagram|http://goo.gl/MQ89f>

L<PNI node coverage|http://goo.gl/hfAoU>

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2012, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0.

=cut

