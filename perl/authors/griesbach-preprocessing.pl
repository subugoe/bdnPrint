#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/griesbach_tmp-1.tex");

$tail =~ s/\\startrdg \\newOddPage\\noindentation/\\page\\noheaderandfooterlines\\startrdg/g;
$tail =~ s/als gezeigt worden ist;/als gezeigt worden ist;\}\\page\\setnotetext\[footnote\]\[\]\{/g;
$tail =~ s/(als gezeigt worden ist;\})(\\page\\setnotetext\[footnote\]\[\]\{.*?)(\\noindentation 112\. Als \\italic\{die ersten Menschen\}.*?pfers kamen)/$1$3$2/g;
$tail =~ s/\s+und noch ganz unverderbt/\\noindentation und noch ganz unverderbt/g;
#$tail =~ s/(\{b\\textbackslash, d40\},) (\\footnote\{.*?hiebei\})( auch.*?\\dNote\{gemacht werden\})/$1$3$2/g;
$tail =~ s/(\\footnote\{\\margin\{\}\{omOpen\}\{N1\.4\.4\.2\.4\.4\.10\.38\.5\.24\.2\.6\.4.*?hiebei\}) (auch \{\\tfx\\high\{\/b\}\}izt noch .*?lehrreich \{\\tfx\\high\{\/d\}\}seyn\{\\tfx\\high\{d\\textbackslash\}\} \{\\dvl\}\\dNote\{gemacht werden\})/$2$1/g;
#$tail =~ s///g;

$tail =~ s/\\writetolist\[section/\\writetolist\[part/g;

$head = $head . $tail;
print $head;