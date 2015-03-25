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
	Acme::MetaSyntactic
	Business::PayPal
	Carp::Always
	Crypt::URandom
	Daemon::Control
	Dancer2
	Dancer2::Plugin::Passphrase
	Dancer2::Plugin::Auth::Extensible
	DateTime
	DBD::SQLite
	DBI
	DBIx::RunSQL
	Email::MIME::Creator
	Email::Sender::Simple
	Email::Stuffer
	Email::Valid
	File::Find::Rule
	Hash::Merge::Simple
	List::MoreUtils
	Math::Random::ISAAC::XS
	MongoDB
	Moo
	Path::Tiny
	PAR::Packer
	Plack
	Scope::Upper
	Starman
	Storable
	SVG
	Template
	Test::More
	Test::Script
	Test::WWW::Mechanize
	Test::WWW::Mechanize::PSGI
	Time::HiRes
	URL::Encode::XS
	YAML
	JSON
);

foreach my $module (@modules) {
	system "$path/bin/cpanm $module";
}

# rm -rf /root/.cpanm/work/

system "chown -R vagrant.vagrant $path";
