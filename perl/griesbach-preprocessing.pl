#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/griesbach_tmp-1.tex");

$tail =~ s/\\startrdg \\newOddPage/\\newOddPage\\startrdg/g;


$head = $head . $tail;
print $head;