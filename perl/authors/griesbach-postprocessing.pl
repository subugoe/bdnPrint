#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $tmp = read_file("tmp/" . $ARGV[0] . "_tmp-3.tex");

# in cases of \rightaligned, data in margins isn't displayed (fixed by following regexes)
$tmp =~ s/(\\rightaligned\{D\. J\. J\. Griesbach\.\\margin\{.{1,9}\}\{omClose\}\{N1\.4\.4\.2\.2\.2\.5\.6\.4\}\{\\tfx\\high\{abd\\textbackslash\}\}\{abd\\textbackslash\}\})/$1\\margindata\[inouter\]\{abd\\textbackslash\}/g;
$tmp =~ s/(J\. J\. Griesbach\.\\margin\{.{1,9}\}\{plClose\}\{N1\.4\.4\.2\.2\.2\.5\.8\.2\.1\.14\.16\.4\}\{\\tfx\\high\{b\}\}\{b\}~\\margin\{.{1,9}\}\{omClose\}\{N1\.4\.4\.2\.2\.2\.5\.8\.4\}\{\\tfx\\high\{ad\\textbackslash\}\}\{ad\\textbackslash\}\})/$1\\margindata\[inouter\]\{b, ad\\textbackslash\}/g;


$tmp =~ s/(\\margin\{.{0,8}\}\{plOpen\}\{N1\.4\.4\.2\.2\.2\.5\.8\.2\.1\.14\.16\.4\}\{\\tfx\\high\{b\}\}\{b\})\\margindata\[inouter\]\{b\}(\\personsIndex\{Griesbach, Johann Jakob\}\\crlf \\rightaligned\{)/$2$1/g;

# fixing broken margins
#$tmp =~ s/(\} Vorerinnerung\.\})/\]$1/g;
#$tmp =~ s/(\}stalten)/\]$1/g;
#$tmp =~ s/(\} Inhalt\.)/\]$1/g;
#$tmp =~ s/d154\}\./d154\]\}\./g;
$tmp =~ s/(c50; d51, \/a\\textbackslash, \/a, b35)/$1\\bb\{\} a\\textbackslash, c51, d52/g;
$tmp =~ s/\\margindata\[inouter\]\{a\\textbackslash, c51, d52\}//g;


print $tmp;