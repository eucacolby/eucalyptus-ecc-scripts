#!/bin/sh

if [ -f sorted_account_list.txt ] ;
   then
       echo "Searching activity...." 
   else
       echo "Sorted account list file not found"
       exit 1
fi

##
## Clean up from previous run
##
rm -f accounts_active.txt
rm -f accounts_inactive.txt

##
## See who's been using the system
##
for accountName in `cat sorted_account_list.txt`
do
   grep -q $accountName *-accounts.txt
   if [ $? = 0 ] ;
     then
        echo $accountName >> accounts_active.txt
     else
        echo $accountName >> accounts_inactive.txt
   fi
done

echo "Search complete. See active and inactive files for details." 
