#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use File::Slurp;

my $head = "";

my $tail = read_file("tmp/noesselt_tmp-1.tex");



# specific processing for Noesselt
# wrong whitespaces
##$tail =~ s/c\[II\], c\} /c\[II\], c\}/g;
##$tail =~ s/\\sym\{\} \\p\{\}\{\\tfx\\high\{c\}\} \\\{\\persIndex\{Heynatz,/\\sym\{\}\\p\{\}\{\\tfx\\high\{c\}\} \\\{\\persIndex\{Heynatz,/g;
##$tail =~ s/\\high\{\/ac\}\} \\marking\[oddHeader\]\{Vorreden\}/\\high\{\/ac\}\}\\marking\[oddHeader\]\{Vorreden\}/g;
##$tail =~ s/\\high\{c\}\}\{c\} \\marking\[oddHeader\]\{Vorreden\}/\\high\{c\}\}\{c\}\\marking\[oddHeader\]\{Vorreden\}/g;
##$tail =~ s/a\[I\]\} \\marking\[oddHeader\]\{Vorreden\}/a\[I\]\}\\marking\[oddHeader\]\{Vorreden\}/g;
##$tail =~ s/ \\marking\[oddHeader\]\{Vorreden/\\marking\[oddHeader\]\{Vorreden/g;
##$tail =~ s/\{b\[II\]\} \{\\tfx\\high\{ac\\textbackslash\}\}/\{b\[II\]\}\{\\tfx\\high\{ac\\textbackslash\}\}/g;
##$tail =~ s/Werke, \\margin\{\}\{plClose\}/Werke,\\margin\{\}\{plClose\}/g;
###$tail =~ s/\\crlf 1818\.\\stopalignment\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[II\]\} \\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/\\crlf 1818\.\\stopalignment\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[II\]\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/g;
##$tail =~ s/c\[II\]\} \\margin\{\}\{plClose/c\[II\]\}\\margin\{\}\{plClose/g;
##$tail =~ s/30\.\\cNote\{30\} f\./30\.\\cNote\{30\}f\./g;
##$tail =~ s/S\. 3 f\.\) Auch in/S\. 3f\.\) Auch in/g;
##$tail =~ s/,\}\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}/,\} \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}/g;
##$tail =~ s/\}\~([^\\\{]{1})/\} $1/g;
##$tail =~ s/ ([?,\.\:\;\)]{1})/$1/g;
##$tail =~ s/,([\w]{1})/, $1/g;
##$tail =~ s/, \\margin\{\}\{pl/,\\margin\{\}\{pl/g;
##$tail =~ s/Kanzelberedtsamkeit\. Marburg 1812\. /Kanzelberedtsamkeit\. Marburg 1812\./g;
##$tail =~ s/S\.\\italic\{Ueber/S\. \\italic\{Ueber/g;
##$tail =~ s/1783\., und\\sym\{\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c134\}\\margin/1783\., und \\\\\\sym\{\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c134\} \\margin/g;
##$tail =~ s/J\. C\. G\. Ackermann\}\\margin/J\. C\. G\. Ackermann\} \\margin/g;
##$tail =~ s/\{\/a\} \\margin\{\}\{e\}/\{\/a\}\\margin\{\}\{e\}/g;
##$tail =~ s/cXIII\}\{\\tfx\\high\{\/c\}\}/cXIII\} \{\\tfx\\high\{\/c\}\}/g;
##$tail =~ s/cher\}mehr Plan/her\} mehr Plan/g;
#$tail =~ s/re\)\}Weltgeschichte in/re\)\} Weltgeschichte in/g;
#$tail =~ s/\\margin\{\}\{pb\}\{\}\{\\vl\}\{([a-c]{1}[\[]{0,1}[0-9]{1,3}[\]]{0,1})\} \\margin\{\}\{pb/\\margin\{\}\{pb\}\{\}\{\\vl\}\{$1\}\\margin\{\}\{pb/g;
#$tail =~ s/\\margin\{\}\{pb\}\{\}\{\\hbox\{\}\}\{([a-c]{1}[\[]{0,1}[0-9]{1,3}[\]]{0,1})\} \\margin\{\}\{pb/\\margin\{\}\{pb\}\{\}\{\\hbox\{\}\}\{$1\}\\margin\{\}\{pb/g;
#$tail =~ s/\\margin\{\}\{pb\}\{\}\{\\vl\}\{([a-c]{1}[0-9]{1,3})\[!\]\} \\margin\{\}\{pb/\\margin\{\}\{pb\}\{\}\{\\vl\}\{$1\[!\]\}\\margin\{\}\{pb/g;
#$tail =~ s/het auf\}!\} /het auf\}!\}/g;
#$tail =~ s/gemacht!\} /gemacht!\}/g;
#$tail =~ s/Zweifeln!\} /Zweifeln!\}/g;
#$tail =~ s/suchten!\} /suchten!\}/g;
#$tail =~ s/Religion!\} /Religion!\}/g;
#$tail =~ s/a184\}201/a184\} 201/g;
#$tail =~ s/Goetting\. 1740\./Goetting\. 1740\. /g;
#$tail =~ s/auszudehnen\. S\./auszudehnen\. S\. /g;
#$tail =~ s/\\margin\{\}\{pb\}\{\}\{\\vl\}\{([a-c]{1}[0-9]{1,3})\}\\margin\{\}\{e/\\margin\{\}\{pb\}\{\}\{\\vl\}\{$1\} \\margin\{\}\{e/g;
#$tail =~ s/c\} \\startalignment\[center\]\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[1\]/c\}\\startalignment\[center\]\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[1\]/g;
#$tail =~ s/pb\}\{\}\{\\vl\}\{c276\}\\italic\{Anm/pb\}\{\}\{\\vl\}\{c276\} \\italic\{Anm/g;
#$tail =~ s/1 Kor\. 1, 18\./1 Kor\. 1, 18\. /g;
#$tail =~ s/1Kor\+1, 21\}V\. 21\./1Kor\+1, 21\}V\. 21\. /g;
#$tail =~ s/Gegensatz gegen das Christenthum, vergl\./Gegensatz gegen das Christenthum, vergl\. /g;
#$tail =~ s/Hebr\+6, 5\}Ebr\. 6, 6\./Hebr\+6, 5\} Ebr\. 6, 6\./g;
#$tail =~ s/\.\.\.\./\. \.\.\./g;
#$tail =~ s/cNote\{bei\}\\bibelIndex/cNote\{bei\} \\bibelIndex/g;
#$tail =~ s/Kol\. 3, 5\./Kol\. 3, 5\. /g;
#$tail =~ s/\\bibelIndex\{R(..)m\+\}\\bibelIndex\{R(..)m\+6,6\}/ \\bibelIndex\{R$1m\+\}\\bibelIndex\{R$2m\+6,6\}/g;

