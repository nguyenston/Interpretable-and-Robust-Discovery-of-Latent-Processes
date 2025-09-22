#!/usr/bin/env bash

# script for submitting to arxiv
# thanks to Dan Roy for sharing his original version of this

ORIG='writing'
DOC='arxiv-temp'
rm -rf $DOC
mkdir $DOC
mkdir $DOC/figures

cp $ORIG/figures/*.pdf $DOC/figures
cp $ORIG/figures/*.png $DOC/figures
cp $ORIG/imsart.sty $DOC/
cp $ORIG/autonum.sty $DOC/
cp $ORIG/shortcuts.tex $DOC/
cp $ORIG/imsart.cls $DOC/
cp $ORIG/manuscript_arxiv.bbl $DOC/_main.bbl

for file in manuscript_arxiv
do
    perl -pe 's/(^|[^\\])%.*/\1%/' < $ORIG/$file.tex | \
    perl -pe 's/(^|[^\\])\\fTBD.*/\1/' | \
    perl -pe 's/(^|[^\\])\\PROBLEM.*/\1/' > $DOC/$file.tex
done
mv $DOC/manuscript_arxiv.tex $DOC/_main.tex

rm arxiv.zip
zip -r arxiv.zip $DOC
