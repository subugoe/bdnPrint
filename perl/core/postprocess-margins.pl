#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $tmp1 = read_file("tmp/" . $ARGV[0] . "_tmp-1.tex");

### Editorial comments

open(FILE, "<tmp/comments.txt") or die "$!\n";
my @commentsFile = <FILE>;
close(FILE);

# iterate lines in document
for (my $i = 0; $i < @commentsFile; $i++) {
	my $comments = $commentsFile[$i];
	
	if($comments and $comments =~ m/\s/) {
		# iterate single comments
		# apart from the first comment every margin entry of an editorial comment is deleted in $tmp1,
		# hence we start at $j = 1 instead of $j = 0 
		my @commentElements = split(' ', $comments);
		for (my $j = 1; $j < @commentElements; $j++) {
			my $comment = $commentElements[$j];

			$tmp1 =~ s/\\margin\{$comment\}\{e\}\{\}\{\\hbox\{\}\}\{E\}//g;
		}
	}
}


### Pagebreaks and general margin data

open(FILE, "<tmp/id-file.txt") or die "$!\n";
my @idFile = <FILE>;
close(FILE);

open(FILE, "<tmp/notes.txt") or die "$!\n";
my @notes = <FILE>;
close(FILE);

my $file_location = "tmp/moved_elements.txt";
open(my $file, ">", $file_location) or die $!;

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

	# merging note indicators
	$tmp1 =~ s/E, E/E/g;
	$tmp1 =~ s/E, ([\w\\\d\s,]+) E/E, $1/g;

 
		if($moveIntoNextMargindata =~ m/[\w]/) {
			# move pb from original \margindata[inouter] to the current one
			$tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{)/$1$moveIntoNextMargindata, /g;
			$tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{.*?\})/$1\\margindata\[inouter\]\{$moveIntoNextMargindata\], $note\}/g;
			$moveIntoNextMargindata = "";
		} 
		else {
			$tmp1 =~ s/(\\margin\{$id\}\{.*?\}\{.*?\}\{.*?\}\{.*?\})/$1\\margindata\[inouter\]\{$note\}/g;
		}
		$tmp1 =~ s/(\\margindata\[inouter\]\{[[\/]{0,1}[\w]{0,5}[\\textbackslash]{0,1}[,]{0,1}]*?)([\w]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1}), ([\w]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1})/$1$2; $3/g;       

		# prepare analyzation of notelength
		$note =~ s/\\textbackslash/\\@/g;
		#$tmp1 =~ s/\\textbackslash/\\@/g;
		my @marginElements = split(', ', $note);

		my $noOfElements = @marginElements;
		my $marginSize = length($note);

		# undo changes for analyzation
		$note =~ s/\\@/\\textbackslash/g;

		# Luc. 16; 23–25.
		$note =~ s/([a-z]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1}), ([a-z]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1})/$1; $2/g;
		$tmp1 =~ s/([a-z]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1}), ([a-z]{1}[!]{0,1}[0-9IVX]{1,7}[!]{0,1})/$1; $2/g;

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


			# case 1: a few small elements. doesn't result in a linebreak, no code needed.
			# case 2: a lot of small or a few large elements while the next margin line is empty. then we
			# only have to append \].
			if($notes[$i+1] !~ m/[\w]/ and $noOfElements - 1 == $j
			# estimation: either a lot of small elements ...
			and (($marginSize >= 20 and $noOfElements >= 3) 
				# ... or a few large elements. 16 is gained from experience, 22 is the
				# maximum size a combination of two elements can have (e.g. c[XXXVIII], d[XXXVIII])
				or ($marginSize >= 16 and $marginSize <= 22 and $noOfElements < 3))) {
					# workaround: if the pb doesn't have an hbox, the semicolon would otherwise be set in the next
					# loop iteration -- which would prevent \] from being appended
					if($element =~ m/[\w]{1}[!]{0,1}[0-9XVI]{1,7}[!]{0,1}/ and
					$tmp1 !~ m/\\margin\{[\w]{8}\}\{pb\}\{\}\{\\hbox\{\}\}\{$element\}/) {
						$tmp1 =~ s/, $element/; $element/g;
						$note =~ s/, $element/; $element/g;
					} 
					my $pattern = $note;
					$pattern =~ s/([\/\\;])/\\$1/g;
					$tmp1 =~ s/$pattern/$note\]/g;
				
			}

			# case 3: a lot of small or a few large elements while the next margin line is NOT empty. then the last element
			# has to be copied into the next \\margindata[inouter] at the beginning of the next loop iteration.
			#@TODO documentation! may also occur in margin notes, where last pb is the only one (isn't considered at the moment
			if($noOfElements > 1 and $noOfElements - 1 == $j
			and $marginSize >= 17 and $noOfElements < 3
			# assure that the following line has content in margin, too
			and $notes[$i+1] =~ m/[\w]/
			# experience shows that removal is only necessary when we have >= 2 pagebreaks
			and $note =~ m/[a-z][!]{0,1}[0-9XVI]{1,7}[!]{0,1}.*?[a-z]{1}[:]{0,1}[!]{0,1}[0-9XVI]{1,7}[!]{0,1}/) {
				$note =~ s/://g;
				$element =~ s/\\@/\\textbackslash/g;
				$moveIntoNextMargindata = $element;
				print $file $note . "\n";
			}	else {
				$moveIntoNextMargindata = "";
			}	
		}
  }
}

close $file;

# remove marker
$tmp1 =~ s/, ([\w]):([!]{0,1}[0-9XVI]{1,4}[!]{0,1})/, $1$2/g;
# remove superfluous \margin
$tmp1 =~ s/ \\margin\{[\w]{8}\}\{pb\}\{\}\{\\hbox\{\}\}\{.*?\}//g;

print $tmp1;

