#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $tmp = read_file("" . $ARGV[0] . "_tmp.xml");

$tmp =~ s/@/ /g;

# rdgMarkers
#$tmp =~ s/(rdgMarker wit=".*?" type=".*?" ref=".*?" mark="open" .*?"\/\>)(\%*\s*|@@)/$1/g;

print $tmp;
