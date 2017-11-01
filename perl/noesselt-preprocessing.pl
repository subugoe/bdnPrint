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
$tail =~ s/Werke, \\margin\{\}\{plClose\}/Werke,\\margin\{\}\{plClose\}/g;
$tail =~ s/\\crlf 1818\.\\stopalignment\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[II\]\} \\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/\\crlf 1818\.\\stopalignment\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[II\]\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/g;
$tail =~ s/257\\aNote\{259\}\~\.\}/257\\aNote\{259\}\.\}/g;
$tail =~ s/258\\aNote\{260\}\~\./258\\aNote\{260\}\./g;
$tail =~ s/259\\aNote\{261\}\~\./259\\aNote\{261\}\./g;
$tail =~ s/geliefert hat\}\~\.\\par \\blank\[2pt\] /geliefert hat\}\../g;
$tail =~ s/1735\.\\aNote\{1735\}\~\\margin\{\}/1735\.\\aNote\{1735\} \\margin\{\}/g;
$tail =~ s/S\. 166 fgg\. \\sym\{\}\\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/a\}\}\{\/a\} /S\. 166 fgg\. \\sym\{\}\\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/a\}\}\{\/a\}/g;
$tail =~ s/30\.\\cNote\{30\} f\./30\.\\cNote\{30\}f\./g;
$tail =~ s/S\. 3 f\.\) Auch in/S\. 3f\.\) Auch in/g;
$tail =~ s/,\}\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}/,\} \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}/g;
$tail =~ s/\}\~\./\}\./g;
$tail =~ s/higkeiten\}\}\~und/higkeiten\}\} und/g;
$tail =~ s/Frankfurt\}\~und /Frankfurt\} und /g;
$tail =~ s/5\.\}\~Halae/5\.\} Halae/g;
$tail =~ s/kann\}\~man/kann\} man/g;


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
$tail =~ s/zum Grunde liegen\. \\stopnarrow\} \\blank\[2pt\] \\blank\[2pt\]\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}/zum Grunde liegen\.\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\} \\stopnarrow\} \\blank\[2pt\] \\blank\[2pt\]/g;

$tail =~ s/\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\\stoprdg\}\} \\noindentation Grammatik der/\\stoprdg\}\} \\noindentation Grammatik der/g;
$tail =~ s/derselben\\margin\{.{8}\}\{omClose\}\{.{8}\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\} besonders studieren/derselben\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\} besonders studieren/g;
$tail =~ s/Halle 1804\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\{\\tfx\\high\{a\\textbackslash\}\}\\stopitemize \\stoprdg\}\} \\stopnarrow\} \\blank\[2pt\] \\blank\[2pt\]\{\\tfx\\high\{a\\textbackslash\}\}/Halle 1804\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\{\\tfx\\high\{a\\textbackslash\}\}\\stopitemize \\stoprdg\}\} \\stopnarrow\} \\blank\[2pt\] \\blank\[2pt\]/g;
$tail =~ s/ndern\. \\crlf \\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\]\{\\tfx\\high\{a\\textbackslash\}\} /ndern\. \\crlf \\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\] /g;
$tail =~ s/sicht nehmen\. \\crlf \\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\]\{\\tfx\\high\{a\\textbackslash\}\}/sicht nehmen\. \\crlf \\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\]/g;
$tail =~ s/\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\\subject\[241243\.\]/\\subject\[241243\.\]/g;
$tail =~ s/\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\}\\subject\[ 261263260/\\subject\[ 261263260/g;
$tail =~ s/\\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/a\}\}\{\/a}\\writetolist\[section\]\{\}\{Vierter /\\writetolist\[section\]\{\}\{Vierter /g;
$tail =~ s/ne Wissenschaften\.\}\}\\blank\[2pt\]\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}/ne Wissenschaften\.\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\}\}\\blank\[2pt\]/g;
$tail =~ s/D\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/D\. H\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;
$tail =~ s/\{\[\\\}\]\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}\\par /\{\[\\\}\]\}\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;
$tail =~ s/\\rightaligned\{A\. d\. H\.\\\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/\\rightaligned\{A\. d\. H\.\\\}\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;
$tail =~ s/\\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\}\\par/\\rightaligned\{A\. d\. H\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}/g;
$tail =~ s/\\rightaligned\{A\. d\. H\.\\\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\}/\\rightaligned\{A\. d\. H\.\\\}\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}/g;
$tail =~ s/A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}/A\. d\. H\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\{\\tfx\\high\{a\\textbackslash\}\}/g;
$tail =~ s/A\. d\. H\.\{\[\\\}\]\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/A\. d\. H\.\{\[\\\}\]\}\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;
$tail =~ s/nne\.\\blank\[2pt\]\\stoprdg\}\}\\subject\[§\. 211214\.\]/nne\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stoprdg\}\}\\subject\[§\. 211214\.\]/g;
#$tail =~ s/Halle 1781\. 8\.\\stopitemize/Halle 1781\. 8\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopitemize/g;
$tail =~ s/an die Hand geben\.\\par \\blank\[2pt\]\\stoprdg\}/an die Hand geben\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\stoprdg\}/g;


