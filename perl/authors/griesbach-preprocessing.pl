#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/griesbach_tmp-1.tex");

$tail =~ s/\\startrdg \\newOddPage\\noindentation/\\page\\noheaderandfooterlines\\startrdg/g;
$tail =~ s/(\\startrdg )(\\newOddPage)/$2$1/g;

# correct even and odd pages
$tail =~ s/\\page\[empty\](\\noheaderandfooterlines\\setuppagenumber\[number=1\])/\\page$1/g;

# necessary to get right structure in TOC
$tail =~ s/\\writetolist\[section/\\writetolist\[part/g;
$tail =~ s/\\writetolist\[chapter\]\{\}\{Vorreden/\\writetolist\[part\]\{\}\{Vorreden/g;


# first two prefaces on one page plus right margin between two prefaces
$tail =~ s/\\page(\\marking\[oddHeader\]\{Vorrede zur dritten Ausgabe)/\\blank\[24pt\]$1/g;


# two title pages on a page, bigger space between title pages
$tail =~ s/(Hellers Schriften\\crlf 1779\..*?\\stoprdg)/$1 \\page/g;
$tail =~ s/(\\stopalignment\})(\\startrdg\{\\startalignment\[center\])/$1 \\blank\[36pt\]$2/g;
$tail =~ s/(\\stopalignment\}\\stoprdg) \\noindentation (\\startrdg\{\\startalignment\[center\])/$1 \\blank\[36pt\]$2/g;


# always begin on right-hand side
$tail =~ s/\\newOddPage(\\writetolist\[part\]\{\}\{V\. Zustand)/\\newPage$1/g;


# paragraphs
$tail =~ s/\\par (Anhand der vorliegenden)/\\crlf \\starteffect\[hidden\].\\stopeffect\\hspace\[p\]$1/g;


# special hyphenation cases
# anfäng-|lich
$tail =~ s/(ng)(\}\\margin)/$1-$2/g;
$tail =~ s/ (\\italic\{lich in)/$1/g;
# c.f. https://tex.stackexchange.com/questions/35370/allowing-breaks-at-a-location-with-no-spaces-or-hyphens?rq=1
$tail =~ s/(\{\/a\}Betrach)(tungen)/$1-\\hskip0pt $2/g;
$tail =~ s/(vorzunehm)(en\{\\tfx)/$1-\\crlf $2/g;


# editorial corrigenda

$tail =~ s/(23\.\\NC \\NR \\NC)/$1\\stoptabulate \\blank\[-24pt\]\\starttabulatehead\\FL \\NC Seite \\NC fehlerhaftes Original \\NC stillschweigende Korrektur \\NC \\AR \\LL \\stoptabulatehead\\starttabulate\[|p\(1cm\)|p|p|\]\\NC/g;

# special cases of pagebreaks
$tail =~ s/(dagogischen Vor)/$1-\\page\\noindentation /g;
$tail =~ s/(wird erst im Zuge)/$1\\page\\noindentation /g;



$head = $head . $tail;
print $head;