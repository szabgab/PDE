#!/usr/bin/perl
use strict;
use warnings;
use Cwd qw(abs_path);
use File::Basename qw(dirname);

my ($test) = @ARGV;

my $version = '5.22.0';

my $perl5_path = "/home/vagrant/localperl";
my $perl = "$perl5_path/bin/perl";

my $file = dirname(abs_path($0)) . '/modules.txt';
open my $fh, '<', $file or die "Could not open file '$file': $!\n";
my @modules = <$fh>;
chomp @modules;

if ($test) {
	foreach my $module (@modules) {
		#system "$^X -M$module -e1";
		eval "use $module";
		print $@ if $@;
	}
	exit;
}


if (not -e $perl5_path) {
	system "wget -q http://www.cpan.org/src/5.0/perl-$version.tar.gz";
	system "tar -xzf perl-$version.tar.gz";
	chdir "perl-$version";
	system "./Configure -des -Dprefix=$perl5_path";
	system "make";
	system "make test";
	system "make install";
	chdir '..';
	system "rm -rf perl-$version";
	unlink "perl-$version.tar.gz";
}

if (not -e "$perl5_path/bin/cpanm") {
	system "curl -s -L https://cpanmin.us | $perl - App::cpanminus";
}

foreach my $module (@modules) {
	system "$perl5_path/bin/cpanm $module";
}

# rm -rf /root/.cpanm/work/

system "chown -R vagrant.vagrant $perl5_path";

my $node = 'v0.12.7';
my $node_dir = "node-$node-linux-x86";
if (not -e 'node') {
	system "wget -q https://nodejs.org/dist/$node/$node_dir.tar.gz";
	system "tar xzf $node_dir.tar.gz";
	rename $node_dir, 'node';
}

my $rakudo_version = '2015.07';
my $rakudo_path = "/home/vagrant/rakudo";
my $rakudo = "rakudo-star-2015.07";
if ( not -e 'rakudo') {
	system "wget -q http://rakudo.org/downloads/star/$rakudo.tar.gz";
	system "tar xzf $rakudo.tar.gz";
	chdir $rakudo;
	system "perl Configure.pl --backend=moar --gen-moar --prefix $rakudo_path";
	system "make";
	system "make install";
	chdir '..';
	system "rm -rf $rakudo";
	unlink "$rakudo.tar.gz";
}

