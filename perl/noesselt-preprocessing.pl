#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/tmp-1.tex");


# specific processing for Noesselt
# wrong whitespaces
$tail =~ s/c\[II\], c\} /c\[II\], c\}/g;
$tail =~ s/\\sym\{\} \\p\{\}\{\\tfx\\high\{c\}\} \\\{\\persIndex\{Heynatz,/\\sym\{\}\\p\{\}\{\\tfx\\high\{c\}\} \\\{\\persIndex\{Heynatz,/g;
$tail =~ s/\\high\{\/ac\}\} \\marking\[oddHeader\]\{Vorreden\}/\\high\{\/ac\}\}\\marking\[oddHeader\]\{Vorreden\}/g;
$tail =~ s/\\high\{c\}\}\{c\} \\marking\[oddHeader\]\{Vorreden\}/\\high\{c\}\}\{c\}\\marking\[oddHeader\]\{Vorreden\}/g;
$tail =~ s/a\[I\]\} \\marking\[oddHeader\]\{Vorreden\}/a\[I\]\}\\marking\[oddHeader\]\{Vorreden\}/g;
$tail =~ s/ \\marking\[oddHeader\]\{Vorreden/\\marking\[oddHeader\]\{Vorreden/g;
$tail =~ s/\{b\[II\]\} \{\\tfx\\high\{ac\\textbackslash\}\}/\{b\[II\]\}\{\\tfx\\high\{ac\\textbackslash\}\}/g;

$tail =~ s/\\crlf 1818\.\\stopalignment\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[II\]\} \\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/\\crlf 1818\.\\stopalignment\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[II\]\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/g;

# wrong indentation
$tail =~ s/dazu eignete.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/dazu eignete.\\par /g;
$tail =~ s/zu lassen\?\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/zu lassen\?\\par /g;
$tail =~ s/schuldig.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/schuldig.\\par /g;
$tail =~ s/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\] Die kritischen/ Die kritischen/g;
$tail =~ s/Werth hat.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/Werth hat.\\par /g;
$tail =~ s/in Folgendem.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/in Folgendem.\\par /g;
$tail =~ s/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\] Die Schriften selbst/ Die Schriften selbst/g;
$tail =~ s/fortarbeiten.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/fortarbeiten.\\par /g;
$tail =~ s/Gelegenheit geben.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/Gelegenheit geben.\\par /g;
$tail =~ s/Einschaltungen erlaubt.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/Einschaltungen erlaubt.\\par /g;
$tail =~ s/Verfassers unterschieden.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/Verfassers unterschieden.\\par /g;
$tail =~ s/erschienen ist.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/erschienen ist.\\par /g;
$tail =~ s/a234\} \\margin/a234\}\\margin/g;

# wrong scribal abbreviations
$tail =~ s/\\margin\{kxXzHQaW\}\{omOpen\}\{d1e77096\}\{\\tfx\\high\{\/a\}\}\{\/a\}\\margindata\[inouter\]\{\/a\}\\writetolist\[section\]\{\}\{Vierter Abschnitt. \\italic\{Schöne Wissenschaften\}\}/\\writetolist\[section\]\{\}\{Vierter Abschnitt. \\italic\{Schöne Wissenschaften\}\}/g;
$tail =~ s/\\crlf Schöne Wissenschaften.\}\}\\margin\{aYNgpFkj\}\{omClose\}\{d1e77096\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\\margindata\[inouter\]\{a\\textbackslash\}/\\crlf Schöne Wissenschaften.\\margin\{aYNgpFkj\}\{omClose\}\{d1e77096\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\\margindata\[inouter\]\{a\\textbackslash\}\}\}/g;

$tail =~ s/\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\\stoprdg\}\} \\noindentation Grammatik der/\\stoprdg\}\} \\noindentation Grammatik der/g;
$tail =~ s/derselben\\margin\{.{8}\}\{omClose\}\{.{8}\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\} besonders studieren/derselben\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\} besonders studieren/g;

# wrong paragraph

