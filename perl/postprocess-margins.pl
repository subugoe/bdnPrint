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

my $tmp1 = read_file("tmp/" . $ARGV[0] . "_tmp-1.tex");


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
    
   	#$tmp1 =~ s/\\margindata\[inouter\]\{, /\\margindata\[inouter\]\{/g;
    	$tmp1 =~ s/([\w]{1}[\[]{0,1}[0-9IVX]{1,3}[\]]{0,1}), ([\w]{1}[\[]{0,1}[0-9IVX]{1,3}[\]]{0,1})/$1; $2/g;     

    	$tmp1 =~ s/;,/;/g;
	

	# in the cases where there are several pagebreaks in one margin line, try to find out if markers in margin belong to the same
	# pagebreak or not. when several pagebreaks collide into one \vl, the hidden pagebreaks have an \hbox as 4th argument of \margin.
	# in these cases, the pagebreak markes in the margin should be seperated by a comma, otherwise by a semicolon.
	if($note =~ m/([\w]{1}[\[]{0,1}[0-9XVI]{1,4}[\]]{0,1}), ([\w]{1}[\[]{0,1}[0-9XVI]{1,4}[\]]{0,1})/) {
		my @pbNotes = split(', ', $note);

		for(my $j = 0; $j < @pbNotes; $j++) {
			my $pb = $pbNotes[$j];

			# workaround, otherwise [ and ] are treated as part of regex
			$tmp1 =~ s/\[([0-9XIV]*?)\]/!$1!/g;
			$pb =~ s/\[([0-9XIV]*?)\]/!$1!/g;

			# when several pagebreaks in margin belong to the same marker in main text, set comma			
			if($tmp1 =~ m/\\margin\{[\w]{8}\}\{pb\}\{\}\{\\hbox\{\}\}\{$pb\}/) {
				my ($edition) = $pb =~ /([\w])/;
				my ($page) = $pb =~ /([!]{0,1}[0-9XVI]{1,5}[!]{0,1})/;
				# ":" is needed, otherwise "," will be substituted by ";" in for loop
				$tmp1 =~ s/; $pb/, $edition:$page/g;
				# remove superfluous \margin
				$tmp1 =~ s/\\margin\{[\w]{8}\}\{pb\}\{\}\{\\hbox\{\}\}\{$pb\}//g;
			}
		}
	}
  }
}

# remove marker
$tmp1 =~ s/, ([\w]):([!]{0,1}[0-9XVI]{1,4}[!]{0,1})/, $1$2/g;
# replace !...! with [...]
$tmp1 =~ s/!([0-9XIV]*?)!/\[$1\]/g;

print $tmp1;

