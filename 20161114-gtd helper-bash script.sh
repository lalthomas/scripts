#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html

# read config file
# configfile=$1

# D:\do\reference\20161120-gtd script config file.cfg
configfile=$(cygpath -u "$1")
CFG_FILE="$configfile"
[ -r "$CFG_FILE" ] || echo "$1" "fatal error: cannot read configuration file $CFG_FILE"
. "$CFG_FILE"
# end of read config file

alias gtd=_gtd_main_

# helper functions


# TODO add ordering of todos
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
		
	gtd_inbox(){
		
		clean(){
			:			
		}
		
		: 
		
		# cygwin","[] run inbox cleanup script for course"
		# cygwin","[] run inbox cleanup script for doc"
		# cygwin","[] run inbox cleanup script for film"
		# cygwin","[] run inbox cleanup script for lab"
		# cygwin","[] run inbox cleanup script for music"
		# cygwin","[] run inbox cleanup script for picture"
		# cygwin","[] run inbox cleanup script for resource"
		# cygwin","[] run inbox cleanup script for tool"
		# cygwin","[] run inbox cleanup script for torrent"
		# cygwin","[] run inbox cleanup script for video"
		
	}
	
	review(){
			
		pritorize(){
		
			# TODO: 
			echo
		
		}
		
		reports(){
		
			# TODO :ensure that each that each project have atleast kick start action
			
			todoshactiononterminal(){
								
				info=$1
				operation=$2				
				b terminal "echo $info; echo ; sh \"d://do/todo.sh\" -a -N -f -+ $operation"
				
			}
			
			type=$1
			
			case  $type in
			
				todotxtreport) 
					t report; 
					openFile "$doRootPath/report.txt"					
				;;
			
				birdseye)
					
					pushd $docRootPath
					t birdseye > $docRootPath/$today"-todo birdseye report for week"-$weekCount.md
					openFile $docRootPath/$today"-todo birdseye report for week"-$weekCount.md      
					popd	
				;;					
				
				donecount)       todoshactiononterminal "Graph of Tasks Done in Previous Week" "graph";;			
				contextview)     todoshactiononterminal "Context View" "contextview" ;;
				goals)           todoshactiononterminal "Goals View" "goals" ;;
				pastview)        todoshactiononterminal "Tasks done on past week" "xp 7" ;;
				projectview)     todoshactiononterminal "Todo Items Group by Project" "view project" ;;
				contextview2)    todoshactiononterminal "Show todo items group by context" "view context" ;;
				todowithoutdate) todoshactiononterminal "Show Todo Items With No Date" "view nodate" ;;
				dateview)		 todoshactiononterminal "Show Todo Items group by date" "view date" ;;	
				pastweek)		 todoshactiononterminal "Show Todo items from past week" "view -1weeks" ;;
				treeview)		 todoshactiononterminal "Design Tree Of Tasks" "tree"
			
			esac	
		}
	
		
	}
	
	reference(){
	
		echo
	}
	
	support(){
	
		echo
		
	}
	
	action(){
	
		echo $@
		
		# Get action
		action=$1
		shift

		# Get option
		occasion=$1;  
		shift
		
		if [[ -z "$action" ]]; then
			echo "workflow error : few arguments"
			return
		fi
		
		if [[ -z "$occasion" ]]; then
			echo "workflow error : few arguments"
			return
		fi
		
		# Validate the input option
		re="^(start|end)$"
		if [[ ! "$action"=~$re ]]; then		
			echo "error: unrecognised option \"$action\"."			
			return
		fi
		
		# Validate the input options
		re="^(day|week|month|year)$"
		if [[ ! "$occasion"=~$re ]]; then		
			echo "error: unrecognised option \"$occasion\"."			
			return
		fi
		
		case $action in
		'start')        								                  
			case "$occasion" in
				day)						
					# D:\do\reference\20161120-life gtd day start action support file.csv
					run_actions_from_csv_file "$GTD_ACTION_FOR_DAY_START_FILE"
				;;
				week)
					# D:\do\reference\20161130-life gtd week action support file.csv
					run_actions_from_csv_file "$GTD_ACTION_FOR_WEEK_START_FILE"
				;;                  
				month)
					# D:\do\reference\20170101-life gtd month action support file.csv
					run_actions_from_csv_file "$GTD_ACTION_FOR_MONTH_START_FILE"	
				;;
				year)
					# D:\do\reference\20170101-life gtd year action support file.csv
					run_actions_from_csv_file "$GTD_ACTION_FOR_YEAR_START_FILE"

				;;
			esac
			;;
		'end')
			case "$occasion" in
				day)
					# D:\do\reference\20161120-life gtd day end action support file.csv
					run_actions_from_csv_file "$GTD_ACTION_FOR_DAY_END_FILE"
					;;
				week)
					# D:\do\reference\20161114-life gtd week review support file.csv
					run_actions_from_csv_file "$GTD_ACTION_FOR_WEEK_END_FILE"

					;;                  
				month)
					# D:\do\reference\20170101-life gtd month review support file.csv
					run_actions_from_csv_file "$GTD_ACTION_FOR_MONTH_END_FILE"

					;;
				year)						
					# D:\do\reference\20170101-life gtd year review support file.csv
					run_actions_from_csv_file "$GTD_ACTION_FOR_YEAR_END_FILE"
					;;
			esac
			;;
		esac				
	}
	
	project(){
	
		echo
	}
	
	# TODO: [] organize the functions
		
	reward_yourself(){
		
		# TODO: 
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
	options="$@";  
	shift


	# echo action: $action option: $option term: $term

	# Validate the input options
	re="^(help|review|action)$"
	if [[ "$action"=~$re ]]; then
		case $action in
		action) action $options;;
		review) review $options;;
		analyse_todo_projects) analyse_todo_projects;;		
		generate_and_view_reports) generate_and_view_reports;;		
		reward_yourself) reward_yourself;;		
		open_active_projects) open_active_projects;;				
		usage) usage;;
		*)
		echo "invalid option"
		;;						    
		esac
	else
		echo "gtd error: unrecognized option \"$option\"."
		echo "try \" view help\" to get more information."
	fi
}