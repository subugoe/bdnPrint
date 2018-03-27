#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/" . $ARGV[0] . "_tmp-1.tex");

$tail =~ s/\s+/ /g;
$tail =~ s/ +/ /g;
$tail =~ s/ ~/~/g;
$tail =~ s/~ /~/g;

# remove all whitespaces at the beginning and end of TeX expressions
$tail =~ s/\{\s+/\{/g;
$tail =~ s/\s+}/}/g;

# no linebreak for scribal signs after list in ppl/ptl. 
# in this case we pretend that the closing abbreviation is part of the list
$tail =~ s/\\stopitemize\\margin(.+?)\{plClose}\{d1e(.+?)}\{\\tfx\\high\{c}}\{c}/\\margin$1\{plClose}\{d1e$2}\{\\tfx\\high\{c}}\{c}\\stopitemize/g;

$tail =~ s/(\\textbackslash\}\})(\\margin\{.*?\}\{pb)/$1 $2/g;

# fixing rdgMarkers
$tail =~ s/\} \\nobreak/\}\\nobreak/g;


# fixing whitespaces before punctuation
$tail =~ s/ ([,\.;\)\?}])/$1/g;
$tail =~ s/} ([,\.;\):}])/}$1/g;

# fixing whitespace after punctuation 
# if followed by scribal abbreviation
$tail =~ s/([,\.;\)\?}]) (\\margin\{.{8}\}\{plClose\})/$1$2/g;

#e2 80 9c: utf8 codepoint for LEFT DOUBLE QUOTATION MARK
$tail =~ s/ \x{201C}/\x{201C}/g;
$tail =~ s/ \xe2\x80\x9c/\xe2\x80\x9c/g;

$tail =~ s/ \./\./g;
$tail =~ s/\( \\/\(\\/g;
$tail =~ s/} \\italic\{,/}\\italic\{,/g;
$tail =~ s/} \\italic\{:/}\\italic\{:/g;
$tail =~ s/\\tfx\\high\{\/a}} \{\\tfx\\high\{\/c}/\\tfx\\high\{\/a}}\{\\tfx\\high\{\/c}/g;
$tail =~ s/(\{\\tfx\\high\{[a-z]\\textbackslash\}\}) (\\margin\{.{0,8}\}\{omClose)/$1$2/g;
$tail =~ s/\{\/a} \{\\tfx\\high\{\/c}/\{\/a}\{\\tfx\\high\{\/c}/g;
$tail =~ s/\\margindata\[inouter\]\{\/a} \{\\tfx\\high\{\/c}}/\\margindata\[inouter\]\{\/a}\{\\tfx\\high\{\/c}}/g;
$tail =~ s/\s\x{201C}/\x{201C}/g;
$tail =~ s/ \x{0022}/\x{0022}/g;
$tail =~ s/ \x{00AB}/\x{00AB}/g;
$tail =~ s/ \x{02BA}/\x{02BA}/g;
$tail =~ s/ \x{02DD}/\x{02DD}/g;
$tail =~ s/ \x{02EE}/\x{02EE}/g;
$tail =~ s/ \x{201C}/\x{201C}/g;
$tail =~ s/ \x{030E}/\x{059E}/g;


# fixing §.... to §. ...
$tail =~ s/\.\.\.\./\. \.\.\./g;

# individual cases of whitespace problems
#$tail =~ s/c119}\\italic\{Pfaff,/c119} \\italic\{Pfaff,/g;
#$tail =~ s/\\italic\{Weisman,}\\/\\italic\{Weisman,} \\/g;
#$tail =~ s/b51} 38/b51}38/g;
#$tail =~ s/ \{\\startalignment/\{\\startalignment/g;
#$tail =~ s/a595, b17, c16} /a595, b17, c16}/g;
#$tail =~ s/\\stopalignment} \\margin/\\stopalignment}\\margin/g;

# remove vertical whitespace before headings, might need further improvement
for (my $i=0; $i <= 9; $i++) {
  $tail =~ s/\\blank\[.{0,10}?\](.{0,50}?\\startsubject)/$1/g;
  $tail =~ s/\\noindent(.{0,50}?\\startsubject)/$1/g;
}


$tail =~ s/ +/ /g;



# for each footnote in the critical apparatus...
# @TODO hängt sich bei Leß auf -- while terminiert nicht. Warum?
#while ($tail =~ /\\[a-dz]{0,8}Note/) {
#  my $move = $tail;

#  $move =~ s/(.*?\\[a-dz]{0,8}Note).*/$1/;

#  $tail = substr($tail, length($move));
#  $head = $head . $move;

#  $move = $tail;

#  $move =~ s/(.*?}).*/$1/;

#  my $count1 = ($move =~ tr/{//);
#  my $count2 = ($move =~ tr/}//);

#  my $regex = ".*?}";

#  while ($count1 != $count2) {
#    $move = $tail;

#    $regex = $regex . ".*?}";
#    $move =~ s/($regex).*/$1/;

#    $count1 = ($move =~ tr/{//);
#    $count2 = ($move =~ tr/}//);
#  }

#  $tail = substr($tail, length($move));
#  $head = $head . $move;


  # ... find its end and add a non-breaking space if it is followed by a margin
  # or a high command

#  if ($tail =~ /^\\margin/ || $tail =~ /^{\\tfx\\high/) {
#    $head = $head . "~";
#  }
#}

$head = $head . $tail;
print $head;
