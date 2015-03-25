#!/usr/bin/perl
use strict;
use warnings;

my $version = '5.20.2';

my $path = "/home/vagrant/localperl";
my $perl = "$path/bin/perl";

if (not -e $path) {
	system "wget http://www.cpan.org/src/5.0/perl-$version.tar.gz";
	system "tar -xzf perl-$version.tar.gz";
	chdir "perl-$version";
	system "./Configure -des -Dprefix=$path";
	system "make";
	system "make test";
	system "make install";
	chdir '..';
	system "rm -rf perl-$version";
	unlink "perl-$version.tar.gz"; 
}

if (not -e "$path/bin/cpanm") {
	system "curl -L https://cpanmin.us | $perl - App::cpanminus";
}

my @modules = qw(
	PAR::Packer
	Dancer2
	Dancer2::Plugin::Passphrase
	MongoDB
);	

foreach my $module (@modules) {
	system "$path/bin/cpanm $module";
}

system "chown -R vagrant.vagrant $path";
