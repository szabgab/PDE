use strict;
use warnings;
use 5.022;

use Test::More;

plan tests => 2;

use Elastijk;


subtest elastijk => sub {
	plan tests => 2;
	my ($es_host, $es_port) = ("localhost", "9200");
	my $es = Elastijk->new(
	    host => $es_host,
	    port => $es_port,
	);
	isa_ok $es, 'Elastijk::oo', 'Elastijk->new';
	
	my ($status, $res) = $es->search(
	    index => "p5iq",
	    body  => {
	        query => 'hello',
	        size  => 1,
	    }
	);
	ok 1, 'Elastijk->search';
};


ok 1;

