#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/tmp-1.tex");

#$tail =~ s/\x{E2}/--/g;


# fixing type area for Noesselt
$tail =~ s/mathematischen \{\\tfx\\high\{\/c}}Wissenschaften/mathematischen \{\\tfx\\high\{\/c}}Wissen- schaften/g;
$tail =~ s/\{\\tfx\\high\{\/c}}Wissenschaften,\\aNote\{Wissenschaften}/\{\\tfx\\high\{\/c}}Wissen- schaften,\\aNote\{Wissenschaften}/g;
# PERL has a problem with ä - regex does not match
#$tail =~ s/\{\\tfx\\high\{\/c}}\\sachIndex\[ERL\QÄ\EUTERUNGSSCHRIFTEN\]\{Erl\Qä\Euterungsschriften}Erl\Qä\Euterungsschriften/\{\\tfx\\high\{\/c}}\\sachIndex\[ERL\QÄ\EUTERUNGSSCHRIFTEN\]\{Erl\Qä\Euterungsschriften}Erl\Qä\Eu- terungsschriften/g;
$tail =~ s/uterungsschriften kan/u- terungsschriften kan/g;
$tail =~ s/\{\\tfx\\high\{\/c}}\\sachIndex\[KIRCHENGESCHICHTE\]\{Kirchengeschichte}Kirchengeschichte,/\{\\tfx\\high\{\/c}}\\sachIndex\[KIRCHENGESCHICHTE\]\{Kirchengeschichte}Kirchen- geschichte,/g;
$tail =~ s/\{d1e108956}\{\\tfx\\high\{\/c}}\{\/c}derselben/\{d1e108956}\{\\tfx\\high\{\/c}}\{\/c}dersel- ben/g;
$tail =~ s/genommne\\cNote\{genommene}/genomm- ne\\cNote\{genommene}/g;
$tail =~ s/im praktischen Verstan/im praktischen Ver-stan/g;
$tail =~ s/\{a246\}genth/\{a246\}gen-th/g;
#$tail =~ s/\{\\tfx\\high\{\/c\}\}gemeinschaftlicher/\{\\tfx\\high\{\/c\}\}gemeinschaft-licher/g;
$tail =~ s/348\/47/ 348\/47/g;
$tail =~ s/1580\) galt/ 1580\) galt/g;
$tail =~ s/1791\) in kaum/ 1791\) in kaum/g;
$tail =~ s/1801\) erschien/ 1801\) erschien/g;
$tail =~ s/1701\) ist 1698/ 1701\) ist 1698/g;
$tail =~ s/1803\) umfasst/ 1803\) umfasst/g;
$tail =~ s/1791\) verbinden sich/ 1791\) verbinden sich/g;


#doesn't work properly
$tail =~ s/\{\/c\\textbackslash\}derselben/\{\/c\\textbackslash\}dersel-ben/g;


$head = $head . $tail;
print $head;