#$tail =~ s/\\blank\[4pt\] \\noindentation \\stopnarrow\} \\blank\[4pt\] \\noindentation \\blank\[2pt\]/\\blank\[4pt\] \\noindentation \\stopnarrow\} \\noindentation /g;
#$tail =~ s/\\blank\[4pt\] \\noindentation \\blank\[4pt\] \\hspace\[big\] \\noindentation \\blank\[4pt\] /\\blank\[4pt\] \\noindentation \\blank\[4pt\] \\hspace\[big\] \\noindentation /g;
#$tail =~ s/\\stopnarrow\} \\blank\[4pt\] \\noindentation \\blank\[4pt\]/\\stopnarrow\} \\blank\[4pt\] \\noindentation /g;
#$tail =~ s/\\blank\[4pt\] \\noindentation \\stopnarrow\} \\blank\[2pt\] \\noindentation \\blank\[2pt\]/\\noindentation \\stopnarrow\} \\noindentation \\blank\[2pt\]/g;
#$tail =~ s/\\blank\[2pt\] \\noindentation \\blank\[2pt\] \\hspace\[big\] \\noindentation \\blank\[2pt\] /\\blank\[2pt\] \\noindentation \\hspace\[big\] \\noindentation /g;
#$tail =~ s/\\blank\[2pt\] \\hspace\[big\] \\noindentation \\blank\[2pt\] \\switchtobodyfont\[8\.5pt\]\\noindentation \\page\[yes,left,empty\]/\\hspace\[big\] \\noindentation\\switchtobodyfont\[8\.5pt\]\\noindentation \\page\[yes,left,empty\]/g;
#$tail =~ s/\\stopitemize \\stopitemize \\stopitemize \\stopitemize \\blank\[2pt\] \\switchtobodyfont\[8\.5pt\]\\noindentation/\\stopitemize \\stopitemize \\stopitemize \\stopitemize \\switchtobodyfont\[8\.5pt\]\\noindentation/g;
#$tail =~ s/\\blank\[2pt\] \\noindentation \\stopnarrow\} \\blank\[2pt\] \\noindentation \\blank\[2pt\] /\\blank\[2pt\] \\noindentation \\stopnarrow\} \\noindentation /g;
#$tail =~ s/\\blank\[2pt\] \\noindentation \\stopnarrow\} \\blank\[2pt\] \\noindentation \\blank\[2pt\]\\subject\[ 4.\]/\\noindentation \\stopnarrow\} \\noindentation \\subject\[ 4.\]/g;
#$tail =~ s/\\stopnarrow\} \\noindentation \\blank\[2pt\]\\subject/\\stopnarrow\} \\noindentation \\subject/g;

#$tail =~ s/\\subject\[8\.\]/\\blank\[overlay\]\\subject\[8\.\]/g;
#$tail =~ s/\\blank\[2pt\] \\noindentation \\blank\[2pt\]\\subject/\\blank\[2pt\] \\noindentation \\subject/g;
#$tail =~ s/\\stopnarrow\} \\blank\[2pt\] \\noindentation \\subject/\\stopnarrow\} \\blank\[overlay\] \\noindentation \\subject/g;
#$tail =~ s/missgönnt worden ist\.\\par/missgönnt worden ist\./g;
#$tail =~ s/\\par \\blank\[2pt\] \\noindentation \\stopnarrow \\blank\[2pt\] \\hspace\[big\] \\noindentation \\blank\[2pt\]/\\par \\noindentation \\stopnarrow \\hspace\[big\] \\noindentation \\blank\[2pt\]/g;

