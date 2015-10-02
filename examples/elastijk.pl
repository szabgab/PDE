use strict;
use warnings;
use 5.010;

use Elastijk;

my ($es_host, $es_port) = ("localhost", "9200");
my $es = Elastijk->new(
    host => $es_host,
    port => $es_port,
);
say 'OK';

my ($status, $res) = $es->search(
    index => "p5iq",
    body  => {
        query => 'hello',
        size  => 1,
    }
);
say 'OK';
 
