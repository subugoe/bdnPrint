#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $tmp = read_file("" . $ARGV[0] . "_tmp.xml");

$tmp =~ s/@/ /g;

# round brackets around Hebrew words have to be switched inside the foreign element, because otherwise the bidirectional
# flow causes the brackets to be rendered before the Hebrew word, e.g. ()‫ם‬ ‫י‬ ‫א‬ ‫ד‬ ‫ו‬ ‫ד‬  instead of (‫ם‬ ‫י‬ ‫א‬ ‫ד‬ ‫ו‬ ‫ד‬). same holds for
# punctuation.
$tmp =~ s/\((\<foreign xml:lang="he".{0,18}\>)(.*?)(\<\/foreign\>)\)/$1\($2\)$3/g;

print $tmp;
