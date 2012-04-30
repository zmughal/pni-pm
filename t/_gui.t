use strict;
use warnings;
use Test::More tests => 30;
use Test::Mojo;

# Use some test nodes, under t/PNI/Node path.
use lib 't';

my $t = Test::Mojo->new('PNI::GUI');

# Javascript resources.
$t->get_ok('/js/jquery-1.7.1.min.js')->status_is(200);
$t->get_ok('/js/jquery-ui-1.8.18.custom.min.js')->status_is(200);
$t->get_ok('/js/kinetic-v3.8.5.min.js')->status_is(200);
$t->get_ok('/js/Three.js')->status_is(200);
$t->get_ok('/js/require.js')->status_is(200);
$t->get_ok('/js/pni.js')->status_is(200);
$t->get_ok('/js/onload.js')->status_is(200);

# GET /
$t->get_ok('/')

  # Status is ok.
  ->status_is(200)

  # Check content type.
  ->content_type_is('text/html;charset=UTF-8')

  # Check title.
  ->text_is( 'html head title' => 'Perl Node Interface', 'title' )

  # End of Main Window tests.
  ;

# GET /scenario
$t->get_ok('/scenario')

  # Status is ok.
  ->status_is(200)

  # Check content type.
  ->content_type_is('application/json')

  # End of GET /scenario endpoint tests.
  ;

# GET /node/:node_id
use PNI::Scenario;
my $scenario = PNI::Scenario->new;
my $node1    = $scenario->add_node('Twice');
$t->get_ok( '/node/' . $node1->id )

  # Status is ok.
  ->status_is(200)

  # Check content type.
  ->content_type_is('application/json')

  # End of GET /scenario endpoint tests.
  ;

# GET /edge/:edge_id
my $node2 = $scenario->add_node('Twice');
my $edge = $scenario->add_edge( source => $node1->out, target => $node2->in );
$t->get_ok( '/edge/' . $edge->id )

  # Status is ok.
  ->status_is(200)

  # Check content type.
  ->content_type_is('application/json')

  # End of GET /scenario endpoint tests.
  ;

# GET /node_list
#use PNI::Finder;
#my $find      = PNI::Finder->new;
#my $node_listref = [$find->nodes];

$t->get_ok('/node_list')

  # Status is ok.
  ->status_is(200)

  # Check content type.
  ->content_type_is('application/json')

  # Check json content.
  #->json_is( $node_listref )

  # End of GET /scenario endpoint tests.
  ;

