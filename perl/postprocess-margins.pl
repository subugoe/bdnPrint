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

# workaround, otherwise [ and ] are treated as part of regex
$tmp1 =~ s/\[([0-9XIV]*?)\]/!$1!/g;
my $moveIntoNextMargindata = "";


for (my $i = 0; $i < @idFile; $i++) {
  my $id = $idFile[$i];
  chomp($id);

  my $note = $notes[$i];
  chomp($note);


  if ($id and $note) {
  	# temporary solution for merging note indicators. @TODO improve
  	$tmp1 =~ s/E,\sE/E/g;
	$tmp1 =~ s/E(,\s.{2,4})+,\sE/E$1/g;
	$tmp1 =~ s/E(,\s\/a\\textbackslash)+,\sE/E$1/g;
	$tmp1 =~ s/E(,\s\/c\\textbackslash)+,\sE/E$1/g;
  	
  	$tmp1 =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[(.{7})\]Es war keinesweges/Es\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[$1\] war keinesweges/g;
 
	if($moveIntoNextMargindata =~ m/[\w]/) {
		print STDERR $moveIntoNextMargindata . "\n";
		# remove pb from original \margindata[inouter]...
		$tmp1 =~ s/$moveIntoNextMargindata/\}/g;
		# ... to the current one
		$tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{)/$1$moveIntoNextMargindata, /g;
		$tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{.*?\})/$1\\margindata\[inouter\]\{$moveIntoNextMargindata\], $note\}/g;
		$moveIntoNextMargindata = "";
	} 
	else {
		$tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{.*?\})/$1\\margindata\[inouter\]\{$note\}/g;
	}
    	$tmp1 =~ s/([\w]{1}[!]{0,1}[0-9IVX]{1,3}[!]{0,1}), ([\w]{1}[!]{0,1}[0-9IVX]{1,3}[!]{0,1})/$1; $2/g;     
	

	# in the cases where there are several pagebreaks in one margin line, try to find out if markers in margin belong to the same
	# pagebreak or not. when several pagebreaks collide into one \vl, the hidden pagebreaks have an \hbox as 4th argument of \margin.
	# in these cases, the pagebreak markers in the margin should be seperated by a comma, otherwise by a semicolon.
	if($note =~ m/([\w]{1}[\[]{0,1}[0-9XVI]{1,4}[\]]{0,1}), ([\w]{1}[\[]{0,1}[0-9XVI]{1,4}[\]]{0,1})/) {
		my @pbNotes = split(', ', $note);
		
		# prepare analyzation of notelength
		$note =~ s/\\textbackslash/\\\&/g;
		my $notesWithoutLastPb = join '', @pbNotes[0 .. $#pbNotes-1];
		my $sizeBeforeLastPb = length($notesWithoutLastPb);
		# undo changes for analyzation
		$note =~ s/\\\&/\\textbackslash/g;

		for(my $j = 0; $j < @pbNotes; $j++) {
			my $pb = $pbNotes[$j];

			# workaround, otherwise [ and ] are treated as part of regex
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

			#@TODO documentation! may also occur in margin notes, where last pb is the only one (isn't considered at the moment
			if(@pbNotes - 1 == $j and $pb =~ m/[\w][!]{0,1}[\dXIV]{1,5}[!]{0,1}/
			# assure that the following line has content in margin, too
			and $notes[$i+1] =~ m/[\w]/
			# has to be adjusted: only 7 for large entries before. has to be larger for small entries.
			and $sizeBeforeLastPb >= 7) {
				$moveIntoNextMargindata = $pb;
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

