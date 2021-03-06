use strict;
use warnings;
use Test::More tests => 4;

use PNI::Node::Perlop::Stringwise_equal;

my $node = PNI::Node::Perlop::Stringwise_equal->new;

isa_ok $node, 'PNI::Node::Perlop::Stringwise_equal';
is $node->label, 'eq', 'label';

my $in1 = $node->in(1);
my $in2 = $node->in(2);
my $out = $node->out;

$node->task;
is $out->data, undef, 'default task';

my $a = 'foo';

$in1->data($a);
$in2->data($a);
$node->task;
ok $out->data, 'a eq a';

