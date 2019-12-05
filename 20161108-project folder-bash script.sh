#!/bin/bash -x

# Filename : 20161108-action folder-bash script.sh
# Author : Lal Thomas 
# Date : 2016-11-08
# © Lal Thomas (lal.thomas.mail@gmail.com)

alias project=_project_main_

_project_main_(){

	create(){
		
		local projectname=""
		
		argsno=$#
		# echo "#argument  : $argsno"
		
		if [ $argsno -eq 0 ];
		then
			read -p "enter project name and press [enter]: " projectname
		elif [ $argsno -gt 1 ]; then
			projectname="$@"
		else
			echo "Invalid OPTIONS"
		fi
		
		local projectfolder="$today-$projectname"
		# echo "INFO [ N: $projectname | L:$location ]"
		printf "\n%s" "creating \"$projectfolder\" project repository "
		# return
		# repo creation
		
		# get inside the repo
		mkdir -p "$projectfolder" && cd "$projectfolder"
		# echo $PWD
		gh repo create		
		gh repo add gitignore		
		t markdown add H1 "ReadMe" "readme.md" && gh repo stage file readme.md && gh repo commit "add readme.md"
		echo "SUCCESS : Project repo created successfully"
		
		# add gtd inbox
		gtd inbox add filepath "$PWD"
		
		# get out of repo
		# TODO: ask and open a new terminal on folder
		# TODO: ask and open explorer on folder
		cd ..
		
	}

	usage(){
		
		echo 
        echo "project OPTIONS"
        echo " helper script to managing project folder"
        echo 
        echo "OPTIONS are..."
        echo 	
		echo "create"
		echo "create [name]"
		echo 
		echo "e.g. project create \"python workouts\""
		echo "e.g. project create \"c programs\""
		echo 
		
	}
	
	option=$1
	shift
	
	# test the script
	# echo $filename $option

	pushd "D:\lab" > /dev/null 2>&1
	case "$option" in		
		create) create "$@";;
		help|usage)	usage ;;
	esac	
	popd  > /dev/null 2>&1
	
}