# paragraphs

$tail =~ s/im Jahr 1791\.\\par/im Jahr 1791\./g;
$tail =~ s/\\par \\stoprdg\}\} \\noindentation \\resetnumber/\\stoprdg\}\} \\resetnumber/g;
$tail =~ s/\\setuppagenumber\[number=1\]\\setuppagenumber\[number=25\]/\\setuppagenumber\[number=25\]/g;
$tail =~ s/1818\/19\}\} \\crlf \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg\\noindentation/1818\/19\}\} \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg/g;
$tail =~ s/\\noindentation \\par \\blank\[2pt\]//g;
$tail =~ s/diese\.\\par \\blank\[2pt\] \{\\switchtobodyfont\[8\.5pt\] \\startnarrow/diese\.\{\\switchtobodyfont\[8\.5pt\] \\startnarrow/g;
$tail =~ s/literarische Kenntnisse geben\. \\crlf/literarische Kenntnisse geben\./g;
$tail =~ s/Die neueste Zeit ist/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Die neueste Zeit ist/g;
$tail =~ s/In den Schriften,/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]In den Schriften,/g;
$tail =~ s/Man sollte daher auf/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Man sollte daher auf/g;
$tail =~ s/geworden ist\.\\par Inde/geworden ist\.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\] Inde/g;
$tail =~ s/Vielleicht kommt/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Vielleicht kommt/g;
$tail =~ s/des Verfassers unterschieden worden\.\\par/des Verfassers unterschieden worden\.\\par\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/g;
$tail =~ s/Oft habe ich bei der/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Oft habe ich bei der/g;
$tail =~ s/Halle, den 25\. April/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Halle, den 25\. April/g;
$tail =~ s/Literatur\.\\par Fast/Literatur\.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Fast/g;
$tail =~ s/zum Grunde gelegt habe\.\\par/zum Grunde gelegt habe\.\\par\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/g;
$tail =~ s/Die Erscheinung der/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Die Erscheinung der/g;
$tail =~ s/Gleichwohl hat man/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Gleichwohl hat man/g;
$tail =~ s/Man that/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Man that/g;
$tail =~ s/ssig seyn\.\\par/ssig seyn\.\\par\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Man that/g;
$tail =~ s/des Werks zusammen\. /des Werks zusammen\. \\blank\[2pt\]/g;
$tail =~ s/joinedup, inmargin\]\\blank\[12pt\]\\tablemainheadrdg\[Vierter Theil\.\]/joinedup, inmargin\]\\tablemainheadrdg\[Vierter Theil\.\]/g;


# errors dealing with the commentary + margins

