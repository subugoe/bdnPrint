#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/griesbach_tmp-1.tex");

$tail =~ s/\\startrdg \\newOddPage/\\newOddPage\\startrdg/g;
$tail =~ s/als gezeigt worden ist;/als gezeigt worden ist;\}\\page\\setnotetext\[footnote\]\[\]\{/g;
$tail =~ s/(als gezeigt worden ist;\})(\\page\\setnotetext\[footnote\]\[\]\{.*?)(\\noindentation 112\. Als \\italic\{die ersten Menschen\}.*?pfers kamen)/$1$3$2/g;
$tail =~ s/\s+und noch ganz unverderbt/\\noindentation und noch ganz unverderbt/g;


$head = $head . $tail;
print $head;