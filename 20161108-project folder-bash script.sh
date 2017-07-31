#!/bin/bash -x

# Filename : 20161108-action folder-bash script.sh
# Author : Lal Thomas 
# Date : 2016-11-08
# © Lal Thomas (lal.thomas.mail@gmail.com)

alias project=_project_main_

_project_main_(){

	create(){		
		
		local projectname=""
		local projecttype=""		
		local projectfolder=""
		
		getProjectName(){
			
			read -p "enter project name and press [enter]: " projectname
			
		}
		
		getProjectType(){
		
			filetypereadme="d:\Dropbox\project\20131027-scripts project\20150715-git-bash script readme.md"			
			echo find the project repo type from opened file
			start "" "$filetypereadme" > /dev/null 2>&1 || cygstart "$filetypereadme" > /dev/null 2>&1			
			read -p "enter project repo type and press [enter]: " projecttype			
				
		}
		
		argsno=$#				
		# echo "#argument  : $argsno"
		
		if [ $argsno -eq 0 ];	
		then	
			getProjectName
			getProjectType						
		elif [ $argsno -eq 1 ]; then		
			location=$PWD
			projectname="$@"			
			getProjectType					
		elif [ $argsno -eq 2 ]; then
			projecttype=$1
			shift 
			projectname="$@"			
		else 
			echo "Invalid OPTIONS"
		fi
		
		projectfolder="$today-$projectname"
		
		# echo "INFO [ N: $projectname | T: $projecttype | L:$location ]"
		
						
		# display info		
		printf "\n%s" "PROJECT INFO"
		printf "\n%s" "name     : $projectname"
		printf "\n%s" "type     : $projecttype"		
		printf "\n%s" "folder   : $projectfolder"
		echo 
				
		
		# return
			
		##################
		# repo creation
		##################
		
		# get inside the repo		
		mkdir -p "$projectfolder" && cd "$projectfolder"
		
		# add readme		
		t markdown add H1 "ReadMe" "readme.md"
	
		# add gitignore
		g repo add gitignore windows > /dev/null 2>&1
		g repo add gitignore $projecttype > /dev/null 2>&1
	
		# intialize repo
		g repo create "$PWD" > /dev/null 2>&1
		echo 
		echo "SUCCESS : Project repo created successfully"
		
		# add to inbox.txt
		local projectfolderpath=$(cygpath -d "$PWD")		
		echo "$longdate add \"$projectfolderpath\" to todo project file" >>$(cygpath -u "D:\Dropbox\do\inbox.txt")
		start "" "D:\Dropbox\do\inbox.txt" > /dev/null 2>&1 || cygstart "D:\Dropbox\do\inbox.txt"  > /dev/null 2>&1	

		
		# get out of repo
		
		# TODO: ask and open a new terminal on folder
		# TODO: ask and open explorer on folder
		
		cd ..
				
	}

	usage(){
		
		echo 
        echo "project OPTIONS"      
        echo " helper script to managing do folder"   
        echo 
        echo "OPTIONS are..."
        echo 				
		echo "create [type] [name]"		
		echo "create [name]"
		echo "create"
		echo 
		echo "e.g. project create \"Python\" \"python workouts\""
		echo "e.g. project create \"c\" \"c programs\""
		echo 
		
	}
	
	option=$1
	shift
	
	# test the script
	# echo $filename $option

	pushd "D:\Dropbox\project" > /dev/null 2>&1
	case "$option" in		
		create) create "$@";;
		help|usage)	usage ;;
	esac	
	popd  > /dev/null 2>&1
	
}