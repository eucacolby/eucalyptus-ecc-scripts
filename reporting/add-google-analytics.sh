#!/bin/sh

GOOGLE_SITE_ID="UA-8504735-6"

#############################################################
#
# Basic error checking of the parameters
#

if [ $# -ne 2 ]
  then
    echo "Usage: add-google-analytics [filename] [directory]

    filename - file containing the google anaytic code
    directory - location of html files

    "
    exit 1
fi

if [ ! -e $1 ]
   then
   echo "$1 does not exist or is invalid"
   echo
   exit 1
fi

if [ ! -d $2 ]
   then
   echo "$2 is not a directory"
   echo
   exit 1
fi


#############################################################
#
# Google Analytic site ID is unique to each site
# Be sure this matches the value in your GA snippet!
#
grep -iql "$GOOGLE_SITE_ID" $1
if [ $? != "0" ]
   then
   echo "Google Site ID mistach. Expected: GOOGLE_SITE_ID"
   echo "Make sure the ID in $(basename $0) and $1 match"
   echo
   exit 1
fi


#############################################################
#
# Looks for a .html files in the specified directory and
# injects the google analytic code in the given file. The
# script runs a simple check to see if the code has already
# been injected - otherwise the .html file gets a bit messy.
# Also many html files are just html snippets. It's critical
# that we don't insert GA code into those, or who knows
# what will break.
#
for filename in `find $2 -name *.html`
do
  grep -iql "</body>" $filename
  if [ $? = "0" ]
     then
     grep -iql "$GOOGLE_SITE_ID" $filename
     if [ $? != "0" ]
        then
        sed -e '/<\/body>/,$d' < $filename > temp2.txt
        cat $1 >> temp2.txt
        grep '</body>' $filename | head -1 >> temp2.txt
        sed -e '1,/<\/body>/d' < $filename >> temp2.txt
        mv temp2.txt $filename
        echo "Modified: $filename"
    fi
  fi
done
