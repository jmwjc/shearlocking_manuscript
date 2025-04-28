
.PHONY: backup diff
aux = .aux
tex = $(wildcard *.tex)
mk = latexmk -pdfxe -auxdir=$(aux)

all: main

main: main.tex
	$(mk)

backup/main: backup/main.tex
	$(mk)

backup: $(tex)
	mkdir -p backup
	cp -r $^ backup/

diff: %.tex
	mkdir -p backup
	latexdiff $< backup/$< > diff/$<
	latexdiff $(aux)/main.bbl back/$(aux)/main.bbl > diff/main.bbl

clean:
	latexmk -c -auxdir=$(aux)

cleanall:
	latexmk -C -auxdir=$(aux)
