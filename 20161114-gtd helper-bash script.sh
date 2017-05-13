#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html

# read config file
# configfile=$1

# D:\Dropbox\do\reference\20161120-gtd script config file.cfg
configfile=$(cygpath -u "$1")
CFG_FILE="$configfile"
[ -r "$CFG_FILE" ] || echo "$1" "fatal error: cannot read configuration file $CFG_FILE"
. "$CFG_FILE"
# end of read config file

alias gtd=_gtd_main_

# helper functions

# run action from csv file
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
			echo "  ${TODOS[i]}"
		done )		
		
		# pause			
		read -n1 -r -p "" key				
		# clear
	done	

}


_gtd_main_(){
	
	# generic routine	
	
	usage(){
	
		echo
		echo "GTD Helper"
		echo "========"		
		echo "		  "
		echo 
        echo "OPTIONS are..."
        echo 
		echo "action (start|end) (day|week|month|year)"		
		echo "analyse_todo_projects"		
		echo "generate_and_view_reports"
		echo "pritorize_todo_projects"
		echo "reward_yourself"
		echo "process_inbox_folders"		
		
	}
	
	inbox(){
	
		echo
		
	}
	
	review(){
	
		echo 
	}
	
	reference(){
	
		echo
	}
	
	support(){
	
		echo
		
	}
	
	action(){
	
		# Get action
		occasion=$1
		shift

		# Get option
		detail=$1;  
		shift
		
		if [[ -z "$detail" ]]; then
			echo "workflow error : few arguments"
			exit
		fi
		
		# Validate the input options
		re="^(day|week|month|year)$"
		
		if [[ "$occasion"=~$re ]]; then
			case $action in
			'start')        								                  
				case "$detail" in
					day)						
						# D:\Dropbox\do\reference\20161120-life gtd day start action support file.csv
						run_actions_from_csv_file "$GTD_ACTION_FOR_DAY_START_FILE"
					;;
					week)
						# D:\Dropbox\do\reference\20161130-life gtd week action support file.csv
						run_actions_from_csv_file "$GTD_ACTION_FOR_WEEK_START_FILE"
					;;                  
					month)
						# D:\Dropbox\do\reference\20170101-life gtd month action support file.csv
						run_actions_from_csv_file "$GTD_ACTION_FOR_MONTH_START_FILE"	
					;;
					year)
						# D:\Dropbox\do\reference\20170101-life gtd year action support file.csv
						run_actions_from_csv_file "$GTD_ACTION_FOR_YEAR_START_FILE"
	
					;;
				esac
				;;
			'end')
				case "$detail" in
					day)
						# D:\Dropbox\do\reference\20161120-life gtd day end action support file.csv
						run_actions_from_csv_file "$GTD_ACTION_FOR_DAY_END_FILE"
						;;
					week)
						# D:\Dropbox\do\reference\20161114-life gtd week review support file.csv
						run_actions_from_csv_file "$GTD_ACTION_FOR_WEEK_END_FILE"

						;;                  
					month)
						# D:\Dropbox\do\reference\20170101-life gtd month review support file.csv
						run_actions_from_csv_file "$GTD_ACTION_FOR_MONTH_END_FILE"
	
						;;
					year)						
						# D:\Dropbox\do\reference\20170101-life gtd year review support file.csv
						run_actions_from_csv_file "$GTD_ACTION_FOR_YEAR_END_FILE"
						;;
				esac
				;;
			esac
		else
			echo "error: unrecognised option \"$option\"."
			
		fi
		
	}
	
	project(){
	
		echo
	}
	
	# TODO: [] organize the functions
	
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
		cygstart "$scriptfolder/$(cygpath -u "${pgmpath}")" $GTD_PROJECT_LIST_ACTIVE
		
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
		action) action $term;;
		review) review $term;;
		analyse_todo_projects) analyse_todo_projects;;		
		generate_and_view_reports) generate_and_view_reports;;
		pritorize_todo_projects) pritorize_todo_projects;;
		reward_yourself) reward_yourself;;		
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