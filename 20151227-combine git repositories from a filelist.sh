#!/bin/bash
set -x

read -p "enter a directory for new repo : " path
cd $path
mkdir parent
cd parent
git init
touch .gitignore
git add .
git commit -m "initial commit"

S=0
# thanks: http://www.stackoverflow/a/10929511
while IFS='' read -r line
do 
    S=$((S +1))
	# echo "text read from file: $line"		
	# folderPath=$( printf '%q' "$line" )			
	git remote add folderName$S "$line"
	git fetch folderName$S
	git merge -s ours --no-commit folderName$S/master
	git read-tree --prefix=folderName$S/ -u folderName$S/master
	git commit -m "merging folderName$S into subdirectory"
done < "$1"

