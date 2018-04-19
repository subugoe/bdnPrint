# A#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $tmp = read_file("tmp/" . $ARGV[0] . "_tmp-3.tex");

# in cases of \rightaligned, data in margins isn't displayed (fixed by following regexes)

# A. d. H.^c
$tmp =~ s/(\\rightaligned\{[A\.\s]{0,3}[dD]{1}\. H\.\\margin\{.{0,8}\}\{plClose\}\{.{10,50}\}\{\\tfx\\high\{c\}\}\{c\}\})/$1\\margindata\[inouter\]\{c\}/g;
# A. d. H.[}]^c
$tmp =~ s/(\\rightaligned\{A\. d\. H\.\{\[\\\}\]\}\\margin\{.{0,8}\}\{plClose\}\{.{10,50}\}\{\\tfx\\high\{c\}\}\{c\}\})/$1\\margindata\[inouter\]\{c\}/g;
# A. d. H.^(c a\)
$tmp =~ s/(\\rightaligned\{A\. d\. H\.\\margin\{.{0,8}\}\{plClose\}\{.{10,50}\}\{\\tfx\\high\{c\}\}\{c\}\~)(\\margin\{.{0,8}\}\{omClose\}\{.{10,50}\}){0,1}(\{\\tfx\\high\{a\\textbackslash\}\})(\{a\\textbackslash\}\}){0,1}/$1$2$3$4\\margindata\[inouter\]\{c, a\\textbackslash\}/g;
# A. d. H.}^c
$tmp =~ s/(\\rightaligned\{[A\.\s]{0,3}[dD]{1}\. H\.\\\}\\margin\{.{0,8}\}\{plClose\}\{.{10,50}\}\{\\tfx\\high\{c\}\}\{c\}\})/$1\\margindata\[inouter\]\{c\}/g;
# A. d. H.}^c a\
$tmp =~ s/(\\rightaligned\{A\. d\. H\.\\\}\\margin\{.{0,8}\}\{plClose\}\{.{10,50}\}\{\\tfx\\high\{c\}\}\{c\}~\\margin\{.{0,8}\}\{omClose\}\{.{10,50}\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\})/$1\\margindata\[inouter\]\{c, a\\textbackslash\}/g;

#$tmp =~ s/(\\rightaligned\{D\. H\.\\margin\{.{0,8}\}\{plClose\}\{.{10,50}\}\{\\tfx\\high\{c\}\}\{c\}\})/$1\\margindata\[inouter\]\{c\}/g;
$tmp =~ s/(\\rightaligned\{\\italic\{Der Herausgeber\.\}\\margin\{.{0,8}\}\{plClose\}\{.{10,50}\}\{\\tfx\\high\{c\}\}\{c\}\})/$1\\margindata\[inouter\]\{c\}/g;
$tmp =~ s/(\\rightaligned\{Der Herausgeber\.\\margin\{.{0,8}\}\{plClose\}\{.{10,50}\}\{\\tfx\\high\{c\}\}\{c\}\})/$1\\margindata\[inouter\]\{c\}/g;
$tmp =~ s/(\\rightaligned\{\\classicsIndex\{Cicero\}\\italic\{Cic\.\}\\margin\{.{0,8}\}\{plClose\}\{.{10,50}\}\{\\tfx\\high\{c\}\}\{c\}\})/$1\\margindata\[inouter\]\{c\}/g;

# margin overflow
$tmp =~ s/(c!3!)(\} Zweyter)/$1\]$2/g;

# wrong separation of pagebreaks
$tmp =~ s/(a413),( b128, E)/$1;$2/g;
$tmp =~ s/(c130),( b148)/$1;$2/g;
$tmp =~ s/(a117),( b143)/$1;$2/g;
$tmp =~ s/(a414\[!\]),( b146)/$1;$2/g;
$tmp =~ s/(b189),( c164)/$1;$2/g;
$tmp =~ s/(a748),( c156)/$1;$2/g;


# wrong order of sigla
#$tmp =~ s/(\/c)(\\textbackslash)(, \/a\\textbackslash, E)/$1$3, c$2/g;


# hyphenation
$tmp =~ s/(\{\/c\\textbackslash\}der)(selben)/$1-\\hskip0pt $2/g;
# aufhören zu sündigen
# ce b8: utf-8 codepoint for theta
# ce b5: utf-8 codepoint for epsilon
$tmp =~ s/(\xce\xb8\xce\xb5\\cNote\{)/-\\hskip0pt $1/g;

# editorial comments that cause empty lines
#$tmp =~ s/(\\margin\{.*?\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[.*?\])(\\personsIndex\{Adelung, Johann Christoph\}\\italic\{Adelungs\}\\cNote\{\\italic\{Adelung's\}\})/$2$1/g;

$tmp =~ s/(\\margin\{.{0,8}\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[.{0,8}\])(\\personsIndex\{Adelung, Johann Christoph\}\\italic\{Adelungs\}\\cNote\{\\italic\{Adelung's\}\} Magazin)/$2$1\\margindata\[inouter\]\{E\}/g;
$tmp =~ s/(So \\margin\{.{0,8}\}\{e\}\{\}\{\\hbox\{\}\}\{E\})(\\pagereference\[.{0,8}\])/$1\\margindata\[inouter\]\{E\}$2/g;
$tmp =~ s/(\\margin\{.{0,8}\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[.{0,8}\])(Abhandlung)/$2$1\\margindata\[inouter\]\{E\}/g;

print $tmp;