#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

#my $tail = read_file("noesselt_full.xml");
#my $tail = read_file("griesbach_full.xml");
my $tail = read_file("noesselt_full_tmp.xml");
#my $tail = read_file("listenrand.xml");


#fix broken codepoints
$tail =~ 

$head = $head . $tail;
print $head;
