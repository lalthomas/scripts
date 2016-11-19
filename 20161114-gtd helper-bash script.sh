#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html

alias review=_review_main_
datafile=$1

_review_main_(){
	
	run_actions_from_csv_file(){
	
		actionfile=$1
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
		done < "$actionfile" 
				
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
			grep -e "$safe_replacement" "$actionfile" | ( counter=1; while read -r line;
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
			# 	review do files ( context.md, done.txt, dreams.md, inbox.md, projects.md, wishlist.md, projects )			
			# 	review bookmarks file 			
			# 	review reference files ( bookmarks doc, inbox folder list , review horizon doc, life lessons doc, active project lists, trigger list, checklists and procedures files )
			# 	review recent newspapers
			# 	review calendar
			# 	review mail			
			
			run_actions_from_csv_file "$datafile"
			
			
			
			
		}	
	
		pritorize_todo_projects(){
			echo
		}
		
		generate_and_view_reports(){
			echo
		}
		
		commit_changes(){
		
			echo
		}
		
		echo "GTD Weekly Review Walk Through"
		echo "- build prior knowledge"
		echo "- pritorize todo projects"				
		echo "- generate and view reports"
		echo "- commit changes"
		echo "- add lessons"
		echo "- reward yourself"		
		echo "- analyse todo projects"		
			
		read -p "do you want to build prior knowledge [y|n] ? : " opted
		if [ $opted == "y" ]; then
		build_prior_knoweledge
		fi
		
		read -p "do you want to pritorize todo projects [y|n] ? : " opted
		if [ $opted == "y" ]; then
		pritorize_todo_projects
		fi
		
		read -p "do you want to generate and view reports [y|n] ? : " opted
		if [ $opted == "y" ]; then
		generate_and_view_reports
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
	re="^(help|review)$"
	if [[ "$action"=~$re ]]; then
		case $action in
		'help')
			usage
			;;
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
			*)
			echo "invalid option"
			;;						    
		esac
	else
		echo "review error: unrecognized option \"$option\"."
		echo "try \" view help\" to get more information."
	fi
}