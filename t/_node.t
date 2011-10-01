use strict;
use warnings;
use Test::More tests => 18;
use PNI;
use PNI::Node;

my $node = PNI::Node->new;
isa_ok $node, 'PNI::Node';

is $node->get_ins_edges,  0,           'default get_ins_edges';
is $node->get_outs_edges, 0,           'default get_outs_edges';
is $node->type,           'PNI::Node', 'default type';
is $node->parents,        0,           'default parents';

ok my $in = $node->new_in('in'), 'new_in';
isa_ok $in, 'PNI::In';
is $in, $node->get_in('in'), 'get_in';

ok my $out = $node->new_out('out'), 'new_out';
isa_ok $out, 'PNI::Out';
is $out, $node->get_out('out'), 'get_out';

my $node_x = $node->box->center->x;
my $node_y = $node->box->center->y;
my $in_x   = $in->box->center->x;
my $in_y   = $in->box->center->y;
my $out_x  = $out->box->center->x;
my $out_y  = $out->box->center->y;
my ( $dx, $dy ) = ( 100, 150 );
$node->translate( $dx, $dy );
is $node->box->center->x, $node_x + $dx, 'box center x';
is $node->box->center->y, $node_y + $dy, 'box center y';
is $in->box->center->x,   $in_x + $dx,   'in center x';
is $in->box->center->y,   $in_y + $dy,   'in center y';
is $out->box->center->x,  $out_x + $dx,  'out center x';
is $out->box->center->y,  $out_y + $dy,  'out center y';

my $root = PNI::root;

my $node1 = $root->new_node;
my $node2 = $root->new_node;
my $node3 = $root->new_node;

my $node1_out = $node1->new_out('out');
my $node2_in  = $node2->new_in('in');
my $node2_out = $node2->new_out('out');
my $node3_in1 = $node3->new_in('in1');
my $node3_in2 = $node3->new_in('in2');

my $edge1 = $root->new_edge( source => $node1_out, target => $node2_in );
is_deeply \( $node2->get_ins_edges ), \($edge1), 'node1_out -> node2_in';

