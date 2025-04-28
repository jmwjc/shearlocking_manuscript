# Makefile for LaTeX project

.PHONY: all backup diff clean cleanall

aux = .aux
tex = $(wildcard *.tex)
mk = latexmk -pdfxe -auxdir=$(aux) -outdir=$(aux)

all: main

main: main.tex
	$(mk) main.tex

backup: $(tex)
	mkdir -p backup
	cp -r $^ backup/

diff: $(tex)
	mkdir -p backup diff
	for file in $(tex); do \
		latexdiff $$file backup/$$file > diff/$$file; \
	done
	latexdiff $(aux)/main.bbl backup/$(aux)/main.bbl > diff/main.bbl

clean:
	latexmk -c -auxdir=$(aux) -outdir=$(aux)

cleanall:
	latexmk -C -auxdir=$(aux) -outdir=$(aux)
	rm -rf $(aux) backup diff