$tail =~ s/\\par \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[([\w\d]{7})\]Es war/\\par Es \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[$1\]war/g;
$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e8440\]//g;
$tail =~ s/\{\\tfx\\high\{\/c\}\}\\sachIndex\{Wissen\}Wissen/\{\\tfx\\high\{\/c\}\}\\sachIndex\{Wissen\}Wissen\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e8440\]/g;
$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e20290\]//g;
$tail =~ s/\\sachIndex\{Person\}\\italic\{Person\}, als Suppositum/\\sachIndex\{Person\}\\italic\{Person\}, \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e20290\]als Suppositum/g;
$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e29961\]//g;
$tail =~ s/ mit sich bringt\.\\par \\blank\[2pt\] \{\\switchtobodyfont\[8\.5pt\] \\startnarrow \\persIndex\{Adelung, Johann Christoph\}\\italic\{Adelungs\}\\cNote\{\\italic\{Adelung's\}\} Magazin/ mit sich bringt\. \{\\switchtobodyfont\[8\.5pt\] \\startnarrow \\persIndex\{Adelung, Johann Christoph\}\\italic\{Adelungs\}\\cNote\{\\italic\{Adelung's\}\} Magazin\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e29961\]/g;
$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e160171\]//g;
$tail =~ s/Zu \\italic\{literarischen\} Berichtigungen/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Zu \\italic\{literarischen\} Berichtigungen\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e160171\]/g;
$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e109434\]//g;
$tail =~ s/\\par Was man neuerlich/\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Was man\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e109434\] neuerlich/g;
$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e63308\]//g;
$tail =~ s/ber die Evidenz in metaphysichen Wissenschaften, von \\/ber die\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e63308\] Evidenz in metaphysichen Wissenschaften, von \\/g;
$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e179251\]//g;
$tail =~ s/Katechetische Magazine haben \\/Katechetische\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e179251\] Magazine haben \\/g;


# errors dealing with the commentary + scribal abbreviations
$tail =~ s/1818\. \\crlf \\crlf \\rightaligned\{Der Herausgeber\.\}\\par \\stoprdg\}\}/1818\. \\crlf \\crlf \\rightaligned\{Der Herausgeber\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\stoprdg\}\}/g;
$tail =~ s/285\.\\stopitemize \\stopitemize \\stoprdg\}\}/285\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\stopitemize \\stopitemize \\stoprdg\}\}/g;
$tail =~ s/statt Theil\.\\stopitemize \\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\}\{\\tfx\\high\{a\\textbackslash\}\}/statt Theil\.\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\}\{\\tfx\\high\{a\\textbackslash\}\}\\stopitemize /g;
$tail =~ s/\\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/\\rightaligned\{A\. d\. H\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;
$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e188609\]//g;
$tail =~ s/ Die im Jahr 1818/ Die im\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e188609\] Jahr 1818/g;

