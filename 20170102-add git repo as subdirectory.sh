#!/bin/bash
# set -x

# this process doesn't contain whole history of combined repos

# cd to the folder you want the combined repository
#
# procedure
# ---------
#
# - open git bash on the repo where want to the other repo to be the subfolder
# - drag the script file to the terminal from windows explorer
# - the drag the file containing paths to the terminal, listing file should having unix line endings
# - run the script

# Input to this script is file with list of git repositories"
#
# file.txt
# --------
# d:\repo 1\
# d:\repo 2\
# 
#

echo "adding subrepo..."
# thanks: http://www.stackoverflow/a/10929511
while IFS='' read -r line || [[ -n "$line" ]]; do 	 		 
	
	 # echo "text read from file: $line"			 
	 S=$((S +1))	 
	 echo "processing $S - '$line' repo"
	 
	 # change the backslash to forward slash
	 folderName=${line//\//\\}	 	 
	 # get the base name
	 folderName=`basename  $folderName`
	 echo $folderName
	 folderNameDashed=${folderName// /-}	 	 	 
				 
	 git remote add "$folderNameDashed" "$line"
	 git fetch "$folderNameDashed"
	 git subtree add -P "$folderNameDashed" "master"
	 git remote remove "$folderNameDashed"
	 
done < "$1"
