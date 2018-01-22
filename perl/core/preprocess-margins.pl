#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;
use String::Random;

my $head = "";
my $tail = read_file("tmp/" . $ARGV[0] . "_tmp-1.tex");
my $random = new String::Random;

my @idArray = ();

sub generateID {
  my $id = $random->randregex("[A-Za-z]{8}");

  while (grep(/^$id/, @idArray)) {
    $id = $random->randregex("[A-Za-z]{8}");
  }

  return $id;
}

while ($tail =~ /\\margin\{}/) {
  my $move = $tail;
  my $id = generateID();

  $move =~ s/(.*?\\margin)\{\}.*/$1\{$id\}/;
  #$move =~ s/(.*?\\margin)\{\}.*/$1\{\}/;

  $tail = substr($tail, length($move) - 8);
  $head = $head . $move;
}

$head = $head . $tail;
print $head;
