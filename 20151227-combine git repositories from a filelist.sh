#!/bin/bash
# set -x

# cd to the folder you want the combined repository
#
# procedure
# ---------
#
# - open git bash and drag the script file to the terminal from windows explorer
# - add space
# - the drag the file containing paths to the terminal
#		- listing file should having unix line endings
# 		- if folder name have space it will not work
# - run the script by hitting enter
# - enter unix path for repository as . (dot), this will give the current directory path
# - combined repo will be generated in folder called parent

# filelist
# Input to this script is file with list of git repositories
#
# file.txt
# --------
# d:\repo 1\
# d:\repo 2\
#
filelist=$(cygpath -u "$1")
echo $filelist
FILE_LIST="$filelist"
[ -r "$FILE_LIST" ] || read -p "enter filelist path for combined repo : " FILE_LIST 
[ -r "$FILE_LIST" ] || echo "$1" "fatal error: cannot read filelist $FILE_LIST"

# project path
# input for output repo path is unix style i.e. /d/folder1/folder2
projectpath=$(cygpath -u "$2")
echo $projectpath
PROJECT_PATH="$projectpath"
[ -r "$PROJECT_PATH" ] || read -p "enter unix path for combined repo : " PROJECT_PATH 
[ -r "$PROJECT_PATH" ] || echo "$2" "fatal error: cannot read filelist $PROJECT_PATH"

echo $PROJECT_PATH

if [ -d "$PROJECT_PATH" ]; then
 echo "building combined repo..."
 cd "$PROJECT_PATH"
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
	 echo $folderName
	 folderNameDashed=${folderName// /-}	 	 	 
	 # echo "text read from file: $line"		
	 # folderPath=$( printf '%q' "$line" )			
	 
	 # add remote and fetch
	 git remote add "$folderNameDashed" "$line"
	 git fetch "$folderNameDashed"
	 # ----
	 
	 # if repos are not similar then use this line
	 git merge -s ours --allow-unrelated-histories --no-commit "$folderNameDashed"/master
	 # git merge -s ours --no-commit "$folderNameDashed"/master
	 # ----
	 
	 # git read-tree --prefix="subfolder/$folderName"/ -u "$folderNameDashed"/master	 
	 git read-tree --prefix="$folderName"/ -u "$folderNameDashed"/master
	 
	 git commit -m "merging ""$folderName"" into subdirectory"
	 git remote remove "$folderNameDashed"
	 
 done < "$FILE_LIST"
fi
