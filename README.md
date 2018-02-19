# bdnPrint

> Generate printable PDFs for the "Bibliothek der Neologie".

bdnPrint is a collection of stylesheets and scripts to generate printable PDFs from TEI/XML. It was originally developed for the DFG-funded ["Bibliothek der Neologie"](http://www.bdn-edition.de) project and runs on an [intermediate format](https://github.com/arokis/bdnprint_if) that is based on the project's specific TEI/XML schema. 

Feel free to build on the code in this repository!


## Prerequisits

* Bash
* Saxon9HE
* Perl
    * File::Slurp
    * List::MoreUtils
    * String::Random
    * Unicode::UCD
* ConTeXt
* PDFtk

The font used in bdnPrint is [**EB Garamond**](http://www.georgduffner.at/ebgaramond/), which is a free Garamond typeface. Please make sure you have this font installed such that ConTeXt is able to find it. Of course you can use any other font you wish. Simply change the line

	 \setmainfont[ebgaramond]
	 
in `context/header.tex` to an already installed font.


## Installing

Simply clone the repository, change into the respective directory and run

	compile.sh author
	
if you want to create the work of a single author or

	compile.sh all

which creates a PDF for all available XML files in `input/`.



## Versioning

We use [SemVer](http://semver.org/) for versioning. 


## Authors

* **Hannes Riebl** - *2015* - [hriebl](https://github.com/hriebl)
* **Michelle Rodzis** - *2015-2018* - [MRodz](https://github.com/MRodz)

See also the list of [contributors](https://github.com/subugoe/bdnPrint/contributors) who participated in this project.


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.txt) file for details