#$tail =~ s/dazu eignete.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/dazu eignete.\\par /g;
#$tail =~ s/zu lassen\?\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/zu lassen\?\\par /g;
#$tail =~ s/schuldig.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/schuldig.\\par /g;
#$tail =~ s/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\] Die kritischen/ Die kritischen/g;
#$tail =~ s/Werth hat.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/Werth hat.\\par /g;
#$tail =~ s/in Folgendem.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/in Folgendem.\\par /g;
#$tail =~ s/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\] Die Schriften selbst/ Die Schriften selbst/g;
#$tail =~ s/fortarbeiten.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/fortarbeiten.\\par /g;
#$tail =~ s/Gelegenheit geben.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/Gelegenheit geben.\\par /g;
#$tail =~ s/Einschaltungen erlaubt.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/Einschaltungen erlaubt.\\par /g;
#$tail =~ s/Verfassers unterschieden.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/Verfassers unterschieden.\\par /g;
#$tail =~ s/erschienen ist.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/erschienen ist.\\par /g;
#$tail =~ s/a234\} \\margin/a234\}\\margin/g;
#$tail =~ s/seyn\? \{\\tfx\\high\{\/c\}\}in sofern\{\\tfx\\high\{c\\textbackslash\}\}\{\\dvl\}\\cNote\{insofern\}/seyn\? \{\\tfx\\high\{\/c\}\}in sofern\{\\tfx\\high\{c\\textbackslash\}\}\{\\dvl\}\\cNote\{insofern\} /g;

# wrong scribal abbreviations
#$tail =~ s/\\margin\{kxXzHQaW\}\{omOpen\}\{z\}\{\\tfx\\high\{\/a\}\}\{\/a\}\\margindata\[inouter\]\{\/a\}\\writetolist\[section\]\{\}\{Vierter Abschnitt. \\italic\{Schöne Wissenschaften\}\}/\\writetolist\[section\]\{\}\{Vierter Abschnitt. \\italic\{Schöne Wissenschaften\}\}/g;
#$tail =~ s/\\crlf Schöne Wissenschaften.\}\}\\margin\{aYNgpFkj\}\{omClose\}\{d1e77096\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\\margindata\[inouter\]\{a\\textbackslash\}/\\crlf Schöne Wissenschaften.\\margin\{aYNgpFkj\}\{omClose\}\{d1e77096\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\\margindata\[inouter\]\{a\\textbackslash\}\}\}/g;
#$tail =~ s/zum Grunde liegen\. \\stopnarrow\} \\blank\[2pt\] \\blank\[2pt\]\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}/zum Grunde liegen\.\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\} \\stopnarrow\} \\blank\[2pt\] \\blank\[2pt\]/g;

#$tail =~ s/\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\\stoprdg\}\} \\noindentation Grammatik der/\\stoprdg\}\} \\noindentation Grammatik der/g;
#$tail =~ s/derselben\\margin\{.{8}\}\{omClose\}\{.{8}\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\} besonders studieren/derselben\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\} besonders studieren/g;
#$tail =~ s/Halle 1804\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\{\\tfx\\high\{a\\textbackslash\}\}\\stopitemize \\stoprdg\}\} \\stopnarrow\} \\blank\[2pt\] \\blank\[2pt\]\{\\tfx\\high\{a\\textbackslash\}\}/Halle 1804\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\{\\tfx\\high\{a\\textbackslash\}\}\\stopitemize \\stoprdg\}\} \\stopnarrow\} \\blank\[2pt\] \\blank\[2pt\]/g;
#$tail =~ s/ndern\. \\crlf \\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\]\{\\tfx\\high\{a\\textbackslash\}\} /ndern\. \\crlf \\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\] /g;

