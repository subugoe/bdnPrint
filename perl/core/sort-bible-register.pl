#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use open ":std", ":utf8";

use File::Slurp;

my $head = "";
my $tail = read_file("tmp/" . $ARGV[0] . "_tmp-1.tex", binmode => ":utf8");
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
  "Ijob"   => "\x{72}",
  "Ps"     => "\x{73}",
  "Spr"    => "\x{74}",
  "Koh"    => "\x{75}",
  "Hld"    => "\x{76}",
  "Jes"    => "\x{77}",
  "Jer"    => "\x{78}",
  "Klgl"   => "\x{79}",
  "Ez"     => "\x{7A}",
  "Dan"    => "\x{F0}",
  "Hos"    => "\x{FE}",
  "Joel"   => "\x{131}",
  "Am"     => "\x{138}",
  "Obd"    => "\x{14B}",
  "Jona"   => "\x{185}",
  "Mi"     => "\x{18D}",
  "Nah"    => "\x{195}",
  "Hab"    => "\x{19B}",
  "Zef"    => "\x{1A3}",
  "Hag"    => "\x{1A8}",
  "Sach"   => "\x{1AA}",
  "Mal"    => "\x{1B9}",
  "Jdt"    => "\x{1BD}",
  "Weish"  => "\x{1BE}",
  "Tob"    => "\x{1BF}",
  "Sir"    => "\x{1DD}",
  "Bar"    => "\x{21D}",
  "1Makk"  => "\x{223}",
  "2Makk"  => "\x{237}",
  "ZusEst" => "\x{238}",
  "ZusDan" => "\x{239}",
  # from now on new
  "GebMan" => "\x{241}",
  "Mt"     => "\x{251}",
  "Mk"     => "\x{259}",
  "Lk"     => "\x{283}",
  "Joh"    => "\x{292}",
  "Apg"    => "\x{298}‎",
  "Röm"    => "\x{2A3}",
  "1Kor"   => "\x{2A4}",
  "2Kor"   => "\x{2A6}",
  "Gal"    => "\x{2A7}",
  "Eph"    => "\x{2A8}",
  "Phil"   => "\x{2AB}",
  "Kol"    => "\x{2AC}",
	"1Thess" => "\x{E44}",
	"2Thess" => "\x{E45}",
  "1Tim"   => "\x{E46}",
  "2Tim"   => "\x{E47}",
  "Tit"    => "\x{E48}",
  "Phlm"   => "\x{E49}",
  "1Petr"  => "\x{E4A}",
  "2Petr"  => "\x{E4B}",
  "1Joh"   => "\x{E4C}",
  "2Joh"   => "\x{E4D}",
  "3Joh"   => "\x{E4E}",
  "Hebr"   => "\x{E4F}",
  "Jak"    => "\x{E50}",
  "Jud"    => "\x{E51}",
  "Offb"   => "\x{E52}"
);


while ($tail =~ /(\\bibleIndex\{.*?\})/g) {
  my $move = $tail;

  my $passage = $1;
  $passage =~ s/.*\{(.*)\}/$1/;
  my ($sortingKey) = $passage =~ /(.+)\+/;  

  my $sortingValue = $sortingMap{$sortingKey};

  $move =~ s/(.*?\\bibleIndex).*/$1/;
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
