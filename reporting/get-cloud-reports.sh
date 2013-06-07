#!/bin/sh

startDate=`date --date='90 days ago' '+%Y-%m-%d'`
endDate=`date '+%Y-%m-%d'`

echo $startdate
echo $enddate

echo Generating instance report....
eureport-generate-report -t instance -f csv -s $startDate -e $endDate instance-report.csv
cat instance-report.csv | grep "Account:" | cut -d, -f2 | cut -d' ' -f2 > instance-accounts.txt

echo Generating S3 report....
eureport-generate-report -t s3 -f csv -s $startDate -e $endDate s3-report.csv
cat s3-report.csv | grep "Account:" | cut -d, -f1 | cut -d' ' -f2 | sort > s3-accounts.txt

echo Generating Volume report....
eureport-generate-report -t volume -f csv -s $startDate -e $endDate volume-report.csv
cat volume-report.csv | grep "Account:" | cut -d, -f2 | cut -d' ' -f2 | sort > volume-accounts.txt
