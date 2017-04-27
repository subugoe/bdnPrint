#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/tmp-1.tex");


# fixing type area for Noesselt
$tail =~ s/mathematischen \{\\tfx\\high\{\/c}}Wissenschaften/mathematischen \{\\tfx\\high\{\/c}}Wissen- schaften/g;
$tail =~ s/\{\\tfx\\high\{\/c}}Wissenschaften,\\aNote\{Wissenschaften}/\{\\tfx\\high\{\/c}}Wissen- schaften,\\aNote\{Wissenschaften}/g;
# PERL has a problem with ä - regex does not match
#$tail =~ s/\{\\tfx\\high\{\/c}}\\sachIndex\[ERL\QÄ\EUTERUNGSSCHRIFTEN\]\{Erl\Qä\Euterungsschriften}Erl\Qä\Euterungsschriften/\{\\tfx\\high\{\/c}}\\sachIndex\[ERL\QÄ\EUTERUNGSSCHRIFTEN\]\{Erl\Qä\Euterungsschriften}Erl\Qä\Eu- terungsschriften/g;
$tail =~ s/uterungsschriften kan/u- terungsschriften kan/g;
$tail =~ s/\{\\tfx\\high\{\/c}}\\sachIndex\[KIRCHENGESCHICHTE\]\{Kirchengeschichte}Kirchengeschichte,/\{\\tfx\\high\{\/c}}\\sachIndex\[KIRCHENGESCHICHTE\]\{Kirchengeschichte}Kirchen- geschichte,/g;
$tail =~ s/\{d1e108956}\{\\tfx\\high\{\/c}}\{\/c}derselben/\{d1e108956}\{\\tfx\\high\{\/c}}\{\/c}dersel- ben/g;
$tail =~ s/genommne\\cNote\{genommene}/genomm- ne\\cNote\{genommene}/g;


$head = $head . $tail;
print $head;