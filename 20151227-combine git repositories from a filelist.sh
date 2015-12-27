#!/bin/bash
# set -x

# Input to this script is file with list of git repositories"
#
# file.txt
# --------
# d:\repo 1\
# d:\repo 2\
#
#
read -p "enter a name for combined repo : " path
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
	folderName=${line##*\\}
	folderNameDashed=${folderName// /-}
	# echo "$folderName"
	# echo "text read from file: $line"		
	# folderPath=$( printf '%q' "$line" )			
	git remote add "$folderNameDashed" "$line"
	git fetch "$folderNameDashed"
	git merge -s ours --no-commit "$folderNameDashed"/master
	git read-tree --prefix="$folderName"/ -u "$folderNameDashed"/master
	git commit -m "merging ""$folderName"" into subdirectory"
done < "$1"

