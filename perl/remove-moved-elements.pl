#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

open(FILE, "<tmp/moved_elements.txt") or die "$!\n";
my @notes = <FILE>;
close(FILE);

my $tmp = read_file("tmp/" . $ARGV[0] . "_tmp-3.tex");

for (my $i = 0; $i < @notes; $i++) {
  my $note = $notes[$i];
  chomp($note);

	my @elements = split(', ', $note);
	my $element = $elements[-1];
	my ($context) = $note =~ /(.*) $element/;
	# has to escaped because of regex
	$note =~ s/([\/\\])/\\$1/g;

	my $pattern = $note . "\}";
	$tmp =~ s/$pattern/$context\}/g;
}

# replace !...! with [...]
$tmp =~ s/!([0-9XIV]*?)!/\[$1\]/g;

print $tmp;

