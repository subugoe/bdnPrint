#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("2228w.7.xml");



# handling curly braces (otherwise they are interpreted as TeX command)
$tail =~ s/\{/\\\{/g;
$tail =~ s/\}/\\\}/g;


$head = $head . $tail;
print $head;
