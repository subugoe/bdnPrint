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
#$tail =~ s/(\\sym\{\}\\italic\{Vierter Abschnitt: Symbolische Theologie\.\})/\\page $1/g;

$head = $head . $tail;
print $head;
