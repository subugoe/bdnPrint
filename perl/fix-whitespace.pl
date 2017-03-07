#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/tmp-1.tex");


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

# fixing whitespaces before punctuation
$tail =~ s/ ,/,/g;
$tail =~ s/} ,/},/g;
$tail =~ s/ \./\./g;
$tail =~ s/} \./}\./g;
$tail =~ s/ ;/;/g;
$tail =~ s/} ;/};/g;
$tail =~ s/ \)/\)/g;
$tail =~ s/} \)/}\)/g;
$tail =~ s/\( \\/\(\\/g;
$tail =~ s/ \?/\?/g;
$tail =~ s/} \\italic\{,/}\\italic\{,/g;
$tail =~ s/} :/}:/g;
$tail =~ s/} \\italic\{:/}\\italic\{:/g;
$tail =~ s/\\tfx\\high\{\/a}} \{\\tfx\\high\{\/c}/\\tfx\\high\{\/a}}\{\\tfx\\high\{\/c}/g;

# German quotation marks
$tail =~ s/„(.+?)“/\\quotation\{$1}/g;
#$tail =~ s/ . /$1ASDF /g;


# fixing §.... to §. ...
$tail =~ s/\.\.\.\./\. \.\.\./g;

# individual cases of whitespace problems
$tail =~ s/c119}\\italic\{Pfaff,/c119} \\italic\{Pfaff,/g;


# remove vertical whitespace before headings, might need further improvement
for (my $i=0; $i <= 9; $i++) {
  $tail =~ s/\\blank\[.{0,10}?\](.{0,50}?\\startsubject)/$1/g;
  $tail =~ s/\\noindent(.{0,50}?\\startsubject)/$1/g;
}


$tail =~ s/ +/ /g;



# for each footnote in the critical apparatus...

while ($tail =~ /\\[a-i]{0,8}Note/) {
  my $move = $tail;

  $move =~ s/(.*?\\[a-i]{0,8}Note).*/$1/;

  $tail = substr($tail, length($move));
  $head = $head . $move;

  $move = $tail;

  $move =~ s/(.*?}).*/$1/;

  my $count1 = ($move =~ tr/{//);
  my $count2 = ($move =~ tr/}//);

  my $regex = ".*?}";

  while ($count1 != $count2) {
    $move = $tail;

    $regex = $regex . ".*?}";
    $move =~ s/($regex).*/$1/;

    $count1 = ($move =~ tr/{//);
    $count2 = ($move =~ tr/}//);
  }

  $tail = substr($tail, length($move));
  $head = $head . $move;


  # ... find its end and add a non-breaking space if it is followed by a margin
  # or a high command

  if ($tail =~ /^\\margin/ || $tail =~ /^{\\tfx\\high/) {
    $head = $head . "~";
  }
}

$head = $head . $tail;
print $head;
