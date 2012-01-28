use strict;
use warnings;
use Test::More tests => 5;

use PNI::Node::Perlfunc::Lc;

my $node = PNI::Node::Perlfunc::Lc->new;

isa_ok $node, 'PNI::Node::Perlfunc::Lc';
is $node->label, 'lc', 'label';

my $in  = $node->in;
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = 'FOO';
my $b = lc($a);

$node->in->data($a);
$node->task;
is $node->out->data, $b, 'out = lc( in )';

$node->on;
$node->in->data(10);
$node->task;
ok $node->is_off, 'node is off if not feeded with a string';

