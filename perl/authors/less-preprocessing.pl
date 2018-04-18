#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/less_tmp-1.tex");

#$tail =~ s/\\midaligned\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{([a-z][\[]{0,1}[0-9XVI]{1,7}[\]]{0,1})\}/\\margin\{\}\{pb\}\{\}\{\\vl\}\{$1\}\\midaligned\{/g;



$head = $head . $tail;
print $head;