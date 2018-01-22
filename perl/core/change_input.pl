#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("noesselt-preprocessing.pl");

$tail =~ s/input\.tex/tmp\/noesselt_tmp-1\.tex/g;

$head = $head . $tail;
print $head;