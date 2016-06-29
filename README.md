# bdnPrint

> Generate printable PDFs from TEI/XML

bdnPrint is a collection of stylesheets and scripts to generate printable PDFs from TEI/XML. It was originally developed for the DFG-funded ["Bibliothek der Neologie"](http://www.bdn-edition.de) project and runs on the project's specific TEI/XML schema. The latter will be published in April 2017.

Feel free to build on the code in this repository!


## Prerequisits

* Bash
* Saxon
* Perl
    * File::Slurp
    * List::MoreUtils
    * String::Random
    * Unicode::UCD
* ConTeXt
* PDFtk

The font used in bdnPrint is currently [**EB Garamond**](http://www.georgduffner.at/ebgaramond/), which is a free Garamond typeface. Please make sure you have this font installed such that ConTeXt is able to find it. Of course you can use any other font you wish. Simply change the line

	 \setmainfont[ebgaramond]
	 
in `context/header.tex` to an already installed font.


## What it does

All you should need to do is run 

	compile.sh 
	
Nevertheless, here is an overview of the different files in the repository:

`context/`:

* `header.tex`: contains all ConTeXt code, including the LuaTeX code to extract margin notes
* `footer.tex`: generates indexes and closes the ConTeXt code

`perl/`:

* `define-footnotes.pl`: defines footnotes for the different combinations of text witnesses
* `fix-whitespace.pl`: fixes whitespace problems before headings, after footnote markers and in general
* `generate-code-points.pl`: generates a list with the unicode code points for decomposed lower case letters
* `merge-markers.pl`: merges omission markers that are not separated by a whitespace character
* `postprocess-margins.pl`: assigns IDs to all information that shall appear in a margin note
* `preprocess-margin.pl`: inserts margin notes in the right places of the ConTeXt code
* `replace-characters.pl`: replaces some UTF-8 characters with their TeX commands
* `sort-bible-register.pl`: assigns special sortkeys to referenced bible passages. This script will probably be deprecated soon, since we are testing a different way of encoding biblical references.

`xslt/`:

* `list-mixed.xsl`: lists all TEI/XML elements with mixed content
* `transform-to-tex.xsl`: generates ConTeXt code from TEI/XML



## Still to be done

* In the near future we will provide a mechanism which sees about historical hyphenation. Since the "Library of Neology" is a project which deals with German (and one Latin) text(s) of the 18th century, there are partially severe differences between the texts' and modern orthography. This currently causes wrong hyphenation behaviour that has to be corrected manually (which in part causes conflicts between ConTeXt's hyphenation command and the selected language package). 
* Currently the scripts only work with the <front> element of the XML. An implementation for the table of contents and foreword is still missing.
* XInclude remains to be considered in `transform-to-tex.xsl`.
* To denote editorial notes, a scribal abbreviation (E) is inserted into the margin. For x notes, x abbreviations appear. This is currently suppressed by a regex in `postprocess-margins.pl` and needs a better solution.




## License

Original work Copyright (c) 2015 Hannes Riebl
Modified work Copyright (c) 2015 - 2016 Michelle Rodzis (on behalf of the
DFG-funded project "Bibliothek der Neologie")

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
