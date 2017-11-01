#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("noesselt_full.xml");


# handling curly braces (otherwise they are interpreted as TeX command)
$tail =~ s/\{/\\\{/g;
$tail =~ s/\}/\\\}/g;
$tail =~ s/\[Einleitung\]/\\char"005B Einleitung\\char"005D/g;
$tail =~ s/a\\</a\\textbackslash </g;
$tail =~ s/\|/\\|/g;

$head = $head . $tail;
print $head;
