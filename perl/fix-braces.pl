#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("input/" . $ARGV[0] . ".xml");


# handling curly braces (otherwise they are interpreted as TeX command)
$tail =~ s/\{/\\\{/g;
$tail =~ s/\}/\\\}/g;
$tail =~ s/a\\</a\\textbackslash </g;
$tail =~ s/\|/\\|/g;

$head = $head . $tail;
print $head;
