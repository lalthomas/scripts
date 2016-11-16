#!/bin/bash
# set -x

# cd to the folder you want the combined repository
#
# procedure
# ---------
#
# - open git bash and drag the script file to the terminal from windows explorer
# - add space and the drag the file containing paths to the terminal
# - run the script by hitting enter
# - enter unix path for repository as . (dot), this will give the current directory path
# - combined repo will be generated in folder called parent

# Input to this script is file with list of git repositories"
#
# file.txt
# --------
# d:\repo 1\
# d:\repo 2\
# 
#

# input for output repo path is unix style i.e. /d/folder1/folder2
read -p "enter unix path for combined repo : " path

echo $path

if [ -d "$path" ]; then
 echo "building combined repo..."
 cd "$path"
 mkdir parent
 cd parent
 git init
 touch .gitignore
 git add .
 git commit -m "initial commit"

 # thanks: http://www.stackoverflow/a/10929511
 while IFS='' read -r line || [[ -n "$line" ]]; do 	 
     S=$((S +1))	 
	 echo "processing $S - '$line' repo"
	 # change the backslash to forward slash
	 folderName=${line//\//\\}	 	 
	 # get the base name
	 folderName=`basename  $folderName`
	 folderNameDashed=${folderName// /-}	 	 	 
	 # echo "text read from file: $line"		
	 # folderPath=$( printf '%q' "$line" )			
	 git remote add "$folderNameDashed" "$line"
	 git fetch "$folderNameDashed"
	 git merge -s ours --no-commit "$folderNameDashed"/master
	 git read-tree --prefix="$folderName"/ -u "$folderNameDashed"/master
	 git commit -m "merging ""$folderName"" into subdirectory"
	 git remote remove "$folderNameDashed"
 done < "$1"
fi
