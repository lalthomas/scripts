#!/usr/bin/bash

# thanks http://www.folkstalk.com/2012/07/bash-shell-script-to-read-parse-comma.html

INPUT_FILE='unix_file.csv'

IFS=','

while read OS HS
do

echo "Operating system - $OS"
echo "Hosting server type - $HS"

done < $INPUT_FILE