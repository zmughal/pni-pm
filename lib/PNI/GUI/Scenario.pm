package    # Avoid PAUSE indexing.
  PNI::GUI::Scenario;
use Mojo::Base 'Mojolicious::Controller';

use PNI::Elem;
use PNI::Scenario;

# Create just one scenario ... very minimal by now.
my $scenario = PNI::Scenario->new;

sub add_edge {
    my $self = shift;
    my $log  = $self->app->log;

    my $source_id = $self->req->param('source_id');
    my $target_id = $self->req->param('target_id');

    my $source = PNI::Elem::by_id($source_id);
    my $target = PNI::Elem::by_id($target_id);

    $log->debug("Added edge ($source_id => $target_id)");
    my $edge = $scenario->add_edge( source => $source, target => $target );

    $self->render_json( $edge->to_hashref, status => 201 );
}

use Mojo::JSON;
my $json = Mojo::JSON->new;

sub add_node {
    my $self = shift;
    my $log  = $self->app->log;

    my $type = $self->req->param('type');
    my $x    = $self->req->param('x');
    my $y    = $self->req->param('y');
    my $ins  = $self->req->param('ins');
    $ins = $json->decode($ins);

    # TODO da aggiustare 
    
# TODO vedi bene sta cosa, devo forzare x e y ad essere interi altrimenti json me li mette tra ""
    $x += 0;
    $y += 0;

    $log->debug("Added node ($type)");
    my $node = $scenario->add_node( $type, x => $x, y => $y,ins=>$ins );

    $self->render_json( $node->to_hashref, status => 201 );
}

sub to_json {
    my $self = shift;

    $self->render_json( $scenario->to_hashref );
}

1;