# manual indentation of notes
$tail =~ s/\\italic\{Anm\.\} 1\. Die Zweydeutigkeit, die in den/\{\\startnarrow\\italic\{Anm\.\} 1\. Die Zweydeutigkeit, die in den/g;
$tail =~ s/tigen\.\\blank\[2pt\] \\subject\[ 173\.\]/tigen\.\\stopnarrow\}\\blank\[2pt\] \\subject\[ 173\.\]/g;
$tail =~ s/Zwar sollte diese Instrumentalphilosophie/\{\\startnarrow Zwar sollte diese Instrumentalphilosophie/g;
$tail =~ s/zur Grundlage dient\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}/zur Grundlage dient\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopnarrow\}/g;
$tail =~ s/Zweifel gesetzt werden sollen\.\\par \\blank\[2pt\]/Zweifel gesetzt werden sollen\.\\par \\blank\[2pt\]\{\\startnarrow /g;
$tail =~ s/Eberhard\}, Halle 1781\. 8\.\\stopitemize \\blank\[2pt\]/Eberhard\}, Halle 1781\. 8\.\\stopitemize \\stopnarrow\}/g;
$tail =~ s/\\sachIndex\{moralisch\}\\italic\{Moralisch\} nennt man bey/\{\\startnarrow\\sachIndex\{moralisch\}\\italic\{Moralisch\} nennt man bey/g;
$tail =~ s/aus der Natur erkennbar ist\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\blank\[2pt\]/aus der Natur erkennbar ist\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopnarrow\}/g;
$tail =~ s/\\blank\[2pt\]Zu dieser letztern Art/\{\\startnarrow Zu dieser letztern Art/g;
$tail =~ s/zu erkennen\?\\blank\[2pt\]/zu erkennen\?\\stopnarrow\}/g;
$tail =~ s/\\blank\[2pt\]Auf dieses letzte/\{\\startnarrow Auf dieses letzte/g;
$tail =~ s/rden\.\\blank\[2pt\] \\subject\[ 208\.\]/rden\.\\stopnarrow\} \\subject\[ 208\.\]/g;
$tail =~ s/tte\.\\par \\blank\[2pt\]\*\) S\./tte\.\\par {\\startnarrow\*\) S\./g;
$tail =~ s/S\. 154 f\.\\blank\[2pt\] \\subject\[209/S\. 154 f\.\\stopnarrow\} \\subject\[209/g;
$tail =~ s/\\blank\[2pt\]Man hat oft darauf gedrungen/\{\\startnarrow Man hat oft darauf gedrungen/g;
$tail =~ s/keine Anwendung litte\.\\blank\[2pt\]/keine Anwendung litte\.\\stopnarrow\}/g;
$tail =~ s/\\blank\[2pt\]Um sich von der Richtigkeit dieser/\{\\startnarrow Um sich von der Richtigkeit dieser/g;
$tail =~ s/wahr sind\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\blank\[2pt\]/wahr sind\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopnarrow\}/g;
$tail =~ s/unbeantwortlich sey\. \*\)\\par \\blank\[2pt\]/unbeantwortlich sey\. \*\)\\par \{\\startnarrow/g;
$tail =~ s/nne\.\\blank\[2pt\]\\stoprdg\}\}\\subject/nne\.\\stopnarrow\}\\stoprdg\}\}\\subject/g;


# general font problems

