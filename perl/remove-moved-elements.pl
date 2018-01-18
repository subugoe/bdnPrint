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
	my $context = join ', ', @elements[0 .. $#elements-1];
	my $element = $elements[-1];

	print STDERR $note . "\n";
	print STDERR $element . "\n";	
	print STDERR $context . "\n";

	my ($edition) = $element =~ /([a-z])/;
	my ($page) = $element =~ /([\dXVI]+)/; 

	# note has to be used as pattern BUT: we have /a\textbackslash etc --> slashes are interpreted as part of regex! @TODO
	my $patternTmp = " " . $element . "\}";

	#$tmp =~ s/$pattern/\}/g;
}

# replace !...! with [...]
$tmp =~ s/!([0-9XIV]*?)!/\[$1\]/g;

print $tmp;

