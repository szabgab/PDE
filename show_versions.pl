#!/usr/bin/perl
use strict;
use warnings;
use 5.022;
use Cwd qw(abs_path);
use File::Basename qw(dirname);

my ($test) = @ARGV;

my $perl5_path = "/home/vagrant/localperl";
my $perl5 = "$perl5_path/bin/perl";


my $file = dirname(abs_path($0)) . '/modules.txt';
open my $fh, '<', $file or die "Could not open file '$file': $!\n";
my @modules = <$fh>;
chomp @modules;

foreach my $module (@modules) {
	eval "use $module";
	die $@ if $@;
    say $module . ' ' . $module->VERSION;
}