##$tail =~ s/sicht nehmen\. \\crlf \\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\]\{\\tfx\\high\{a\\textbackslash\}\}/sicht nehmen\. \\crlf \\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\]/g;
#$tail =~ s/\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\\subject\[241243\.\]/\\subject\[241243\.\]/g;
#$tail =~ s/\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\}\\subject\[ 261263260/\\subject\[ 261263260/g;
#$tail =~ s/\\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/a\}\}\{\/a}\\writetolist\[section\]\{\}\{Vierter /\\writetolist\[section\]\{\}\{Vierter /g;
#$tail =~ s/ne Wissenschaften\.\}\}\\blank\[2pt\]\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}/ne Wissenschaften\.\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{a\\textbackslash\}\}\{a\\textbackslash\}\}\}\\blank\[2pt\]/g;

##$tail =~ s/\{\[\\\}\]\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}\\par /\{\[\\\}\]\}\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;
#$tail =~ s/A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}/A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}\~\{\\tfx\\high\{a\\textbackslash\}\}/g;
##$tail =~ s/nne\.\\blank\[2pt\]\\stoprdg\}\}\\subject\[§\. 211214\.\]/nne\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stoprdg\}\}\\subject\[§\. 211214\.\]/g;
#$tail =~ s/an die Hand geben\.\\par \\blank\[2pt\]\\stoprdg\}/an die Hand geben\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\stoprdg\}/g;
#$tail =~ s/20\. October 1818\. \\crlf \\rightaligned\{\\italic\{Der Herausgeber\.\}\}\\par/20\. October 1818\. \\crlf \\rightaligned\{\\italic\{Der Herausgeber\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/g;
#$tail =~ s/die Zukunft\. \\crlf \\rightaligned\{D\. H\.\}\\par \\blank\[2pt\]/die Zukunft\. \\crlf \\rightaligned\{D\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/g;
#$tail =~ s/Halle, den 25\. April 1819\.\\par/Halle, den 25\. April 1819\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;
#$tail =~ s/besonders die 3te Sammlung, errinnern\.\\par \\blank\[2pt\]/besonders die 3te Sammlung, errinnern\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;
#$tail =~ s/\\rightaligned\{\\antIndex\{Cicero, Marcus Tullius\}\\italic\{Cic\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/\\rightaligned\{\\antIndex\{Cicero, Marcus Tullius\}\\italic\{Cic\.\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/g;
#$tail =~ s/Halle 1781\. 8\.\\stopitemize \\blank\[2pt\]/Halle 1781\. 8\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopitemize \\stopnarrow\}/g;
#$tail =~ s/\\stopnarrow\}\\stoprdg\}\}\\subject\[\§\. /\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopnarrow\}\\stoprdg\}\}\\subject\[\§\. /g;
#$tail =~ s/D\. H\.\\\}\}\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}//g;
#$tail =~ s/so viel Menschen\-\\cNote\{Menschen\}/so viel \\hbox\{Menschen\-\\cNote\{Menschen\}\}/g;
#$tail =~ s/\\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}\~\{\\tfx\\high\{a\\textbackslash\}\}/\\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\~\{\\tfx\\high\{a\\textbackslash\}\}\}/g;
#$tail =~ s/der Vernunft hinneigen mag\./der Vernunft hinneigen mag\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}/g;
#$tail =~ s/\\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\]\{\\tfx\\high\{a\\textbackslash\}\}/\\rightaligned\{A\. d\. H\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\} \{\\tfx\\high\{a\\textbackslash\}\}\}\\stopnarrow\}\\blank\[2pt\]/g;
#$tail =~ s/nne\.\\blank\[2pt\]\\stoprdg\}\}/nne\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\blank\[2pt\]\\stoprdg\}\}/g;



# paragraphs

#$tail =~ s/im Jahr 1791\.\\par /im Jahr 1791\./g;
#$tail =~ s/\\par \\stoprdg\}\} \\noindentation \\resetnumber/\\stoprdg\}\} \\resetnumber/g;
#$tail =~ s/\\setuppagenumber\[number=1\]\\setuppagenumber\[number=25\]/\\setuppagenumber\[number=25\]/g;
#$tail =~ s/1818\/19\}\} \\crlf \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg\\noindentation/1818\/19\}\} \{\\switchtobodyfont\[8\.5pt\]\{\\startrdg/g;
#$tail =~ s/\\noindentation \\par \\blank\[2pt\]//g;
#$tail =~ s/diese\.\\par \\blank\[2pt\] \{\\switchtobodyfont\[8\.5pt\] \\startnarrow/diese\.\{\\switchtobodyfont\[8\.5pt\] \\startnarrow/g;
#$tail =~ s/literarische Kenntnisse geben\. \\crlf/literarische Kenntnisse geben\./g;
#$tail =~ s/Die neueste Zeit ist/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Die neueste Zeit ist/g;
#$tail =~ s/In den Schriften,/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]In den Schriften,/g;
#$tail =~ s/Man sollte daher auf/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Man sollte daher auf/g;
#$tail =~ s/geworden ist\.\\par Inde/geworden ist\.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\] Inde/g;
#$tail =~ s/Vielleicht kommt/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Vielleicht kommt/g;
#$tail =~ s/des Verfassers unterschieden worden\.\\par/des Verfassers unterschieden worden\.\\par\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/g;
#$tail =~ s/Oft habe ich bei der/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Oft habe ich bei der/g;
#$tail =~ s/Halle, den 25\. April/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Halle, den 25\. April/g;
#$tail =~ s/Literatur\.\\par Fast/Literatur\.\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Fast/g;
#$tail =~ s/zum Grunde gelegt habe\.\\par/zum Grunde gelegt habe\.\\par\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]/g;
#$tail =~ s/Die Erscheinung der/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Die Erscheinung der/g;
#$tail =~ s/Gleichwohl hat man/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Gleichwohl hat man/g;
#$tail =~ s/Man that/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Man that/g;
#$tail =~ s/ssig seyn\.\\par/ssig seyn\.\\par\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Man that/g;
#$tail =~ s/des Werks zusammen\. /des Werks zusammen\. \\blank\[2pt\]/g;

