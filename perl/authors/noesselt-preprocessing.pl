#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/noesselt_tmp-1.tex");

$tail =~ s/(b\[II\]\}) (\{\\tfx\\high\{ac)/$1$2/g;


# new pages to avoid orphan and widow lines
$tail =~ s/(\\notTOCsection\[\]\{Editorische Korrekturen\})/\\page $1/g;
$tail =~ s/nisse eben so gut als die/-\\page\\noindentation nisse eben so gut als die/g;
$tail =~ s/(Anmerkungen sowie Anmerkungszeichen)/\\page $1/g;
$tail =~ s/(was in ihnen ist gar nicht,)/$1\\page\\noindentation /g;
$tail =~ s/(Ansichten des Verfassers des Werks zusammen\.)/$1\\page /g;
$tail =~ s/(Uebersicht der Religionen der wichtigsten V.*?lker findet man)/$1\\page\\noindentation /g;
$tail =~ s/(Wie sie sollten getrieben werden, 280.*?287\.\\stopitemize \\stopitemize)/$1\\page\\noindentation /g;
$tail =~ s/(ersetzender Einschub vermerkt\.)\\crlf/$1\\page\\noindentation /g;
$tail =~ s/(Entwurf der folgenden Abhandlung .+?\. 52\.\\stopitemize)/$1\\page\\noindentation /g;
$tail =~ s/(er hat viel dazu beigetragen, den Blick)/$1\\page\\noindentation /g;
$tail =~ s/(Geschichte 208\. 209\.\\stopitemize) (\\sym\{\}\\italic\{Vierter Abschnitt: Symbolische Theologie)/$1\\page$2/g;
$tail =~ s/(eine von ihm wiederum)/$1\\page\\noindentation /g;
$tail =~ s/(eigenen Uebung darin zu thun sey 60.*?67\.\\stopitemize \\stopitemize)/$1\\page\\noindentation /g;

# in order to have an empty column heading
$tail =~ s/(\\startrdg) (\\newOddPage)/$2$1/g;

# correct top margin (has to be set manually since heading of the first preface is part of a reading)
$tail =~ s/(\\startrdg\\starteffect\[hidden\]\. \\stopeffect)\\blank\[26pt\]/$1\\blank\[30pt\]/g;
$tail =~ s/(\\blank)\[36pt(\]\\noindentation \\marking\[oddHeader\]\{Vorreden\})/$1\[30pt$2/g;


$head = $head . $tail;
print $head;
