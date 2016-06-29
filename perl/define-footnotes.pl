#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use List::MoreUtils qw(uniq);

open(FILE, "<2501b.2.xml") or die "$!\n";
my @lines = <FILE>;
close(FILE);

my @apps;

for my $line (@lines) {
  my @lineApps = $line =~ /wit="(.*?)"/g;
  s/[^a-z]//g for (@lineApps);
  push(@apps, @lineApps);
}

@apps = sort(uniq(@apps));

my $counter = 0;

for my $app (@apps) {
$counter = $counter + 1;

# ConTeXt support up to ~120 custom notes

if ($counter <= 120) {
print "
\\def\\my${app}#1{%
  \\tfx\\high{${app}#1}%
}

\\definenote[${app}Note]
  [before={\\blank[4mm]},
   after={\\blank[-8mm]},
   textcommand=\\my$app,
   paragraph=yes,
   rule=off]

\\setupnotation[${app}Note]
  [alternative=serried,
   before=\{\\bf ${app}},
   numbercommand=\\tf\\bf,
   style={\\switchtobodyfont[8.5pt]},
   way=bysection, % bypage does not work properly at the moment
   width=broad]
"
}
}
