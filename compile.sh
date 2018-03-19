#!/bin/bash


datestamp() {
	date +%Y%m%d
}

timestamp() {
	date +%T
}

compile() {
	[[ ! -d tmp ]] && mkdir tmp
	cd tmp
	rm $1_*
	cd ..
	[[ ! -d log ]] && mkdir log
	[[ ! -d output/$1_archive ]] && mkdir -p output

	perl perl/core/fix-braces.pl $1 > $1_tmp.xml
	perl perl/core/preprocess-xml.pl $1 > $1_tmp-2.xml
	perl perl/core/switch-commentary-markers.pl $1 > $1_tmp.xml
	#mv $1_tmp-2.xml $1_tmp.xml

	# chance according to XSLT processor
	processorlocation="$(locate saxon9he.jar)"

	java -cp $processorlocation net.sf.saxon.Transform -o:tmp/$1_tmp-1.tex $1_tmp.xml xslt/tei2tex.xsl

	echo "$(timestamp) fix-whitespace begin" > log/log_$1_$(datestamp).txt

	perl perl/core/fix-whitespace.pl $1 > tmp/$1_tmp-2.tex
	mv tmp/$1_tmp-2.tex tmp/$1_tmp-1.tex

	echo "$(timestamp) fix-whitespace finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) preprocessing begin" >> log/log_$1_$(datestamp).txt

	perl perl/authors/$1-preprocessing.pl > tmp/$1_tmp-2.tex
	mv tmp/$1_tmp-2.tex tmp/$1_tmp-1.tex

	echo "$(timestamp) preprocessing finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) replace characters begin" >> log/log_$1_$(datestamp).txt

	perl perl/core/replace-characters.pl $1 > tmp/$1_tmp-2.tex
	mv tmp/$1_tmp-2.tex tmp/$1_tmp-1.tex

	echo "$(timestamp) replace characters finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) sort bible register begin" >> log/log_$1_$(datestamp).txt

	perl perl/core/sort-bible-register.pl $1 > tmp/$1_tmp-2.tex
	mv tmp/$1_tmp-2.tex tmp/$1_tmp-1.tex

	echo "$(timestamp) sort bible register finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) preprocess margins begin" >> log/log_$1_$(datestamp).txt

	perl perl/core/preprocess-margins.pl $1 > tmp/$1_tmp-2.tex
	mv tmp/$1_tmp-2.tex tmp/$1_tmp-1.tex

	echo "$(timestamp) preprocess margins finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) fix typeares begin" >> log/log_$1_$(datestamp).txt

	perl perl/core/fix-typearea.pl $1 > tmp/$1_tmp-2.tex
	mv tmp/$1_tmp-2.tex tmp/$1_tmp-1.tex

	echo "$(timestamp) fix-typeares finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) define footnotes begin" >> log/log_$1_$(datestamp).txt

	perl perl/core/define-footnotes.pl $1 > tmp/$1_tmp-2.tex
	cat context/header.tex >> tmp/$1_tmp-2.tex
	cat tmp/$1_tmp-1.tex >> tmp/$1_tmp-2.tex
	cat context/footer.tex >> tmp/$1_tmp-2.tex

	echo "$(timestamp) define footnotes finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) compiling begin" >> log/log_$1_$(datestamp).txt

	cd tmp
	context $1_tmp-2.tex >> ../log/log_$1_$(datestamp).txt
	cd ..

	echo "$(timestamp) compiling finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) define footnotes begin" >> log/log_$1_$(datestamp).txt

	perl perl/core/define-footnotes.pl $1 > tmp/$1_tmp-2.tex
	cat context/header.tex >> tmp/$1_tmp-2.tex

	echo "$(timestamp) define footnotes finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) postprocess margins begin" >> log/log_$1_$(datestamp).txt

	perl perl/core/postprocess-margins.pl $1 > tmp/$1_tmp-3.tex
	perl perl/authors/$1-postprocessing.pl $1 > tmp/$1_tmp-4.tex
	perl perl/core/remove-moved-elements.pl $1 >> tmp/$1_tmp-2.tex

#	
#	mv tmp/$1_tmp-2.tex tmp/$1_tmp-1.tex
	cat context/footer.tex >> tmp/$1_tmp-2.tex

	echo "$(timestamp) postprocess margins finished" >> log/log_$1_$(datestamp).txt
	echo "$(timestamp) compiling begin" >> log/log_$1_$(datestamp).txt

	mv tmp/comments.txt tmp/comments_$1_save.txt

	notify-send "Entering second stage of $1"

	cd tmp
	context $1_tmp-2.tex >> ../log/log_$1_$(datestamp).txt
	cd ..

	echo "$(timestamp) compiling finished" >> log/log_$1_$(datestamp).txt

	pdftk tmp/$1_tmp-2.pdf cat output $1_$(datestamp).pdf
	rm $1_tmp*.xml
	mv $1_$(datestamp).pdf output

	# tidy up output directory: out-of-date PDFs are stored in archive
	cd output
	pattern="./$1_$(datestamp).pdf"
	for file in ./$1_*.pdf; do
		if ! [ $file == $pattern ]; then
			mv $file $1_archive
		fi
	done
	cd ..

	notify-send "Compilation of $1 finished"
}


case $1 in
	noesselt)
	compile $1
	;;
	griesbach)
	compile $1
	;;
	less)
	compile $1
	;;
	ernesti)
	compile $1
	;;
	teller)
	compile $1
	;;
	bahrdt-semler)
	compile $1
	;;
	niemeyer)
	compile $1
	;;
	sack)
	compile $1
	;;
	steinbart)
	compile $1
	;;
	toellner)
	compile $1
	;;
	all)
	echo "WARNING: compiling all available XML documents will take some time."
	for i in $(ls input/ | grep -v '_full'); do
		author=$(echo $i | cut -d '.' -f 1)
		echo "------------------------------------"
		echo "starting to compile $author."
		compile $author
	done
	echo "finished compiling."
	;;
	*)
	echo "invalid name. try again."
	;;
esac