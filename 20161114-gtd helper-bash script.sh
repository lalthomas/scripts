#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html

scriptfolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# read config file
# configfile=$1
configfile=$(cygpath -u "$1")
CFG_FILE="$configfile"
[ -r "$CFG_FILE" ] || echo "$1" "Fatal Error: Cannot read configuration file $CFG_FILE"
. "$CFG_FILE"
# end of read config file

alias gtd=_review_main_

_review_main_(){
	
	usage(){
		echo "GTD Helper"
		echo "========"		
		echo "		"
		echo "    review day|week|month|year"
		echo "    action"  
		echo 
		echo " working"
		echo " -------"
		echo 
		echo "  gtd review day"
		echo 				      
		echo "  gtd review week"
		echo 		
		echo "  gtd review month"
		echo 		
		echo "  gtd review year"
		echo 			
		echo "	gtd action"
		
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

		# for filename in "${files_unique[@]}"	
		for ((i = 0; i < ${#files_unique[@]}; i++))	
		do	
			## file path
			echo ${files_unique[i]}
			cygstart "${files_unique[i]}"			
						
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
				echo "${TODOS[i]}"
			done && echo -e "\n" )		
			
			# pause
			read -n1 -r -p "Press any key to continue..." key
			clear
		done	
	
	}
	
	reviewDay(){     
		
		echo
	}

	reviewWeek(){

		build_prior_knoweledge(){
					
			# review actions on computer contexts
			# 	review evernote notes			
			# 	review do files ( context.md, done.txt, dreams.md, inbox.md, projects.md, waiting.md, wishlist.md, projects )			
			# 	review bookmarks file 			
			# 	review reference files ( bookmarks doc, inbox folder list , review horizon doc, life lessons doc, active project lists, trigger list, checklists and procedures files )
			# 	review recent newspapers
			# 	review calendar
			# 	review mail			
			
			# review file is read from config file
			run_actions_from_csv_file "$REVIEW_FILE"
			
		}		
		add_gratitude(){
			echo
		}
		add_lessons(){
			echo
		}
		analyse_todo_projects(){
			#ensure that each that each project have atleast kick start action
			echo
		}
		commit_changes(){
			echo
		}
		generate_and_view_reports(){
			echo
		}
		pritorize_todo_projects(){
			echo
		}
		reward_yourself(){
			echo
		}	
		
		echo "GTD Weekly Review Walk Through"
		echo "- build prior knowledge"		
		echo "- analyse todo projects"
		echo "- pritorize todo projects"				
		echo "- generate and view reports"
		echo "- commit changes"
		echo "- add lessons"
		echo "- add gratitude"
		echo "- reward yourself"
				
			
		read -p "do you want to build prior knowledge [y|n] ? : " opted
		if [ $opted == "y" ]; then
			build_prior_knoweledge
		fi
		
		read -p "do you want to analyse todo projects [y|n] ? : " opted
		if [ $opted == "y" ]; then
			analyse_todo_projects
		fi
				
		read -p "do you want to pritorize todo projects [y|n] ? : " opted
		if [ $opted == "y" ]; then
			pritorize_todo_projects
		fi
		
		read -p "do you want to generate and view reports [y|n] ? : " opted
		if [ $opted == "y" ]; then
			generate_and_view_reports
		fi
				
		read -p "do you want to add lessons of the week [y|n] ? : " opted
		if [ $opted == "y" ]; then
			add_lessons
		fi
		
		read -p "do you want to reward yourself [y|n] ? : " opted
		if [ $opted == "y" ]; then
			reward_yourself
		fi
		
		read -p "do you want to add gratitude [y|n] ? : " opted
		if [ $opted == "y" ]; then
			add_gratitude
		fi
		
		read -p "do you want to commit changes [y|n] ? : " opted
		if [ $opted == "y" ]; then
			commit_changes
		fi
				
	}

	reviewMonth(){
		echo
	}

	reviewYear(){
		echo
	}

	action(){
	
		# action file is read from config file	
		run_actions_from_csv_file "$ACTION_FILE"
		
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
		'help')
			usage
			;;
		'review')
			if [[ -z "$option" ]]; then
               echo "gtd error : few arguments"
               #adddonUsage
            else                
				case "$option" in
                    'day')
                        reviewDay
                        ;;
                    'week')
						reviewWeek
                        ;;                  
                    'month')
                        reviewMonth
                        ;;
                    'year')
                        reviewYear
                        ;;
				esac
            fi 			
			;;
		'action')			
			action
			;;
		*)
			echo "invalid option"
			;;						    
		esac
	else
		echo "gtd error: unrecognized option \"$option\"."
		echo "try \" view help\" to get more information."
	fi
}