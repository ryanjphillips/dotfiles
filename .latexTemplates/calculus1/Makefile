file = CAModernApproach
tex = $(file).tex
pdf = $(file).pdf

make:
	pdflatex content/$(tex) && open $(pdf) 

clean:
	rm *.aux *.log

full:
	make
	make clean