#$tail =~ s/Ansichten des Verfassers des Werks zusammen\. \\blank\[2pt\]/Ansichten des Verfassers des Werks zusammen\. \\blank\[4pt\]/g;
#$tail =~ s/ndet\.\\par \\blank\[2pt\] \{\\switchtobodyfont\[8\.5pt\] \\startnarrow \{\\dvl\}/ndet\. \\noindentation \\blank\[2pt\] \{\\switchtobodyfont\[8\.5pt\] \\startnarrow \{\\dvl\}/g;
#$tail =~ s/Isidorus\. Halle 1778\.\\sym\{\}/Isidorus\. Halle 1778\.\\\\\\sym\{\}/g;
#$tail =~ s/\{\\tfx\\high\{\/ac\}\}\s{0,1}\\blank\[60pt\]/\\blank\[60pt\]\{\\tfx\\high\{\/ac\}\}/g;
#$tail =~ s/\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{([a-z]{1})\}\}\{([a-z]{1})\}\s{0,}\\blank\[60pt\]/\\blank\[60pt\]\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{$1\}\}\{$2\}/g;
#$tail =~ s/\{\\tfx\\high\{([a-z]{1})\}\}\{([a-z]{1})\}\s{0,}\\blank\[60pt\]/\\blank\[60pt\]\{\\tfx\\high\{$1\}\}\{$2\}/g;



# errors dealing with the commentary + margins

#$tail =~ s/\\par \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[([\w\d]{7})\]Es war/\\par Es \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[$1\]war/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e8440\]//g;
#$tail =~ s/\{\\tfx\\high\{\/c\}\}\\sachIndex\{Wissen\}Wissen/\{\\tfx\\high\{\/c\}\}\\sachIndex\{Wissen\}Wissen\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e8440\]/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e20301\]//g;
#$tail =~ s/\\sachIndex\{Person\}\\italic\{Person\}, als Suppositum/\\sachIndex\{Person\}\\italic\{Person\}, \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e20301\]als Suppositum/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e30049\]//g;
#$tail =~ s/ mit sich bringt\.\\par \\blank\[2pt\] \{\\switchtobodyfont\[8\.5pt\] \\startnarrow \\persIndex\{Adelung, Johann Christoph\}\\italic\{Adelungs\}\\cNote\{\\italic\{Adelung's\}\} Magazin/ mit sich bringt\. \{\\switchtobodyfont\[8\.5pt\] \\startnarrow \\persIndex\{Adelung, Johann Christoph\}\\italic\{Adelungs\}\\cNote\{\\italic\{Adelung's\}\} Magazin\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e30049\]/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e160445\]//g;
#$tail =~ s/Zu \\italic\{literarischen\} Berichtigungen/\\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\]Zu \\italic\{literarischen\} Berichtigungen\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e160445\]/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e63372\]//g;
#$tail =~ s/ber die Evidenz in metaphysichen Wissenschaften, von \\/ber die\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e63372\] Evidenz in metaphysichen Wissenschaften, von \\/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e179533\]//g;
#$tail =~ s/Katechetische Magazine haben \\/Katechetische\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e179533\] Magazine haben \\/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e109615\]//g;
#$tail =~ s/\\par Was man neuerlich/\\par \\starteffect\[hidden\]\. \\stopeffect \\hspace\[p\] Was man \\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e109615\]neuerlich/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e89724\]//g;
#$tail =~ s/\\par Die Leser erhalten/\\par Die Leser erhalten\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e89724\]/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e188894\]//g;
#$tail =~ s/\\par Die im Jahr 1818\./\\par Die im Jahr 1818\.\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e188894\]/g;
#$tail =~ s/ V\. des neuen Testaments waren/V\. des neuen Testaments waren/g;

#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e8437\]//g;
#$tail =~ s/Aber das \{\\tfx\\high\{\/c\}\}/Aber\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e8437\] das \{\\tfx\\high\{\/c\}\}/g;




