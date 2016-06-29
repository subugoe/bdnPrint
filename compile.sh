#!/bin/bash

[[ -d tmp ]] && rm -rf tmp; mkdir tmp

# change input document here
java -cp /home/michelle/Programme/SaxonHE9-6-0-7J/saxon9he.jar net.sf.saxon.Transform -o:tmp/tmp-1.tex demo.xml xslt/transform-to-tex.xsl

perl perl/fix-whitespace.pl > tmp/tmp-2.tex
mv tmp/tmp-2.tex tmp/tmp-1.tex

perl perl/merge-markers.pl > tmp/tmp-2.tex
mv tmp/tmp-2.tex tmp/tmp-1.tex

perl perl/replace-characters.pl > tmp/tmp-2.tex
mv tmp/tmp-2.tex tmp/tmp-1.tex

perl perl/sort-bible-register.pl > tmp/tmp-2.tex
mv tmp/tmp-2.tex tmp/tmp-1.tex

perl perl/preprocess-margins.pl > tmp/tmp-2.tex
mv tmp/tmp-2.tex tmp/tmp-1.tex

perl perl/define-footnotes.pl > tmp/tmp-2.tex
cat context/header.tex >> tmp/tmp-2.tex
cat tmp/tmp-1.tex >> tmp/tmp-2.tex
cat context/footer.tex >> tmp/tmp-2.tex

# works with ConTeXt stand-alone version
#source ~/context/tex/setuptex

cd tmp
context tmp-2.tex
cd ..

perl perl/define-footnotes.pl > tmp/tmp-2.tex
cat context/header.tex >> tmp/tmp-2.tex
perl perl/postprocess-margins.pl >> tmp/tmp-2.tex
cat context/footer.tex >> tmp/tmp-2.tex

cd tmp
context tmp-2.tex
cd ..

# pdftk tmp/tmp-2.pdf cat 1-r2 output output.pdf
pdftk tmp/tmp-2.pdf cat output output.pdf
