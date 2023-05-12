file = bookNotes
tex = $(file).tex
pdf = $(file).pdf

make:
	pdflatex content/$(tex) && open $(pdf) 

clean:
	rm *.aux *.log *.toc

full:
	make
	make clean
