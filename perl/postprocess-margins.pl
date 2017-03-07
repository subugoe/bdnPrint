#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

open(FILE, "<tmp/id-file.txt") or die "$!\n";
my @idFile = <FILE>;
close(FILE);

open(FILE, "<tmp/notes.txt") or die "$!\n";
my @notes = <FILE>;
close(FILE);

my $tmp1 = read_file("tmp/tmp-1.tex");



for (my $i = 0; $i < @idFile; $i++) {
  my $id = $idFile[$i];
  chomp($id);

  my $note = $notes[$i];
  chomp($note);

  if ($id and $note) {
  	# temporary solution for merging note indicators
  	$tmp1 =~ s/E(,\sE)/E/g;
  
    $tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{.*?\})/$1\\margindata\[inouter\]\{$note\}/g;
    
    $tmp1 =~ s/;,/;/g;
  }
}

print $tmp1;
