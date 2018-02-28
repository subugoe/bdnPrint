#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $tmp = read_file("" . $ARGV[0] . "_tmp.xml");

$tmp =~ s/@/ /g;
#$tmp =~ s/#//g;
#$tmp =~ s/wit=" /wit="/g;

# \xc2\xa0 is U+00A0 in UTF-8
#$tmp =~ s/\xc2\xa0/ /g;
#$tmp =~ s/[\n\r]/\%/g;

#$tmp =~ s/\/(ref|app|hi|bibl|foreign|p)\>\%*\s*\<(ref|app|hi|bibl|foreign|choice|pb|milestone)/\/$1\>@@\<$2/g;
#$tmp =~ s/(\/choice\>)/$1@@/g;
#$tmp =~ s/(\/choice\>)@@\%*\s*(\<rdgMarker wit=".*?" type=".*?" ref=".*?" mark="close")/$1$2/g;

# rdgMarkers
$tmp =~ s/(rdgMarker wit=".*?" type=".*?" ref=".*?" mark="open" .*?"\/\>)(\%*\s*|@@)/$1/g;
#$tmp =~ s/(\<rdgMarker wit=".*?" type="ptl" ref=".{10,30}" mark="close" context="rdg"\/\>)(\<\/aligned\>)/$2$1/g;

print $tmp;
