#!/bin/sh

if [ $# -ne 2 ]
  then
    echo "Usage: get-account-email-addresses [infile] [outfile]

    infile - file containing the list of accounts to lookup 
    outfile - result file containing accounts and email address for each admin

    "
fi

##
##  Check that input file exists
##
if [ ! -e $1 ]
  then
    echo "$1 does not exist."
    exit 1
fi
##
## Get email addresses given a list of accounts
## Save the results into a new file
##
echo "Gathering email addresses...."
for accountName in `cat $1`
do
   adminEmail=`euare-usergetinfo -u admin --as-account $accountName | cut -f2`
   echo $accountName, $adminEmail >> $2
done
echo "Done"

