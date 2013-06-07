#!/bin/sh

##
## Generate a sorted list of all cloud accounts
##
euare-accountlist | cut -f 1 | sort > ./sorted_account_list.txt
