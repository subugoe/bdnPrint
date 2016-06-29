#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use open ":std", ":utf8";

use File::Slurp;

my $head = "";
my $tail = read_file("tmp/tmp-1.tex", binmode => ":utf8");
my %sortingMap = (
  "Gen"    => "\x{61}",
  "Ex"     => "\x{62}",
  "Lev"    => "\x{63}",
  "Num"    => "\x{64}",
  "Dtn"    => "\x{65}",
  "Jos"    => "\x{66}",
  "Ri"     => "\x{67}",
  "Rut"    => "\x{68}",
  "1Sam"   => "\x{69}",
  "2Sam"   => "\x{6A}",
  "1Kön"   => "\x{6B}",
  "2Kön"   => "\x{6C}",
  "1Chr"   => "\x{6D}",
  "2Chr"   => "\x{6E}",
  "Esra"   => "\x{6F}",
  "Neh"    => "\x{70}",
  "Est"    => "\x{71}",
  "Hi"     => "\x{72}",
  "Ps"     => "\x{73}",
  "Spr"    => "\x{74}",
  "Pred"   => "\x{75}",
  "Hld"    => "\x{76}",
  "Jes"    => "\x{77}",
  "Jer"    => "\x{78}",
  "Klgl"   => "\x{79}",
  "Ez"     => "\x{7A}",
  "Dan"    => "\x{DF}",
  "Hos"    => "\x{E6}",
  "Joel"   => "\x{F0}",
  "Am"     => "\x{F8}",
  "Obd"    => "\x{FE}",
  "Jona"   => "\x{111}",
  "Mi"     => "\x{127}",
  "Nah"    => "\x{131}",
  "Hab"    => "\x{138}",
  "Zef"    => "\x{142}",
  "Hag"    => "\x{14B}",
  "Sach"   => "\x{153}",
  "Mal"    => "\x{167}",
  "Jdt"    => "\x{180}",
  "Weish"  => "\x{183}",
  "Tob"    => "\x{185}",
  "Sir"    => "\x{188}",
  "Bar"    => "\x{18C}",
  "1Makk"  => "\x{18D}",
  "2Makk"  => "\x{192}",
  "St. zu Est" => "\x{195}",
  "St. zu Dan" => "\x{199}",
  "Man"    => "\x{19A}",
  "Mt"     => "\x{19B}",
  "Mk"     => "\x{19E}",
  "Lk"     => "\x{1A3}",
  "Joh"    => "\x{1A5}",
  "Apg"    => "\x{1A8}‎",
  "Röm"    => "\x{1AA}",
  "1Kor"   => "\x{1AB}",
  "2Kor"   => "\x{1AD}",
  "Gal"    => "\x{1B4}",
  "Eph"    => "\x{1B6}",
  "Phil"   => "\x{1B9}",
  "Kol"    => "\x{1BA}",
  "1Thess" => "\x{1BD}‎",
  "2Thess" => "\x{1BE}‎",
  "1Tim"   => "\x{1BF}",
  "2Tim"   => "\x{1DD}",
  "Tit"    => "\x{1E5}",
  "Phlm"   => "\x{21D}",
  "1Petr"  => "\x{221}",
  "2Petr"  => "\x{223}",
  "1Joh"   => "\x{225}",
  "2Joh"   => "\x{234}",
  "3Joh"   => "\x{235}",
  "Hebr"   => "\x{236}",
  "Jak"    => "\x{237}",
  "Jud"    => "\x{238}",
  "Offb"   => "\x{239}"
);

while ($tail =~ /(\\bibelIndex\{.*?\})/g) {
  my $move = $tail;

  my $passage = $1;
  $passage =~ s/.*\{(.*)\}/$1/;
  my $sortingKey = $passage;

  if ($passage =~ "St. zu Est") {
    $passage =~ s/St\. zu Est /St\. zu Est+/;
    $sortingKey = "St. zu Est";
  } elsif ($passage =~ "St. zu Dan") {
    $passage =~ s/St\. zu Dan /St\. zu Dan+/;
    $sortingKey = "St. zu Dan"
  } else {
    $passage =~ s/(.*?) /$1+/;
    $sortingKey =~ s/(.*?) .*/$1/;
  }

  my $sortingValue = $sortingMap{$sortingKey};

  $move =~ s/(.*?\\bibelIndex).*/$1/;
  my $length = length($move);

  $move = $move . "[$sortingValue $passage]";

  $tail = substr($tail, $length);
  $head = $head . $move;

  $move = "{$passage}";
  $length = length($move);
  $tail = substr($tail, $length);
  $head = $head . $move;
}

$head = $head . $tail;
print $head;
