#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/griesbach_tmp-1.tex");

$tail =~ s/\\startrdg \\newOddPage\\noindentation/\\page\\noheaderandfooterlines\\startrdg/g;
$tail =~ s/(\\startrdg )(\\newOddPage)/$2$1/g;

#$tail =~ s/(\\authorbottomnote\{\\startbottommargin \\startbottommargin \\margin\{\}\{omOpen\}\{N1\.4\.4\.2\.4\.4\.10\.38\.5\.24\.2\.6\.4.*?hiebei\}) (auch \{\\tfx\\high\{\/b\}\}izt noch .*?lehrreich \{\\tfx\\high\{\/d\}\}seyn\{\\tfx\\high\{d\\textbackslash\}\\stopbottommargin\} \{\\dvl\}\\dNote\{gemacht werden\})/$2$1/g;
#$tail =~ s/(\\authorbottomnote\{\\startbottommargin \\margin\{\}\{omOpen\}\{N1\.4\.4\.2\.4\.4\.6\.4\.4\.*?N1\.4\.4\.2\.4\.4\.6\.4\.2\.1\.51\.2\.3\.2\.4\]\{12\.\}) (\\startdivsection \\noindentation 1\. Die Vernunft sagt.*?tigste, weiseste,)/$2$1/g;

#$tail =~ s/(praktische Anwendung der .*? behandelten Dogmen gezeigt wird\.\{\\tfx\\high\{a\\textbackslash\}\}\\hspace\[insert\]\{\\dvl\}\\aNote\{\*\)\}) \\authorbottomnote\{\\startbottommargin (.*?)\\stopbottommargin\}/$1\\footnote\{\\starteffect\[hidden\]\.\\stopeffect\\hspace\[p2\]$2\}/g;


