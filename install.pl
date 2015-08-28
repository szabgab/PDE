#!/usr/bin/perl
use strict;
use warnings;
use Cwd qw(abs_path);
use File::Basename qw(dirname);

my ($test) = @ARGV;

my $version = '5.22.0';

my $path = "/home/vagrant/localperl";
my $perl = "$path/bin/perl";

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


if (not -e $path) {
	system "wget -q http://www.cpan.org/src/5.0/perl-$version.tar.gz";
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
	system "curl -s -L https://cpanmin.us | $perl - App::cpanminus";
}

foreach my $module (@modules) {
	system "$path/bin/cpanm $module";
}

# rm -rf /root/.cpanm/work/

system "chown -R vagrant.vagrant $path";

my $node = 'v0.12.7';
my $node_dir = "node-$node-linux-x86";
if (not -e 'node') {
	system "wget -q https://nodejs.org/dist/$node/$node_dir.tar.gz";
	system "tar xzf "$node_dir.tar.gz"
	rename $node_dir, 'node';
}