#$tail =~ s/\\par \\blank\[2pt\] \\noindentation \\stoprdg\} \\blank\[2pt\] \\hspace\[big\] \\noindentation \\blank\[2pt\]/\\par\\noindentation \\stoprdg\} \\hspace\[big\] \\noindentation/g;
#$tail =~ s/\\stoprdg\} \\blank\[2pt\] \\hspace\[big\] \\noindentation \\blank\[2pt\] \\start/\\stoprdg\} \\hspace\[big\] \\noindentation \\start/g;
#$tail =~ s/\\stoprdg\} \\blank\[2pt\] \\noindentation \\par \\blank\[2pt\]/\\stoprdg\} \\noindentation /g;
#$tail =~ s/\\stoprdg\} \\blank\[2pt\] \\noindentation \\stopnarrow\}/\\stoprdg\} \\noindentation \\stopnarrow\}/g;
#$tail =~ s/\\blank\[2pt\] \\noindentation \\par/\\noindentation /g;
#$tail =~ s/!\\par \\blank\[2pt\]/!\\par \\blank\[6pt\]/g;
#$tail =~ s/\\stopitemize \\stopnarrow\} \\noindentation \\blank\[2pt\]/\\stopitemize \\stopnarrow\} \\noindentation /g;
#$tail =~ s/\\blank\[2pt\] \\noindentation \\stopitemize \\stopnarrow/\\noindentation \\stopitemize \\stopnarrow/g;
#$tail =~ s/zu haben\}\?\\par \\blank\[2pt\]/zu haben\}\?\\par \\blank\[big\]/g;
#$tail =~ s/\\blank\[2pt\] \\noindentation \\subject\[41\./\\noindentation \\subject\[41\./g;
#$tail =~ s/\\blank\[2pt\]\\subject\[ 42/\\blank\[6pt\]\\subject\[ 42/g; 
#$tail =~ s/\\noindentation Doch sollen/\\noindentation \\blank\[2pt\] Doch sollen/g;
#$tail =~ s/\\stoprdg\} \\hspace\[big\] \\noindentation \\start/\\stoprdg\} \\start/g;
#$tail =~ s/\\blank\[2pt\] \\hspace\[big\] \\noindentation \\blank\[2pt\] \\switchtobodyfont\[8\.5pt\]\{\\startrdg\\noindentation \\page\[yes,left,empty\]\\noheaderandfooterlines\\marking\[oddHeader\]\{I\. Vorrede des Herausgebers/\\noindentation \\switchtobodyfont\[8\.5pt\]\{\\startrdg\\noindentation \\page\[yes,left,empty\]\\noheaderandfooterlines\\marking\[oddHeader\]\{I\. Vorrede des Herausgebers/g;
#$tail =~ s/\\noheaderandfooterlines\\marking\[evHeader\]\{\{\\tfx\\it Nösselt\, Anweisung zur Bildung angehender Theologen \\high\{\{\\tx 1\}\}1786\/89\–\\high\{\{\\tx 3\}\}1818\/19\}\} \\startbodymatter/\\startbodymatter \\noheaderandfooterlines\\marking\[evHeader\]\{\{\\tfx\\it Nösselt\, Anweisung zur Bildung angehender Theologen \\high\{\{\\tx 1\}\}1786\/89\–\\high\{\{\\tx 3\}\}1818\/19\}\}/g;


#$tail =~ s/\\marking\[oddHeader\]\{I\. Innhalt des ganzen Buchs\}\}\}\\sym\{\} \\setupindenting\[yes,medium\] \\setupitemgroup\[itemize\]\[indenting=\{40pt,next\}\]\[leftmargin=-5em\]/\\marking\[oddHeader\]\{I\. Innhalt des ganzen Buchs\}\}\}\\sym\{\} \\setupindenting\[yes,medium\] \\setupitemgroup\[itemize\]/g;


#$tail =~ s/\\stopnarrow\} \\blank\[2pt\] \\noindentation \\blank\[2pt\]\\page\[right,empty\]/\\stopnarrow\} \\page\[right,empty\]/g;

#$tail =~ s/\\blank\[2pt\] \\noindentation \\subject/\\subject/g;
#$tail =~ s/ \\startalignment\[center\]/\\startalignment\[center\]/g;

