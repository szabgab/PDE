#!/usr/bin/perl
use strict;
use warnings;
use Cwd qw(abs_path);
use File::Basename qw(dirname);

my ($test) = @ARGV;

my $perl5_path = "/home/vagrant/localperl";
my $perl5 = "$perl5_path/bin/perl";

my %version;
{
	my $versions_file = dirname(abs_path($0)) . '/versions.txt';
	open my $fh, '<', $versions_file or die;
	while (my $line = <$fh>) {
		chomp $line;
		my ($name, $number) = split /=/, $line;
		$version{$name} = $number;
	}
	close $fh;
}
 
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
	system "wget -q http://www.cpan.org/src/5.0/perl-$version{perl5}.tar.gz";
	system "tar -xzf perl-$version{perl5}.tar.gz";
	chdir "perl-$version{perl5}";
	system "./Configure -des -Dprefix=$perl5_path";
	system "make";
	system "make test";
	system "make install";
	chdir '..';
	system "rm -rf perl-$version{perl5}";
	unlink "perl-$version{perl5}.tar.gz";
}

if (not -e "$perl5_path/bin/cpanm") {
	system "curl -s -L https://cpanmin.us | $perl5 - App::cpanminus";
}

foreach my $module (@modules) {
	system "$perl5_path/bin/cpanm $module";
}

# system "rm -rf /root/.cpanm/";

system "chown -R vagrant.vagrant $perl5_path";

my $node_dir = "node-$version{node}-linux-x86";
if (not -e 'node') {
	system "wget -q https://nodejs.org/dist/$version{node}/$node_dir.tar.gz";
	system "tar xzf $node_dir.tar.gz";
	rename $node_dir, 'node';
	system "chown -R vagrant.vagrant node";
	unlink "$node_dir.tar.gz";
}

my $rakudo_path = "/home/vagrant/rakudo";
my $rakudo = "rakudo-star-$version{rakudo}";
if ( not -e 'rakudo') {
	system "wget -q http://rakudo.org/downloads/star/$rakudo.tar.gz";
	system "tar xzf $rakudo.tar.gz";
	chdir $rakudo;
	system "perl Configure.pl --backend=moar --gen-moar --prefix $rakudo_path";
	system "make";
	system "make install";
	chdir '..';

	system "chown -R vagrant.vagrant $rakudo_path";
	system "rm -rf $rakudo";
	unlink "$rakudo.tar.gz";
}

