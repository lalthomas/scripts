#!/bin/bash -x

# Filename : 20161108-action folder-bash script.sh
# Author : Lal Thomas 
# Date : 2016-11-08
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables

currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias actionfolder=_action_main_

_action_main_(){

	createProjectRepository(){

		local projecttype=$1
		local location=$2
		local projectname=$3	

		if [ $# -eq 0 ];	
		then	
		projecttype='os'	
		location=$PWD
		read -p "enter project name and press [enter]: " projectname
		else   
		if [ $# -eq 1 ];
			then	
			  location=$PWD
			  read -p "enter project name and press [enter]: " projectname
			else
				if [ $# -eq 2 ]; 				
				then
				  read -p "enter project name and press [enter]: " projectname							 								
				fi						
		fi	   		   		
		fi

		mkdir -p "$location/$today-$projectname"		
		local projectpath="$location/$today-$projectname"
		createMarkdownHeading "1" "ReadMe" "$projectpath/readme.md"

		case "$projecttype" in
		os*)	    
			creategitignore 'osx,windows'>"$projectpath/.gitignore"
			;;
		xcode*) 
			creategitignore 'objective-c,osx'>"$projectpath/.gitignore" 		
			;; 
		momemtics*)		
			echo "momentics gitignore not made"
		  ;;
		*) 
			echo "unknown: $OSTYPE" 
		 ;;
		esac

		createRepo "$projectpath" >/dev/null
		echo "project repo created successfully"

	}

	createArticleRepository(){

		read -p "enter article name and press [enter]: " articlename		
		mkdir -p "$1/$today-$articlename"	
		createMarkdownHeading "1" "$articlename" "$1/$today-$articlename/$articlename".md			
		open "$1/$today-$articlename/$articlename".md
		createRepo "$1/$today-$articlename" >/dev/null
		echo "article repo created successfully"		

	}

	usage(){
		
		echo 
        echo "dofolder OPTIONS"      
        echo " helper script to managing do folder"   
        echo 
        echo "OPTIONS are..."
        echo 		
		echo "createProjectRepository"
		echo "createArticleRepository"
		echo "createXcodeProject"
		
	}
	
	
	# test the script
	# echo $filename $ACTION

	case "$ACTION" in		
		createProjectRepository) createProjectRepository ;;
		createArticleRepository) createArticleRepository ;;		
		createXcodeProject) createProjectRepository 'xcode';;
		help|usage)	usage ;;		
	esac
	
}