#$tail =~ s/\\noindentation \\crlf \\switchtobodyfont\[8\.5pt\]\{\\startrdg\\noindentation \\page\[yes,left,empty\]/\\page\[yes,left,empty\] \\switchtobodyfont\[8\.5pt\]\{\\startrdg/g;
#$tail =~ s/\\noindentation \\crlf //g;
#$tail =~ s/\\page\[yes,left,empty\] \\switchtobodyfont\[8\.5pt\]\{\\startrdg\\noheaderandfooterlines/\\noheaderandfooterlines \\page\[yes,left,empty\] \\switchtobodyfont\[8\.5pt\]\{\\startrdg/g; 
#$tail =~ s/\\startrdg\\noindentation \\page\[yes,left,empty\]/\\startrdg\\page\[yes,left,empty\]/g;


# paragraphs

#$tail =~ s/literarische Kenntnisse geben. \\crlf/literarische Kenntnisse geben. /g;
#$tail =~ s/waren\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stoprdg\}\} \\noindentation/waren\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stoprdg\}\} \\blank\[2pt\]/g;
#$tail =~ s/\\par \\crlf \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\] \\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{a\[XIV\]\} Den zweyten Theil/\\par \\blank\[medium\] \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg \\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{a\[XIV\]\} Den zweyten Theil/g;
#$tail =~ s/zu liefern\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stoprdg\}\}Noch/zu liefern\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stoprdg\}\}\\blank\[4pt\]Noch/g;
$tail =~ s/im Jahr 1791\.\\par/im Jahr 1791\./g;
#$tail =~ s/\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\stoprdg\}\} \\noindentation \\margin\{\}\{omOpen/\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\stoprdg\}\} \\blank\[2pt\] \\noindentation \\margin\{\}\{omOpen/g;
#$tail =~ s/\\startnarrow\\noindentation\\margin/\\startnarrow\\noindentation\\margin/g;
#$tail =~ s/\\startnarrow\\noindentation \\margin/\\startnarrow\\noindentation \\margin/g;
#$tail =~ s/\\stopnarrow\} \\noindentation /\\stopnarrow\} /g;
#$tail =~ s/\\startnarrow \\noindentation ([A-Z\{\\]{1})/\\startnarrow \\noindentation $1/g;
#$tail =~ s/\\rightaligned\{Der Herausgeber\.\}\\par \\stoprdg\}\}/\\rightaligned\{Der Herausgeber\.\}\\stoprdg\}\}/g;
#$tail =~ s/\\crlf \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg\\noindentation\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{a\}\}\{a\}Sollte man/\\blank\[medium\]\{\\switchtobodyfont\[8\.5pt\]\{\\startrdg\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{a\}\}\{a\}Sollte man/g;
#$tail =~ s/\\par \\crlf \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/\{\\switchtobodyfont\[8\.5pt\]\{\\startrdg \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/g;
$tail =~ s/\\par \\stoprdg\}\} \\noindentation \\resetnumber/\\stoprdg\}\} \\resetnumber/g;
$tail =~ s/\\setuppagenumber\[number=1\]\\setuppagenumber\[number=25\]/\\setuppagenumber\[number=25\]/g;
$tail =~ s/1818\/19\}\} \\crlf \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg\\noindentation/1818\/19\}\} \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg/g;
$tail =~ s/\\noindentation \\par \\blank\[2pt\]//g;
#$tail =~ s/\\noindentation \\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/a\}\}\{\/a}S\. mein /\\blank\[medium\] \\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/a\}\}\{\/a}S\. mein /g;
#$tail =~ s/jener in diese\.\\par \\blank\[2pt\] /jener in diese\.\\par /g;
#$tail =~ s/die nie gewesen sind\.\\par \\crlf/die nie gewesen sind\.\\par \\blank[2pt]/g;
#$tail =~ s/philologischen\} Kritik\. \\stopnarrow\} \{\\switchtobodyfont\[8\.5pt\] \\startnarrow \\noindentation/philologischen\} Kritik\. \\stopnarrow\} \{\\switchtobodyfont\[8\.5pt\] \\startnarrow \\blank\[2pt\]/g;
#$tail =~ s/\\noindentation Anm\.\\cNote\{\\italic\{Anmerk\.\}\} 3\. Manche nennen/\\blank\[2pt\] Anm\.\\cNote\{\\italic\{Anmerk\.\}\} 3\. Manche nennen/g;


