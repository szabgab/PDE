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
	App::Ack
	App::cpanoutdated
	Business::PayPal
	Cache::File
	Carp::Always
	Code::Explain
	Config::Tiny
	Crypt::URandom
	Daemon::Control
	Dancer2
	Dancer2::Plugin::Auth::Extensible
	Dancer2::Plugin::DBIC
	Dancer2::Plugin::Passphrase
	Dancer2::Plugin::Redis
	Data::ICal
	Data::Printer
	DateTime
	DateTime::Format::ICal
	DateTime::Functions
	DBD::SQLite
	DBI
	DBIx::RunSQL
	Digest::SHA
	Email::MIME::Creator
	Email::Sender::Simple
	Email::Stuffer
	Email::Valid
	File::Find::Rule
	Gravatar::URL
	Hash::Merge::Simple
	JSON::Path
	JSON::XS
	JSON::MaybeXS
	List::MoreUtils
	List::Util
	List::UtilsBy
	Math::Random::ISAAC::XS
	MetaCPAN::API
	MetaCPAN::Client
	Module::Version
	Mojolicious
	MongoDB
	Moo
	MIME::Lite
	Net::Delicious
	Path::Tiny
	PAR::Packer
	Perl::Tidy
	PerlX::Maybe
	Plack
	Plack::Middleware::DirIndex
	PPI
	Scope::Upper
	Sereal::Decoder
	Sereal::Encoder
	Starman
	Storable
	SVG
	Template
	Term::ReadPassword::Win32
	Test::Code::TidyAll
	Test::More
	Test::Perl::Critic
	Test::Script
	Test::WWW::Mechanize
	Test::WWW::Mechanize::PSGI
	Time::HiRes
	URL::Encode::XS
	Web::Feed
	WWW::Mailman
	WWW::Shorten::Bitly
	XML::Feed
	YAML
	JSON
);

foreach my $module (@modules) {
	system "$path/bin/cpanm $module";
}

# rm -rf /root/.cpanm/work/

system "chown -R vagrant.vagrant $path";
