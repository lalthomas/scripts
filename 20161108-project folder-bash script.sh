#!/bin/bash -x

# Filename : 20161108-action folder-bash script.sh
# Author : Lal Thomas 
# Date : 2016-11-08
# © Lal Thomas (lal.thomas.mail@gmail.com)

alias project=_project_main_

_project_main_(){

	create(){		
			
		getProjectType(){
		
			echo
			echo find the project repo type from opened file
			start "" "d:\Dropbox\project\20131027-scripts project\20150715-git-bash script readme.md"
			echo
			read -p "enter project repo type and press [enter]: " projecttype
			echo
				
		}
		
		getProjectName(){
			
			read -p "enter project name and press [enter]: " projectname
			
		}
		
		argsno=$#		
		local projecttype=$1
		shift
		local location=$1
		shift
		local projectname="$@"

		if [ $argsno -eq 0 ];	
		then	
			getProjectType
			location=$PWD
			getProjectName
		else   
			if [ $argsno -eq 1 ];
				then					
					location=$PWD
					getProjectName
			else
				if [ $argsno -eq 2 ]; 				
				then
					getProjectName
				fi						
			fi	   		   		
		fi
		
		echo INFO: T:$projecttype L:$location N:$projectname
		
		local projectpath="$location/$today-$projectname"
		mkdir -p "$projectpath"		
		
		# get inside the repo
		cd "$projectpath"
		
		# add readme		
		t markdown add H1 "ReadMe" "readme.md"
		
		# add gitignore
		g repo add gitignore windows >/dev/null
		g repo add gitignore $projecttype >/dev/null
		
		# intialize repo
		g repo create "$projectpath" >/dev/null
		echo "SUCCESS : Project repo created successfully"
		
		# add to inbox list
		projectfolder=$(cygpath -d "$PWD")		
		echo $projectfolder>>"$(cygpath -u "D:\Dropbox\do\inbox.txt")"
		
		start "" "D:\Dropbox\do\inbox.txt"
		
		# get out of repo		
		cd ..
	}

	usage(){
		
		echo 
        echo "project OPTIONS"      
        echo " helper script to managing do folder"   
        echo 
        echo "OPTIONS are..."
        echo 		
		echo "create [type] [path] [name]"		
		echo "create [path] [name]"		
		echo "create [name]"		
		echo 
		echo "e.g. project create Python . python workouts"
		echo		
		
	}
	
	project=$1
	shift
	
	# test the script
	# echo $filename $project

	pushd "D:\Dropbox\project" > /dev/null 2>&1
	case "$project" in		
		create) create $@;;
		help|usage)	usage ;;		
	esac	
	popd  > /dev/null 2>&1
	
}