# errors dealing with the commentary + scribal abbreviations
#$tail =~ s/1818\. \\crlf \\crlf \\rightaligned\{Der Herausgeber\.\}\\par \\stoprdg\}\}/1818\. \\crlf \\crlf \\rightaligned\{Der Herausgeber\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}\\stoprdg\}\}/g;
#$tail =~ s/285\.\\stopitemize \\stopitemize \\stoprdg\}\}/285\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\stopitemize \\stopitemize \\stoprdg\}\}/g;
#$tail =~ s/statt Theil\.\\stopitemize \\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\}\{\\tfx\\high\{a\\textbackslash\}\}/statt Theil\.\\margin\{\}\{omClose\}\{\}\{\\tfx\\high\{c\\textbackslash\}\}\{c\\textbackslash\}\{\\tfx\\high\{a\\textbackslash\}\}\\stopitemize /g;
#$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e188609\]//g;
#$tail =~ s/ Die im Jahr 1818/ Die im\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e188609\] Jahr 1818/g;

# manual indentation of notes
#$tail =~ s/\\italic\{Anm\.\} 1\. Die Zweydeutigkeit, die in den/\{\\startnarrow\\italic\{Anm\.\} 1\. Die Zweydeutigkeit, die in den/g;
#$tail =~ s/tigen\.\\blank\[2pt\] \\subject\[ 173\.\]/tigen\.\\stopnarrow\}\\blank\[2pt\] \\subject\[ 173\.\]/g;
#$tail =~ s/Zwar sollte diese Instrumentalphilosophie/\{\\startnarrow Zwar sollte diese Instrumentalphilosophie/g;
#$tail =~ s/zur Grundlage dient\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}/zur Grundlage dient\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopnarrow\}/g;
#$tail =~ s/Zweifel gesetzt werden sollen\.\\par \\blank\[2pt\]/Zweifel gesetzt werden sollen\.\\par \\blank\[2pt\]\{\\startnarrow /g;
#$tail =~ s/\\sachIndex\{moralisch\}\\italic\{Moralisch\} nennt man bey/\{\\startnarrow\\sachIndex\{moralisch\}\\italic\{Moralisch\} nennt man bey/g;
#$tail =~ s/aus der Natur erkennbar ist\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\blank\[2pt\]/aus der Natur erkennbar ist\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopnarrow\}/g;
#$tail =~ s/\\blank\[2pt\]Zu dieser letztern Art/\{\\startnarrow Zu dieser letztern Art/g;
#$tail =~ s/zu erkennen\?\\blank\[2pt\]/zu erkennen\?\\stopnarrow\}/g;
#$tail =~ s/\\blank\[2pt\]Auf dieses letzte/\{\\startnarrow Auf dieses letzte/g;
#$tail =~ s/rden\.\\blank\[2pt\] \\subject\[ 208\.\]/rden\.\\stopnarrow\} \\subject\[ 208\.\]/g;
#$tail =~ s/tte\.\\par \\blank\[2pt\]\*\) S\./tte\.\\par {\\startnarrow\*\) S\./g;
#$tail =~ s/S\. 154 f\.\\blank\[2pt\] \\subject\[209/S\. 154 f\.\\stopnarrow\} \\subject\[209/g;
#$tail =~ s/\\blank\[2pt\]Man hat oft darauf gedrungen/\{\\startnarrow Man hat oft darauf gedrungen/g;
#$tail =~ s/keine Anwendung litte\.\\blank\[2pt\]/keine Anwendung litte\.\\stopnarrow\}/g;
#$tail =~ s/\\blank\[2pt\]Um sich von der Richtigkeit dieser/\{\\startnarrow Um sich von der Richtigkeit dieser/g;
#$tail =~ s/wahr sind\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\blank\[2pt\]/wahr sind\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopnarrow\}/g;
#$tail =~ s/unbeantwortlich sey\. \*\)\\par \\blank\[2pt\]/unbeantwortlich sey\. \*\)\\par \{\\startnarrow/g;
#$tail =~ s/nne\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\blank\[2pt\]\\stoprdg\}\}\\subject/nne\.\\margin\{\}\{plClose\}\{\}\{\\tfx\\high\{a\}\}\{a\}\\stopnarrow\}\\stoprdg\}\}\\subject/g;


# general font problems