$tail =~ s/Vorrede des Herausgebers \(c\)\]\{\{\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/Vorrede des Herausgebers \(c\)\]\{\{\\margin\{\}\{plOpen\}\{\}\{\\tfxx\\high\{c\}\}\{c\}\}/g;
$tail =~ s/\\tablemainheadrdg\[ Innhalt des ganzen/\\tablemainhead\[ Innhalt des ganzen/g;
$tail =~ s/ganzen Buchs\}\}\}\\sym\{\} \\setupindenting\[yes,medium\] \\setupitemgroup\[itemize\]\[indenting=\{40pt,next\}\] \\startitemize\[packed, paragraph, joinedup, inmargin\]\\tablemainheadrdg/ganzen Buchs\}\}\}\\sym\{\} \\setupindenting\[yes,medium\] \\setupitemgroup\[itemize\]\[indenting=\{40pt,next\}\] \\startitemize\[packed, paragraph, joinedup, inmargin\]\\tablemainhead/g;
$tail =~ s/\\subject\[207\.\]\{\{207\.\}\}\\blank\[2pt\]Man/\\subject\[207\.\]\{\{\\switchtobodyfont\[8pt\]\{207\.\}\}\}\\blank\[2pt\]Man/g;
$tail =~ s/\\subject\[ 208\.\]\{\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{a197\} 208\.\}\}/\\subject\[ 208\.\]\{\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{a197\} \{\\switchtobodyfont\[8pt\]208\.\}\}\}/g;
$tail =~ s/\\subject\[209\.\]\{\{209\.\}\}\\blank\[2pt\]So/\\subject\[209\.\]\{\{\{\\switchtobodyfont\[8pt\]209\.\}\}\}\\blank\[2pt\]So/g;
$tail =~ s/\\subject\[210\.\]\{\{210\.\}\}\\blank\[2pt\]Die/\\subject\[210\.\]\{\{\{\\switchtobodyfont\[8pt\]210\.\}\}\}\\blank\[2pt\]Die/g;
$tail =~ s/\\subject\[211\.\]\{\{211\.\}\}\\blank\[2pt\]Und/\\subject\[211\.\]\{\{\{\\switchtobodyfont\[8pt\]211\.\}\}\}\\blank\[2pt\]Und/g;
$tail =~ s/\\subject\[202\.\]\{\{202\.\}\}\\blank/\\subject\[202\.\]\{\{\\switchtobodyfont\[8pt\] 202\.\}\}\\blank/g;
$tail =~ s/\\subject\[195\.\]\{\{195\.\}\}\\blank/\\subject\[195\.\]\{\{\\switchtobodyfont\[8pt\] 195\.\}\}\\blank/g;
$tail =~ s/\\subject\[196\.\]\{\{196\.\}\}\\blank/\\subject\[196\.\]\{\{\\switchtobodyfont\[8pt\] 196\.\}\}\\blank/g;
$tail =~ s/\\subject\[178\.\]\{\{178\.\}\}\\blank/\\subject\[178\.\]\{\{\\switchtobodyfont\[8pt\] 178\.\}\}\\blank/g;
$tail =~ s/\\subject\[179\.\]\{\{179\.\}\}\\blank/\\subject\[179\.\]\{\{\\switchtobodyfont\[8pt\] 179\.\}\}\\blank/g;
$tail =~ s/\\subject\[173\.\]\{\{173\.\}\}\\blank/\\subject\[173\.\]\{\{\\switchtobodyfont\[8pt\] 173\.\}\}\\blank/g;
$tail =~ s/\\tablemainhead\[Zweyter Theil\.\]\{\{Zweyter Theil\.\}\}\\tablesubheadrdg/\\tablemainheadrdg\[Zweyter Theil\.\]\{\{Zweyter Theil\.\}\}\\tablesubheadrdg/g;
$tail =~ s/\\tablemainhead\[ Dritter Theil\.\]\{\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{a\[X\]\} Dritter Theil\.\}\}\\tablesubheadrdg/\\tablemainheadrdg\[ Dritter Theil\.\]\{\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{a\[X\]\} Dritter Theil\.\}\}\\tablesubheadrdg/g;
$tail =~ s/\\marking\[oddHeader\]\{III\. Inhalt des dritten Theils \(c\)\}\}\}\\subject/\\marking\[oddHeader\]\{III\. Inhalt des dritten Theils \(c\)\}\}\}\\tablesubheadrdg/g;
$tail =~ s/90\.\\stopitemize \\stopitemize \\stopitemize \\subject\[ Vierter Theil\./90\.\\stopitemize \\stopitemize \\stopitemize \\page \\tablemainheadrdg\[ Vierter Theil\./g;
$tail =~ s/cIX\} Vierter Theil\.\}\}\\subject\[Von/cIX\} Vierter Theil\.\}\}\\tablesubheadrdg\[Von/g;


# pagebreaks
$tail =~ s/thig sey\\cNote\{sei\}\.\\par \\blank\[2pt\]\\marking/thig sey\\cNote\{sei\}\.\\page\[empty,right\]\\marking/g;

# hyphenation
$tail =~ s/1832\) sind 1798/ 1832\) sind 1798/g;
$tail =~ s/gemeinschaftlicher Wiederholung/gemeinschaft-licher Wiederholung/g;
$tail =~ s/Theile \\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/c\}\}\{\/c\}derselben/Theile \\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/c\}\}\{\/c\}dersel-ben/g;
$tail =~ s/Kirchengeschichte, mehr als/Kirchen-geschichte, mehr als/g;


