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
  	$tmp1 =~ s/E,\sE/E/g;
	$tmp1 =~ s/E(,\s.{2,4})+,\sE/E$1/g;
	$tmp1 =~ s/E(,\s\/a\\textbackslash)+,\sE/E$1/g;
	$tmp1 =~ s/E(,\s\/c\\textbackslash)+,\sE/E$1/g;
  	
  	$tmp1 =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[(.{7})\]Es war keinesweges/Es\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[$1\] war keinesweges/g;
  
    $tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{.*?\})/$1\\margindata\[inouter\]\{$note\}/g;
    
    $tmp1 =~ s/\\margindata\[inouter\]\{, /\\margindata\[inouter\]\{/g;
    
    $tmp1 =~ s/;,/;/g;
  }
  print STDERR "NOTE: " . $note . "\n";
}

print $tmp1;