#$tail =~ s/Vorrede des Herausgebers \(c\)\]\{\{\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{c\}\}\{c\}\}/Vorrede des Herausgebers \(c\)\]\{\{\\margin\{\}\{plOpen\}\{\}\{\\tfxx\\high\{c\}\}\{c\}\}/g;
#$tail =~ s/\\tableheadrdg\[ Innhalt des ganzen/\\tablehead\[ Innhalt des ganzen/g;
#$tail =~ s/ganzen Buchs\}\}\}\\sym\{\} \\setupindenting\[yes,medium\] \\setupitemgroup\[itemize\]\[indenting=\{40pt,next\}\] \\startitemize\[packed, paragraph, joinedup, inmargin\]\\tableheadrdg/ganzen Buchs\}\}\}\\sym\{\} \\setupindenting\[yes,medium\] \\setupitemgroup\[itemize\]\[indenting=\{40pt,next\}\] \\startitemize\[packed, paragraph, joinedup, inmargin\]\\tablehead/g;
#$tail =~ s/\\subject\[207\.\]\{\{207\.\}\}\\blank\[2pt\]Man/\\subject\[207\.\]\{\{\\switchtobodyfont\[8pt\]\{207\.\}\}\}\\blank\[2pt\]Man/g;
#$tail =~ s/\\subject\[ 208\.\]\{\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{a197\} 208\.\}\}/\\subject\[ 208\.\]\{\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{a197\} \{\\switchtobodyfont\[8pt\]208\.\}\}\}/g;
#$tail =~ s/\\subject\[209\.\]\{\{209\.\}\}\\blank\[2pt\]So/\\subject\[209\.\]\{\{\{\\switchtobodyfont\[8pt\]209\.\}\}\}\\blank\[2pt\]So/g;
#$tail =~ s/\\subject\[210\.\]\{\{210\.\}\}\\blank\[2pt\]Die/\\subject\[210\.\]\{\{\{\\switchtobodyfont\[8pt\]210\.\}\}\}\\blank\[2pt\]Die/g;
#$tail =~ s/\\subject\[211\.\]\{\{211\.\}\}\\blank\[2pt\]Und/\\subject\[211\.\]\{\{\{\\switchtobodyfont\[8pt\]211\.\}\}\}\\blank\[2pt\]Und/g;
##$tail =~ s/\\subject\[202\.\]\{\{202\.\}\}\\blank/\\subject\[202\.\]\{\{\\switchtobodyfont\[8pt\] 202\.\}\}\\blank/g;
#$tail =~ s/\\subject\[195\.\]\{\{195\.\}\}\\blank/\\subject\[195\.\]\{\{\\switchtobodyfont\[8pt\] 195\.\}\}\\blank/g;
##$tail =~ s/\\subject\[196\.\]\{\{196\.\}\}\\blank/\\subject\[196\.\]\{\{\\switchtobodyfont\[8pt\] 196\.\}\}\\blank/g;
##$tail =~ s/\\subject\[178\.\]\{\{178\.\}\}\\blank/\\subject\[178\.\]\{\{\\switchtobodyfont\[8pt\] 178\.\}\}\\blank/g;
##$tail =~ s/\\subject\[179\.\]\{\{179\.\}\}\\blank/\\subject\[179\.\]\{\{\\switchtobodyfont\[8pt\] 179\.\}\}\\blank/g;
##$tail =~ s/tigen\.\\stopnarrow\}\\blank\[2pt\] \\subject\[173\.\]\{\{173\.\}\}\\blank/tigen\.\\stopnarrow\}\\blank\[2pt\] \\subject\[173\.\]\{\{\\switchtobodyfont\[8pt\] 173\.\}\}\\blank/g;
##$tail =~ s/\\tablehead\[Zweyter Theil\.\]\{\{Zweyter Theil\.\}\}\\tableheadrdg/\\tableheadrdg\[Zweyter Theil\.\]\{\{Zweyter Theil\.\}\}\\tableheadrdg/g;
##$tail =~ s/\\tablehead\[ Dritter Theil\.\]\{\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{a\[X\]\} Dritter Theil\.\}\}\\tableheadrdg/\\tableheadrdg\[ Dritter Theil\.\]\{\{\\margin\{\}\{pb\}\{\}\{\\vl\}\{a\[X\]\} Dritter Theil\.\}\}\\tableheadrdg/g;
##$tail =~ s/\\marking\[oddHeader\]\{III\. Inhalt des dritten Theils \(c\)\}\}\}\\subject/\\marking\[oddHeader\]\{III\. Inhalt des dritten Theils \(c\)\}\}\}\\tableheadrdg/g;
##$tail =~ s/90\.\\stopitemize \\stopitemize \\stopitemize \\subject\[ Vierter Theil\./90\.\\stopitemize \\stopitemize \\stopitemize \\page \\tableheadrdg\[ Vierter Theil\./g;
##$tail =~ s/cIX\} Vierter Theil\.\}\}\\subject\[Von/cIX\} Vierter Theil\.\}\}\\tableheadrdg\[Von/g;
##$tail =~ s/zweiten Theils \(c\)\}\}\}\\subject\[Von den eigentlichen theologischen Wissenschaften\.\]\{\{Von den eigentlichen theologischen Wissenschaften\.\}\}\\blank\[2pt\]/zweiten Theils \(c\)\}\}\}\\tableheadrdg\[Von den eigentlichen theologischen Wissenschaften\.\]\{\{Von den eigentlichen theologischen Wissenschaften\.\}\}\\blank\[2pt\]/g;
##$tail =~ s/\{a164\} 173\.\}/\{a164\} \{\\switchtobodyfont\[8pt\]173\.\}\}/g;


# pagebreaks
##$tail =~ s/thig sey\\cNote\{sei\}\.\\par \\blank\[2pt\]\\marking/thig sey\\cNote\{sei\}\.\\page\\noheaderandfooterlines\\marking/g;
##$tail =~ s/geliefert hat\}\~\.\\par \\blank\[2pt\] \\page\[right,empty\]/geliefert hat\}\~\.\\par \\blank\[2pt\] \\page /g;

# hyphenation
##$tail =~ s/1832\) sind 1798/ 1832\) sind 1798/g;
##$tail =~ s/Theile \\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/c\}\}\{\/c\}derselben/Theile \\margin\{\}\{omOpen\}\{\}\{\\tfx\\high\{\/c\}\}\{\/c\}dersel-\\\\ben/g;
##$tail =~ s/Kirchengeschichte, mehr als/Kirchen-\\\\geschichte, mehr als/g;
##$tail =~ s/\\cNote\{Participial/\\cNote\{Participi-al/g;

