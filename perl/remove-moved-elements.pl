#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

open(FILE, "<tmp/moved_elements.txt") or die "$!\n";
my @elements = <FILE>;
close(FILE);

my $tmp = read_file("tmp/" . $ARGV[0] . "_tmp-3.tex");

for (my $i = 0; $i < @elements; $i++) {
  my $element = $elements[$i];
  chomp($element);

	my ($edition) = $element =~ /([a-z])/;
	my ($page) = $element =~ /([\dXVI]+)/; 
	my $pattern = " " . $element . "\}";

	$tmp =~ s/$pattern/\}/g;
}

# replace !...! with [...]
$tmp =~ s/!([0-9XIV]*?)!/\[$1\]/g;

print $tmp;