# errors dealing with the commentary + margins

$tail =~ s/\\par \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[([\w\d]{7})\]Es war/\\par Es \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[$1\]war/g;
$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e8440\]//g;
$tail =~ s/\{\\tfx\\high\{\/c\}\}\\sachIndex\{Wissen\}Wissen/\{\\tfx\\high\{\/c\}\}\\sachIndex\{Wissen\}Wissen\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e8440\]/g;



# errors dealing with the commentary + scribal abbreviations
$tail =~ s/1818\. \\crlf \\crlf \\rightaligned\{Der Herausgeber\.\}\\par \\stoprdg\}\}/1818\. \\crlf \\crlf \\rightaligned\{Der Herausgeber\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\stoprdg\}\}/g;
$tail =~ s/285\.\\stopitemize \\stopitemize \\stoprdg\}\}/285\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\stopitemize \\stopitemize \\stoprdg\}\}/g;
$tail =~ s/statt Theil\.\\stopitemize \\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\}\{\\tfx\\high\{a\\textbackslash\}\}/statt Theil\.\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\}\{\\tfx\\high\{a\\textbackslash\}\}\\stopitemize /g;
$tail =~ s/\\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/\\rightaligned\{A\. d\. H\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;


# general font problems

$tail =~ s/Vorrede des Herausgebers \(c\)\]\{\{\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/Vorrede des Herausgebers \(c\)\]\{\{\\margin\{\}\{plOpen\}\{\}\{\\tfxx\\high\{c\}\}\{c\}\}/g;

#$tail =~ s/\\switchtobodyfont\[10\.5pt\]\\margin\{\}\{pb\}\{\}\{\\vl\}\{a\[III\]\}/\\margin\{\}\{pb\}\{\}\{\\vl\}\{a\[III\]\}/g;
#$tail =~ s/zweyten Ausgabe\]\{\{\\switchtobodyfont\[9\.5pt\]/zweyten Ausgabe\]\{\{/g;
#$tail =~ s/\\switchtobodyfont\[10\.5pt\]([\w\.]+)\}\}\\blank\[2pt\]\\sym\{\}/\\switchtobodyfont\[10\.5pt\]$1\}\}\\blank\[2pt\]\\sym\{\}/g;
#$tail =~ s/ersten Ausgabe\]\{\{\\switchtobodyfont\[10\.5pt\]/ersten Ausgabe\]\{\{\\switchtobodyfont\[9\.5pt\]/g;
#$tail =~ s/\{\{\\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/a\}\}\{\/a\}\}\{\\switchtobodyfont\[10\.5pt\]/\{\\switchtobodyfont\[10\.5pt\]\{\{\\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/a\}\}\{\/a\}\}/g;
#$tail =~ s/\{\\switchtobodyfont\[10\.5pt\]Erster Theil\.\}\}\\tablesubhead/\{Erster Theil\.\}\}\\tablesubhead/g;

# hyphenation
#$tail =~ s/\{\\tfx\\high\{\/c\}\}\{\\tfx\\high\{\/a\}\}suchen;\{\\tfx\\high\{a\\textbackslash\}\}/\{\\tfx\\high\{\/c\}\}\{\\tfx\\high\{\/a\}\}su\\crlfchen;\{\\tfx\\high\{a\\textbackslash\}\}/g;

#orphan and widow lines

$tail =~ s/\\sym\{\}\\italic\{Zweyter Abschnitt: Philosophie/\\sym\{\}\\crlf\\italic\{Zweyter Abschnitt: Philosophie/g;
$tail =~ s/\\blank\[12pt\]\\tablemainhead\[ Dritter Theil,\]\{\{\\switchtobodyfont\[10\.5pt\]\\margin\{\}\{pb\}\{\}\{\\vl\}\{b\[XXVI\]\}/\\page\\tablemainhead\[ Dritter Theil,\]\{\{\\switchtobodyfont\[10\.5pt\]\\margin\{\}\{pb\}\{\}\{\\vl\}\{b\[XXVI\]\}/g;


$head = $head . $tail;
print $head;