# alignment
$tail =~ s/\\margin\{\}\{pb\}\{\}\{\\vl\}\{b\[II\]\}\{\\tfx\\high\{ac\\textbackslash\}\}/\\leftaligned\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{b\[II\]\}\{\\tfx\\high\{ac\\textbackslash\}\}\}/g;
$tail =~ s/\\switchtobodyfont\[8\.5pt\]\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\marking\[oddHeader\]\{Vorreden\}\{\\startalignment\[center\]\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[I\]\} Anweisung /\\switchtobodyfont\[8\.5pt\]\{\\startalignment\[center\]\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[I\]\} Anweisung /g;
$tail =~ s/Wittwe\. 1791\.\\stopalignment\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{b\[2\]\}\{\\tfx\\high\{ac\\textbackslash\}\}/Wittwe\. 1791\.\\stopalignment\}\\leftaligned\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{b\[2\]\}\{\\tfx\\high\{ac\\textbackslash\}\}\}/g;
$tail =~ s/\\stopalignment\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[II\]\}/\\stopalignment\}\\leftaligned\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[II\]\}\}/g;


# orphan and widow lines
$tail =~ s/93\.\\sym\{\}\\italic\{Erster Abschnitt\:/93\.\\sym\{\}\\page\\italic\{Erster Abschnitt\:/g;
$tail =~ s/287\.\\stopitemize \\stopitemize \\sym\{\}/287\.\\stopitemize \\stopitemize \\sym\{\}\\page/g;
$tail =~ s/Zuletzt, von der vor dem Studium/Zuletzt, von\\page der vor dem Studium/g;

# page breaks in margins
$tail =~ s/\\margin\{\}\{pb\}\{\}\{\\vl\}\{a27\} zu werden/\\margin\{\}\{pb\}\{\}\{\\vl\}\{\; a27\} zu werden/g;
$tail =~ s/\{b143\}ten der Deutschen/\{\; b143\}ten der Deutschen/g;
$tail =~ s/a\[IX\]\}chen Gr/\; a\[IX\]\}chen Gr/g;
$tail =~ s/\{b\[VIII\]\} zu gew/\{\; b\[VIII\]\]\} zu gew/g;
$tail =~ s/c21\}schen, womit/\; c21\}schen, womit/g;
$tail =~ s/b234\} dies/\; b234\} dies/g;
$tail =~ s/c207\} Studierenden/\; c207\} Studierenden/g;
$tail =~ s/a795\} Denn/\; a795\} Denn/g;
$tail =~ s/a788\} unterrichtet/\; a788\} unterrichtet/g;
$tail =~ s/c189\} ists/\; c189\} ists/g;
$tail =~ s/b191\}cher/\; b191\}cher/g;
$tail =~ s/c156\}ben/\; c156\}ben/g;
$tail =~ s/c147\} oder/\; c147\} oder/g;
#$tail =~ s/b159\}lich/\; b159\}lich/g;
$tail =~ s/c143\}fen/\; c143\}fen/g;
$tail =~ s/a733\} Umst/\; a733\]\} Umst/g;
$tail =~ s/\{b140\} trachten/\{\; b140\} trachten/g;
$tail =~ s/a708\} die/\; a708\} die/g;
$tail =~ s/b130\}keit/\; b130\}keit/g;
$tail =~ s/b111\}t/\; b111\}t/g;
$tail =~ s/b108\}laubte/\; b108\}laubte/g;
$tail =~ s/a671\} uns/\; a671\} uns/g;
$tail =~ s/c80\} ist/\; c80\} ist/g;
$tail =~ s/b89\} geschriebnes/\; b89} geschriebnes/g;
$tail =~ s/c70\} beyge/\; c70\} beyge/g;
$tail =~ s/a626\} den/\; a626\} den/g;
$tail =~ s/c41\} dazu/\; c41\} dazu/g;
$tail =~ s/b38\} sie/\; b38\} sie/g;
$tail =~ s/b37\} eine/\; b37\} eine/g;
$tail =~ s/a614\} nur/\; a614\} nur/g;
#$tail =~ s/c29\} als/\; c29\} als/g;
$tail =~ s/c4\} nicht/\; c4\} nicht/g;
$tail =~ s/c256\}sen, oder jene/\; c256\}sen, oder jene/g;
$tail =~ s/c255\} Christenthums nicht/\; c255\} Christenthums nicht/g;
$tail =~ s/a539\} sowohl durch/\; a539\} sowohl durch/g;
$tail =~ s/c201\}glichen/\; c201\}glichen/g;
$tail =~ s/b229\} αὐτοῦ/\; b229\} αὐτοῦ/g;
$tail =~ s/a454\}lichen Kenntnisse/\; a454\}lichen Kenntnisse/g;
$tail =~ s/b168\}den Meinungen/\; b168\}den Meinungen/g;
$tail =~ s/a434\}setz/\; a434\}setz/g;
$tail =~ s/b164\} Vorstellungen/\; b164\} Vorstellungen/g;
$tail =~ s/b161\}logie/\; b161\}logie/g;
$tail =~ s/b148\}gen/\; b148\}gen/g;
$tail =~ s/b146\}schichte/\; b146\}schichte/g;
$tail =~ s/b143\} Untersuchung/\; b143\} Untersuchung/g;
$tail =~ s/b142\} Einfall/\; b142\} Einfall/g;
$tail =~ s/b128\} Verehrung/\; b128\} Verehrung/g;
$tail =~ s/b79\} selbst/\; b79\} selbst/g;
$tail =~ s/c65\} zu/\; c65\} zu/g;
$tail =~ s/c63\} Regeln/\; c63\} Regeln/g;
$tail =~ s/a355\}/\; a355\}/g;
$tail =~ s/a351\}/\; a351\}/g;
$tail =~ s/a328\}/\; a328\}/g;
$tail =~ s/b38\} ein/\; b38\} ein/g;
$tail =~ s/c31\} ersch/\; c31\} ersch/g;
$tail =~ s/a308\}/\; a308\}/g;
$tail =~ s/a307\}/\; a307\}/g;
$tail =~ s/a294\}/\; a294\}/g;
$tail =~ s/b7\} auch/\; b7\} auch/g;
$tail =~ s/b6\} werden/\; b6\} werden/g;
$tail =~ s/c\[3\]\} Dritter/c\[3\]\]\} Dritter/g;
$tail =~ s/b330\} kan/\; b330\} kan/g;
$tail =~ s/a270\} wenigstens/\; a270\} wenigstens/g;
$tail =~ s/a264\}/\; a264\}/g;
$tail =~ s/b297\} mit/\; b297\} mit/g;
$tail =~ s/b248\} bestimmt/\; b248\} bestimmt/g;
$tail =~ s/a235\}/\; a235\}/g;
$tail =~ s/b277\} mehrere/\; b277\} mehrere/g;
$tail =~ s/b269\} man/\; b269\} man/g;
$tail =~ s/c193\} stimmter/\; c193\} stimmter/g;
$tail =~ s/a159\} Dinge/\; a159\} Dinge/g;
$tail =~ s/c148\}ler/\; c148\}ler/g;
$tail =~ s/c147\}rum/\; c147\}rum/g;
$tail =~ s/b160\} neuern/\; b160\} neuern/g;
$tail =~ s/a709\}/\; a709\}/g;
$tail =~ s/b154\} Berufe/\; b154\} Berufe/g;
$tail =~ s/b155\} ihre/\; b155\} ihre/g;
$tail =~ s/a798\}/\; a798\}/g;
$tail =~ s/c169\} bey/\; c169\} bey/g;


$head = $head . $tail;
print $head;