#!/bin/bash
# set -x

# run this script on Cygwin Terminal
# list file should have unix line endings
# source "D:\project\20131027-scripts project\20170923-generate csv data of facebook name and id from url listing file.sh" "<url-file-list-name>" >facebook-name-list.csv

# URL Listing file
# https://www.facebook.com/zuck

urllistfilename=$(cygpath -u "$1")
URL_LIST_FILENAME="$urllistfilename"
[ -r "$URL_LIST_FILENAME" ] || read -p "enter urllist filename : " URL_LIST_FILENAME 
[ -r "$URL_LIST_FILENAME" ] || echo "$1" "fatal error: cannot read $URL_LIST_FILENAME"

# thanks: http://www.stackoverflow/a/10929511
 while IFS='' read -r line || [[ -n "$line" ]]; do 	 
    
	S=$((S +1))	 		
	printf "\"" && facebook get name $line && printf "\",\"" && printf "https://www.facebook.com/" && facebook get id $line && printf "\"" && facebook get cleanup $line
	echo
	sleep 5
		
 done < "$URL_LIST_FILENAME"