# display at least two lines of text after heading
# I. Religion, Offenbarung und Bibel
# 1. split note in two
$tail =~ s/(sie hierdurch zur wil)/$1-\\stopbottommargin\}\\authorbottomnote\{\\startbottommargin /g;
# 2. move second note
$tail =~ s/(sie hierdurch zur wil-\\stopbottommargin\})(\\authorbottomnote\{\\startbottommargin .*?\{12\.\})(\\startdivsection .*?Vollkommenheit und wahren)/$1$3$2/g;

# II. Gott
$tail =~ s/(sollte man nichts in den gemei)/$1-\\stopbottommargin\}\\authorbottomnote\{\\startbottommargin /g;
$tail =~ s/(\\authorbottomnote\{\\startbottommargin nen \\subjectsIndex\{Religionsunterricht.*?higeren\})(\\startdivsection .*?lehrt eben sowohl die Natur)/$2$1/g;

# Zustand des Menschen
#$tail =~ s/(kommen jemals )/-\\page $1/g;
#$tail =~ s/(bey keinem einzigen ihrer.*?)(\\authorbottomnote\{.*?\\stopbottommargin\}//g;
$tail =~ s/(er nicht tiefere Wurzel schlage und) /$1\\stopbottommargin\}\\authorbottomnote\{\\startbottommargin /g;
$tail =~ s/(\\authorbottomnote\{\\startbottommargin weiter um.*?)(\\startdivsection.*?Gebrauche aller ihrer)/$2$1/g;
$tail =~ s/(\\startdivsection \\noindentation 112)/\\blank\[-4mm\]$1/g;


# Christus, der Wiederhersteller
$tail =~ s/(Menschen Geschlechts\}\.\})(\\authorbottomnote\{\\startbottommargin .*?)(\\startdivsection \\noindentation 132\. .*?Leiden und selbst den)/$1$3$2/g;
# switch notes
$tail =~ s/(Leiden und selbst den\\authorbottomnote\{.*?nicht weniger Antriebe) /$1\\stopbottommargin\}\\authorbottomnote\{\\startbottommargin /g;
$tail =~ s/(\\authorbottomnote\{\\startbottommargin zur christlichen.*?erleichtert\})( Tod erdulden.*?Familie Davids)/$2$1/g;
#$tail =~ s/(\\startdivsection \\noindentation 132\. \\hspace\[insert\]\{\\dvl\}\\dNote\{\*\)\} )(\\authorbottomnote\{\\startbottommargin .*?)(\\noindentation Die Israelitischen.*?)(\\authorbottomnote\{\\startbottommargin .*?)(\\setnotetext\[bNote\]\[N1\.4\.4\.2\.4\.14\.6\.4\.2\.1\.17\.4\]\{Messias\})/$1$4$3$2$5/g;


# Wie wird der Christ
$tail =~ s/(\*\)\?\}\}\\authorbottomnote\{.*?nde, unter welchen) /$1\\stopbottommargin\}\\authorbottomnote\{\\startbottommargin /g;
$tail =~ s/(\\authorbottomnote\{\\startbottommargin ihre Besserung.*?)(\\startdivsection \\noindentation 152\. .*?Gesetze und zu)/$2$1/g;
#$tail =~ s/(hrt \*\)\?\}\})(\\authorbottomnote\{\\startbottommargin .*?Theile genau zu binden, wo)/$1$2-\}\\authorbottomnote\{\\startbottommargin /g;
#$tail =~ s/(Theile genau zu binden, wo-\})(\\authorbottomnote\{\\startbottommargin .*?)(\\startdivsection \\noindentation 152\. .*?\\italic\{Einige\} leben)/$1$3$2/g;


# § 95.
#$tail =~ s/(Belehrungen a\).*?Vermuthungen)/$1\\stoprdg\}\\authorbottomnote\{\\startbottommargin \\startrdg /g;
#$tail =~ s/(\\authorbottomnote\{\\startbottommargin \\startrdg .*?Artikel\})( Gott hat den Menschen mit den.*?Menschen noch keinen)/$2$1/g;
#$tail =~ s/(\\authorbottomnote\{\\startbottommargin \\startrdg .*?Folgen\})/$1\}\\authorbottomnote\{\\startbottommargin /g;
#$tail =~ s/(\\authorbottomnote\{\\startbottommargin  der.*?Artikel\})( \\subjectsIndex\{moralisch\}moralischen.*?Erweiterung)/$2$1/g;

# § 154.
#$tail =~ s/(d\*223\{\\vl\}nungen.*?und hingegen in die)/$1\}\\authorbottomnote\{\\startbottommargin /g;
#$tail =~ s/(und hingegen in die\})(\\authorbottomnote\{\\startbottommargin .*?\})(\\noindentation erkennet man leicht, .*?gebesserter Christ beschaffen seyn)/$1$3$2/g;


# § 45.
$tail =~ s/(\\authorbottomnote\{\\startbottommargin \\margin\{.{0,8}\}\{plOpen\}\{N1\.4\.4\.2\.4\.6\.6\.38\.5\.4\.4\}.*?\\stopbottommargin\})(.*?oder das minder)/$2$1/g;

# necessary to get right structure in TOC
$tail =~ s/\\writetolist\[section/\\writetolist\[part/g;
$tail =~ s/\\writetolist\[chapter\]\{\}\{Vorreden/\\writetolist\[part\]\{\}\{Vorreden/g;
#$tail =~ s/(\\placesubjectsIndex)/\\writetolist\[part\]\{\}\{Sachen\}$1/g;


# no orphan/widow lines
#$tail =~ s/ber\. 64\.\\stopitemize \\sym\{\}III/ber\. 64\.\\stopitemize\\page\\sym\{\}III/g;
#$tail =~ s/\\crlf \\starteffect\[hidden\]\. \\stopeffect\\hspace\[p\](Ich gebe gern zu)/\\page $1/g;


# first two prefaces on one page plus right margin between two prefaces
$tail =~ s/\\page(\\marking\[oddHeader\]\{Vorrede zur dritten Ausgabe)/\\blank\[24pt\]$1/g;


# two title pages on a page, bigger space between title pages
$tail =~ s/(Hellers Schriften\\crlf 1779\..*?\\stoprdg)/$1 \\page/g;
$tail =~ s/(\\stopalignment\})(\\startrdg\{\\startalignment\[center\])/$1 \\blank\[36pt\]$2/g;
$tail =~ s/(\\stopalignment\}\\stoprdg) \\noindentation (\\startrdg\{\\startalignment\[center\])/$1 \\blank\[36pt\]$2/g;


# no \\noindentation between end of a rdg and authorbottomnote
$tail =~ s/(\\margindata\[inouter\]\{a\}\\stoprdg) \\noindentation (\\authorbottomnote)/$1$2/g;


# always begin on right-hand side
$tail =~ s/\\newOddPage(\\writetolist\[part\]\{\}\{V\. Zustand)/\\newPage$1/g;
#$tail =~ s/\\newOddPage(\\writetolist\[part\]\{\}\{VII\.)/\\newPage$1/g;


# paragraphs
$tail =~ s/\\par (Anhand der vorliegenden)/\\crlf \\starteffect\[hidden\].\\stopeffect\\hspace\[p\]$1/g;


# special hyphenation cases
# anfäng-|lich
$tail =~ s/(ng)(\}\\margin)/$1-$2/g;
$tail =~ s/ (\\italic\{lich in)/$1/g;
# c.f. https://tex.stackexchange.com/questions/35370/allowing-breaks-at-a-location-with-no-spaces-or-hyphens?rq=1
$tail =~ s/(\{\/a\}Betrach)(tungen)/$1-\\hskip0pt $2/g;
$tail =~ s/(vorzunehm)(en\{\\tfx)/$1-\\crlf $2/g;


# editorial corrigenda

$tail =~ s/(23\.\\NC \\NR \\NC)/$1\\stoptabulate \\blank\[-24pt\]\\starttabulatehead\\FL \\NC Seite \\NC fehlerhaftes Original \\NC stillschweigende Korrektur \\NC \\AR \\LL \\stoptabulatehead\\starttabulate\[|p\(1cm\)|p|p|\]\\NC/g;

# special cases of pagebreaks
$tail =~ s/(\\startdivsection \\noindentation 162\. Nach der)/\\page $1/g;
$tail =~ s/(1 Cor\.) (10, 15. \\bibelIndex)/$1\\page\\noindentation $2/g;
$tail =~ s/(dagogischen Vor)/$1-\\page\\noindentation /g;
$tail =~ s/(wird erst im Zuge)/$1\\page\\noindentation /g;



$head = $head . $tail;
print $head;