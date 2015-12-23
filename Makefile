TITLE := state_harmful

all: $(TITLE).pdf

$(TITLE).pdf: $(TITLE).tex
	pdflatex -interaction batchmode -halt-on-error $(TITLE) && \
	bibtex $(TITLE) && \
	pdflatex -interaction batchmode -halt-on-error $(TITLE) && \
	pdflatex -interaction batchmode -halt-on-error $(TITLE)

$(TITLE).tex: $(TITLE).md biblio.bib style/template.tex
	pandoc $(TITLE).md \
		-f markdown+footnotes \
		--toc \
		--biblio biblio.bib \
		--natbib \
		--template style/template.tex \
		-V documentclass=report \
		-V papersize=a4paper \
		-V fontsize=12pt \
		-V biblio-style=plain \
		-o $(TITLE).tex

clean:
	rm -f $(TITLE).tex $(TITLE).aux $(TITLE).log $(TITLE).toc $(TITLE).bbl $(TITLE).blg $(TITLE).out

clean-all: clean
	rm -f $(TITLE).pdf