# alignment
##$tail =~ s/\\switchtobodyfont\[8\.5pt\]\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\marking\[oddHeader\]\{Vorreden\}\{\\startalignment\[center\]\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[I\]\} Anweisung /\\switchtobodyfont\[8\.5pt\]\{\\startalignment\[center\]\\margin\{\}\{plOpen\}\{\}\{\\tfx\\high\{c\}\}\{c\}\\margin\{\}\{pb\}\{\}\{\\vl\}\{c\[I\]\} Anweisung /g;

##$tail =~ s/\{\\tfx\\high\{\/ac\}\}\\marking\[oddHeader\]\{Vorreden\}\{\\startalignment\[center\]/\\marking\[oddHeader\]\{Vorreden\}\{\\startalignment\[center\]\{\\tfx\\high\{\/ac\}\}/g;


# orphan and widow lines
##$tail =~ s/93\.\\page\\sym\{\}\\italic\{Erster Abschnitt\:/93\.\\sym\{\}\\italic\{Erster Abschnitt\:/g;
##$tail =~ s/287\.\\stopitemize \\stopitemize \\sym\{\}/287\.\\stopitemize \\stopitemize \\sym\{\}\\page/g;
##$tail =~ s/Zuletzt, von der vor dem Studium/Zuletzt, von\\page \\noindentation der vor dem Studium/g;
##$tail =~ s/\\stopitemize \\stopitemize \\stopitemize \\sym\{\}\\italic\{Zweyter Abschnitt\: Philosophie\.\}/\\stopitemize \\stopitemize \\stopitemize \\page\\sym\{\}\\italic\{Zweyter Abschnitt\: Philosophie\.\}/g;
##$tail =~ s/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e99376\]Verfassers Anweisung zur theologischen/\\margin\{\}\{e\}\{\}\{\\hbox\{\}\}\{E\}\\pagereference\[d1e99376\]Verfassers Anweisung zur theo-\\page logischen/g;
##$tail =~ s/\\sym\{\} \\setupindenting\[yes, medium\] \\setupitemgroup\[itemize\]\[indenting=\{40pt, next\}\] \\startitemize\[packed, paragraph, joinedup, inmargin\]\\blank\[4pt\]\\tablehead\[Vierter Theil\.\]/\\page\\sym\{\} \\setupindenting\[yes, medium\] \\setupitemgroup\[itemize\]\[indenting=\{40pt, next\}\] \\startitemize\[packed, paragraph, joinedup, inmargin\]\\blank\[4pt\]\\tablehead\[Vierter Theil\.\]/g;



# page breaks in margins

