#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html

alias review=_review_main_
datafile=$1

_review_main_(){

	itemsMatchPattern(){		 				
		
		pattern="$1"							
		
		counter=1		
		while read -r  line;
		do      							
			FILENAMES[$counter]=$(echo $line | awk -F, '{print $1}'| tr -d '"')
			counter=$((counter + 1))			
		done < "$datafile" 
				
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
			echo ${files_unique[i]}
			safe_replacement=$(printf '%s\n' "${files_unique[i]}" | sed 's/[\&/]/\\&/g')        			
						
			# loop through
			# innner process run first						
			grep -e "$safe_replacement" "$datafile" | ( counter=1; while read -r line;
			do				
				TODOS[$counter]=$(echo $line | awk -F, '{print $2}' | tr -d '"')				
				counter=$((counter + 1))			
			done && for ((i = 0; i < ${#TODOS[@]}; i++))	
			do	
				echo  ${TODOS[i]}
			done && echo -e "\n" )				
		done	 						
	}		

	
	
	build_prior_knoweledge(){
		
		pattern="."
		# start google mail
		itemsMatchPattern "$pattern"
		
	}

	reviewDay(){     
		
		echo
	}

	reviewWeek(){

		build_prior_knoweledge
		# read -p "do you build prior knowledge : " opted
		# if [ $opted == "y" ]; then
			
		# fi
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