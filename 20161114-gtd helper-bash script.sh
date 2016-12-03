#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html

scriptfolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
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
		echo "run_actions_from_csv_file"
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
	
	run_actions_from_csv_file(){
				
		csvfile=$(cygpath -u "$1")		
		# a csv file with first column having the filename
		# and second column having with actions, is 
		# used here. File is displayed along with the actions
		# 
		pattern="."		
		counter=1		
		while read -r  line;
		do      							
			FILENAMES[$counter]=$(echo $line | awk -F, '{print $1}'| tr -d '"')
			counter=$((counter + 1))			
		done < "$csvfile" 
				
		# select unique elements 
		# IFS is set to accept new lines
		IFS=$'\n'
		files_unique=($(printf "%s\n" "${FILENAMES[@]}" | sort -u))
		unset IFS
				
		# echo number of results ${#files_unique[@]}				
		# for filename in "${files_unique[@]}"
		# do
		#	echo $filename
		# done				
		
		echo
		# for filename in "${files_unique[@]}"	
		for ((i = 0; i < ${#files_unique[@]}; i++))	
		do						
			# to disable run use `# ` in front of initial string
			if [[ ${files_unique[i]} = \#* ]]; then			
				# todo heading, remove #				
				echo ${files_unique[i]}							
			else
				## file path							
				echo "# ${files_unique[i]}"
				cygstart "${files_unique[i]}"				
			fi
			
			safe_replacement=$(printf '%s\n' "${files_unique[i]}" | sed 's/[\&/]/\\&/g')        			
						
			# loop through
			# innner process run first						
			grep -e "$safe_replacement" "$csvfile" | ( counter=1; while read -r line;
			do				
				TODOS[$counter]=$(echo $line | awk -F, '{print $2}' | tr -d '"')				
				counter=$((counter + 1))			
			done && for ((i = 0; i <= ${#TODOS[@]}; i++))	
			do	
				# file todos
				echo "	${TODOS[i]}"
			done )		
			
			# pause
			echo
			read -n1 -r -p "" key				
			# clear
		done	
	
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
		cygstart "$scriptfolder/$(cygpath -u "${pgmpath}")" $ACTIVE_PROJECT_LIST
		
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
		run_actions_from_csv_file) run_actions_from_csv_file "$option" ;;		
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