##$tail =~ s/(a\[IX)/\; $1/g;
##$tail =~ s/b\[VIII\]\} zu/\; b\[VIII\]\]\} zu/g;
##$tail =~ s/c21\}schen/\; c21\}schen/g;
##$tail =~ s/c44\}zen/\; c44\}zen/g;
##$tail =~ s/c56\} diesem/\; c56\} diesem/g;
##$tail =~ s/b67\} eines/\; b67\} eines/g;
##$tail =~ s/a104\} beyder/\; a104\} beyder/g;
##$tail =~ s/a106\} noch/\; a106\} noch/g;
##$tail =~ s/b143\}ten/\; b143\}ten/g;
##$tail =~ s/b160\} neuern/\; b160\} neuern/g;
##$tail =~ s/c147\}rum/\; c147\}rum/g;
##$tail =~ s/c148\}ler/\; c148\}ler/g;
##$tail =~ s/a159\} Dinge/\; a159\} Dinge/g;
##$tail =~ s/c193\}stimmter/\; c193\}stimmter/g;
##$tail =~ s/b269\} man/\; b269\} man/g;
##$tail =~ s/b277\} mehrere/\; b277\} mehrere/g;
##$tail =~ s/b284\} bestimmt/\; b284\} bestimmt/g;
##$tail =~ s/b297\} mit/\; b297\} mit/g;
##$tail =~ s/a264\} es/\; a264\} es/g;
##$tail =~ s/a270\} wenigstens/\; a270\} wenigstens/g;
##$tail =~ s/b330\} kan/\; b330\} kan/g;
##$tail =~ s/b6\} werden/\; b6\} werden/g;
##$tail =~ s/b7\} auch/\; b7\} auch/g;
##$tail =~ s/a294\} noch /\; a294\} noch /g;
##$tail =~ s/a307\}ben/\; a307\}ben/g;
##$tail =~ s/a308\} man/\; a308\} man/g;
##$tail =~ s/c31\} ersch/\; c31\} ersch/g;
##$tail =~ s/b38\} ein/\; b38\} ein/g;
##$tail =~ s/a328\} Uebersetzungen/\; a328\} Uebersetzungen/g;
##$tail =~ s/a351\} Werken/\; a351\} Werken/g;
##$tail =~ s/a355\}/\; a355\}/g;
##$tail =~ s/c63\} Regeln/\; c63\} Regeln/g;
##$tail =~ s/c65\} zu/\; c65\} zu/g;
##$tail =~ s/b79\} selbst/\; b79\} selbst/g;
##$tail =~ s/b128\} Verehrung/\; b128\} Verehrung/g;
##$tail =~ s/b142\} Einfall/\; b142\} Einfall/g;
##$tail =~ s/b143\} Untersuchung/\; b143\} Untersuchung/g;
##$tail =~ s/b146\}schichte/\; b146\}schichte/g;
##$tail =~ s/b148\}gen/\; b148\}gen/g;
##$tail =~ s/b161\}logie/\; b161\}logie/g;
##$tail =~ s/b164\} Vorstellungen/\; b164\} Vorstellungen/g;
##$tail =~ s/a434\}setz/\; a434\}setz/g;
##$tail =~ s/b168\}den/\; b168\}den/g;
##$tail =~ s/a437\}cher/\; a437\}cher/g;
##$tail =~ s/c164\}lichen/\; c164\}lichen/g;
##$tail =~ s/b229\} ([^\w]{1})/\; b229\} $1/g;
##$tail =~ s/(c201\}glichen)/\; $1/g;
##$tail =~ s/(a539)/\; $1/g;
##$tail =~ s/(c255\} Christenthums)/\; $1/g;
##$tail =~ s/(c256\}sen)/\; $1/g;
##$tail =~ s/(c4\} nicht selbst)/\; $1/g;
##$tail =~ s/(c29\} als)/\; $1/g;
##$tail =~ s/(a614)/\; $1/g;
##$tail =~ s/(b37\} eine angenehmere)/\; $1/g;
##$tail =~ s/(b38\} sie)/\; $1/g;
##$tail =~ s/(c41\} dazu)/\; $1/g;
##$tail =~ s/(a626)/\; $1/g;
##$tail =~ s/(a646)/\; $1/g;
##$tail =~ s/(c70\} beygemischt)/\; $1/g;
##$tail =~ s/(b89\} geschriebnes)/\; $1/g;
##$tail =~ s/(c80\} ist)/\; $1/g;
##$tail =~ s/(a671)/\; $1/g;
##$tail =~ s/(b108\}laubte)/\; $1/g;
##$tail =~ s/(b111\}t)/\; $1/g;
##$tail =~ s/(b130\}keit)/\; $1/g;
##$tail =~ s/(a708)/\; $1/g;
##$tail =~ s/(b140\} trachten)/\; $1/g;
##$tail =~ s/(a725)/\; $1/g;
##$tail =~ s/(b154\} Berufe)/\; $1/g;
##$tail =~ s/(b155\} ihre)/\; $1/g;
##$tail =~ s/(c143\}fen)/\; $1/g;
##$tail =~ s/(a733)/\; $1/g;
##$tail =~ s/(c147\} oder)/\; $1/g;
##$tail =~ s/(c156\}ben)/\; $1/g;
##$tail =~ s/(b191\}cher)/\; $1/g;
##$tail =~ s/(c189\} ists)/\; $1/g;
##$tail =~ s/(a788)/\; $1/g;
##$tail =~ s/(a795)/\; $1/g;
##$tail =~ s/(a798)/\; $1/g;
##$tail =~ s/(c207\} Studierenden)/\; $1/g;
##$tail =~ s/(b234\} dies)/\; $1/g;
##$tail =~ s/(c214\}denke)/\; $1/g;
##$tail =~ s/(a820)/\; $1/g;
##$tail =~ s/a235\}/\; a235\}/g;
##$tail =~ s/c254\} \\line\{\}/c254\]\} \\line\{\}/g;
##$tail =~ s/c\[3\]\} Zweyter/c\[3\]\]\} Zweyter/g;
##$tail =~ s/a709\} \\margin/\; a709\}\\margin/g;


# empty pages. check this!
##$tail =~ s/\\newPage\\marking\[oddHeader\]\{I\. Inhalt des ersten Theils \(c/\\page\\marking\[oddHeader\]\{I\. Inhalt des ersten Theils \(c/g;


# error in biblical index
##$tail =~ s/\\bibelIndex\{([\w]+)\+\}//g;

# tables
##$tail =~ s/\\startitemize\[packed, paragraph, joinedup\] \\tableheadrdg\[Philosophie\./\\startitemize\[packed, paragraph, joinedup, inmargin\] \\tableheadrdg\[Philosophie\./g;
##$tail =~ s/joinedup \]\\sym\{\}I\. Was Philologie sey/joinedup, inmargin\]\\sym\{\}I\. Was Philologie sey/g;
##$tail =~ s/\\startitemize\[packed, paragraph, joinedup \]\\tableheadrdg\[Erster Abschnitt\. Philologie\]\{\{Erster Abschnitt\. Philologie\}\}\\blank\[2pt\]\\sym\{\}I\. Was Philologie/\\startitemize\[packed, paragraph, joinedup, inmargin\]\\tableheadrdg\[Erster Abschnitt\. Philologie\]\{\{Erster Abschnitt\. Philologie\}\}\\blank\[2pt\]\\sym\{\}I\. Was Philologie/g;


# greek test
##$tail =~ s/\x{03B4}//g;


$head = $head . $tail;
print $head;
