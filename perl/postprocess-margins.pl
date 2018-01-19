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

my $file_location = "tmp/moved_elements.txt";
open(my $file, ">", $file_location) or die $!;

my $tmp1 = read_file("tmp/" . $ARGV[0] . "_tmp-1.tex");

my $moveIntoNextMargindata = "";

for (my $i = 0; $i < @idFile; $i++) {
	# workaround, otherwise [ and ] are treated as part of regex
	$tmp1 =~ s/\[([0-9XIV]*?)\]/!$1!/g;
  my $id = $idFile[$i];
  chomp($id);

  my $note = $notes[$i];
  chomp($note);

  if ($id and $note) {
		# workaround, otherwise [ and ] are treated as part of regex
		if($note =~ m/\[[\dXVI]+?\]/) {
			$note =~ s/\[([\dXVI]+?)\]/!$1!/g;
		}

		# temporary solution for merging note indicators. @TODO improve
 		$tmp1 =~ s/E,\sE/E/g;
		$tmp1 =~ s/E(,\s.{2,4})+,\sE/E$1/g;
		$tmp1 =~ s/E(,\s\/a\\textbackslash)+,\sE/E$1/g;
		$tmp1 =~ s/E(,\s\/c\\textbackslash)+,\sE/E$1/g;
  	
		$tmp1 =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[(.{7})\]Es war keinesweges/Es\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[$1\] war keinesweges/g;
 
		if($moveIntoNextMargindata =~ m/[\w]/) {
			# move pb from original \margindata[inouter] to the current one
			$tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{)/$1$moveIntoNextMargindata, /g;
			$tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{.*?\})/$1\\margindata\[inouter\]\{$moveIntoNextMargindata\], $note\}/g;
			$moveIntoNextMargindata = "";
		} 
		else {
			$tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{.*?\})/$1\\margindata\[inouter\]\{$note\}/g;
		}
		$tmp1 =~ s/([\w]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1}), ([\w]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1})/$1; $2/g;       

		# prepare analyzation of notelength
		$note =~ s/\\textbackslash/\\#/g;
		my @marginElements = split(', ', $note);

		my $noOfElements = @marginElements;
		my $marginSize = length($note);

		$note =~ s/([\w]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1}), ([\w]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1})/$1; $2/g;

		# look at all margin elements in $note
		for(my $j = 0; $j < @marginElements; $j++) {
			my $element = $marginElements[$j];

			# in the cases where there are several pagebreaks in one margin line, try to find out if markers in margin belong to the same
			# pagebreak or not. when several pagebreaks collide into one \vl, the hidden pagebreaks have an \hbox{} as 4th argument of \margin.
			# in these cases, the pagebreak markers in the margin should be seperated by a comma, otherwise by a semicolon.			
			if($element =~ m/[\w]{1}[!]{0,1}[0-9XVI]{1,7}[!]{0,1}/ 
			and $tmp1 =~ m/\\margin\{[\w]{8}\}\{pb\}\{\}\{\\hbox\{\}\}\{$element\}/) {
					my ($edition) = $element =~ /([\w])/;
					my ($page) = $element =~ /([!]{0,1}[0-9XVI]{1,7}[!]{0,1})/;
					# ":" is needed, otherwise "," will be substituted by ";" in for loop
					$tmp1 =~ s/[\,\;] $element/, $edition:$page/g;
					$note =~ s/[\,\;] $element/, $edition:$page/g;
			}

			#@TODO documentation! may also occur in margin notes, where last pb is the only one (isn't considered at the moment
			if($noOfElements > 1 and $noOfElements - 1 == $j
			# has to be adjusted: only 7 for large entries before. has to be larger for small entries.
			and $marginSize >= 17
			# assure that the following line has content in margin, too
			and $notes[$i+1] =~ m/[\w]/
			# experience shows that removal is only necessary when we have >= 2 pagebreaks
			and $note =~ m/[a-z][!]{0,1}[0-9XVI]{1,7}[!]{0,1}.*?[a-z]{1}[:]{0,1}[!]{0,1}[0-9XVI]{1,7}[!]{0,1}/) {
				$note =~ s/\\#/\\textbackslash/g;
				$note =~ s/://g;
				$element =~ s/\\#/\\textbackslash/g;
				$moveIntoNextMargindata = $element;
				print $file $note . "\n";
			}				
		}

		# undo changes for analyzation
		$note =~ s/\\#/\\textbackslash/g;
  }
}

close $file;

# remove marker
$tmp1 =~ s/, ([\w]):([!]{0,1}[0-9XVI]{1,4}[!]{0,1})/, $1$2/g;
# remove superfluous \margin
$tmp1 =~ s/\\margin\{[\w]{8}\}\{pb\}\{\}\{\\hbox\{\}\}\{.*?\}//g;

print $tmp1;

