#! /bin/bash

COMMAND="pdflatex -halt-on-error -interaction=nonstopmode --shell-escape main.tex && \
    biber main && \
	makeindex main && \
    pdflatex -synctex=1 -halt-on-error -interaction=batchmode --shell-escape main.tex"

find . -type f \( -name "*.cls" -o -name "*.tex" -o -name "*.bib" -o -name "*.png" \) \
    | entr bash -c "$COMMAND"
