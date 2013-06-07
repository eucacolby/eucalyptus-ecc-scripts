#!/bin/sh

if [ $# -eq 0 ]
  then
    echo "Usage: add-google-analytics [filename] [directory]

    filename - file containing the google anaytic code
    directory - location of html files

    "
fi

#i############################################################
#
# Looks for a .html files in the specified directory and
# injects the google analytic code in the given file. The
# script runs a simple check to see if the code has already
# been injected - otherwise the .html file gets a bit messy.
#
#
for filename in `find $2 -name *.html`
do
  grep -iql "UA-8504735-1" $filename
  if [ $? != "0" ]
    then
      sed -e '/<\body>/,$d' < $filename > temp2.txt
      cat $1 >> temp2.txt
      grep '</body>' $filename | head -1 >> temp2.txt
      sed -e '1,/<\/body>/d' < $filename >> temp2.txt
      mv temp2.txt $filename
      echo "Modified: $filename"
  fi
done
