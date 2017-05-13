#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html

# read config file
# configfile=$1
configfile=$(cygpath -u "$1")
CFG_FILE="$configfile"
[ -r "$CFG_FILE" ] || echo "$1" "fatal error: cannot read configuration file $CFG_FILE"
. "$CFG_FILE"
# end of read config file

alias gtd=_review_main_

_review_main_(){
	
	usage(){
		echo
		echo "GTD Helper"
		echo "========"		
		echo "		  "
		echo 
        echo "OPTIONS are..."
        echo 					
		echo "update_do_files"
		echo "add_gratitude"		
		echo "analyse_todo_projects"
		echo "commit_changes"
		echo "generate_and_view_reports"
		echo "pritorize_todo_projects"
		echo "reward_yourself"
		echo "process_inbox_folders"
		echo "take_action"
	}
	
	
				
	analyse_todo_projects(){
		
		# TODO :ensure that each that each project have atleast kick start action
		
		echo
		
		# generate a report of tasks
		echo "archive todo.txt & add report" 			
		echo "-----------------------------"
		read -n1 -r -p "Press any key to continue ..." key
		t report			
		# pause			
		clear
					
					
		# generate a graph of tasks done
		echo "generate a graph of tasks done"
		echo "-----------------------------"			
		t graph
		# pause		
		read -n1 -r -p "Press any key to continue ..." key
		clear
					
		
		# view todo by context
		t contextview
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear
		
		# view the goals file
		t goals
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear
					
		# tasks done on past week
		t xp 7
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear
				
		# Show todo items group by project
		t view project
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear
					
		# Show todo items group by context
		t view context
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear
		
		# show todo items with no date
		t view nodate
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear			
		
		# Show todo items group by date
		t view date
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear			
		  
		# Show todo items group by date without date
		t view nodate
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear
		
		
		# show todo items from past week
		todo.sh view -1weeks
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear
		
		
		# design tree of tasks
		t tree
		# pause
		read -n1 -r -p "Press any key to continue ..." key
		clear
					
		
	}	
		
	pritorize_todo_projects(){
		echo
	}
	
	generate_and_view_reports(){
		
		dofolder add_todo_report
		dofolder add_birdseye_report
		
	}
	
	reward_yourself(){
		echo
	}	
					
	open_active_projects(){
		
		# open active project files
		pgmpath="20150823-open folders from file list-dos script batch script.bat"		
		cygstart "$scriptfolder/$(cygpath -u "${pgmpath}")" $GTD_ACTIVE_PROJECT_LIST
		
	}
		
	
	# Get action
	action=$1
	shift

	# Get option
	option=$1;  
	shift

	# Get rest of them
	term="$@"

	# echo action: $action option: $option term: $term

	# Validate the input options
	re="^(help|review|action)$"
	if [[ "$action"=~$re ]]; then
		case $action in						
		analyse_todo_projects) analyse_todo_projects;;		
		generate_and_view_reports) generate_and_view_reports;;
		pritorize_todo_projects) pritorize_todo_projects;;
		reward_yourself) reward_yourself;;
		process_inbox_folders) process_inbox_folders;;
		open_active_projects) open_active_projects;;				
		*)
		echo "invalid option"
		;;						    
		esac
	else
		echo "gtd error: unrecognized option \"$option\"."
		echo "try \" view help\" to get more information."
	fi
}