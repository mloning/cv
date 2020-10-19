#!/bin/bash

OUTDIR=$1
FILE=$2

OPTIONS="--synctex=1 -interaction=nonstopmode"

# Create directory for output files
mkdir -p $OUTDIR

lualatex $OPTIONS --output-directory=$OUTDIR $FILE.tex
biber --output-directory=$OUTDIR $FILE
lualatex $OPTIONS --output-directory=$OUTDIR $FILE.tex
lualatex $OPTIONS --output-directory=$OUTDIR $FILE.tex

# Copy generated pdf to main directory
cp $OUTDIR/$FILE.pdf .
