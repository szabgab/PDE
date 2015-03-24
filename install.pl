#!/usr/bin/perl
use strict;
use warnings;

my $version = '5.20.2';

my $path = "/home/vagrant/localperl";

if (not -e $path) {
	system "wget http://www.cpan.org/src/5.0/perl-$version.tar.gz";
	system "tar -xzf perl-$version.tar.gz";
	chdir "perl-$version";
	system "./Configure -des -Dprefix=$path";
	system "make";
	system "make test";
	system "make install";
}

