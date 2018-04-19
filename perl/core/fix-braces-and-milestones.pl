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
$tail =~ s/([a-z])\\</$1\\textbackslash </g;
$tail =~ s/\|/\\|/g;

# handling of milestones
# e2 88 ab: UTF-8 integral
# e2 88 ac: UTF-8 double integral
$tail =~ s/\xe2\x88\xab/\\line\{\}/g;
$tail =~ s/\xe2\x88\xac/\\p\{\}/g;

$head = $head . $tail;
print $head;
