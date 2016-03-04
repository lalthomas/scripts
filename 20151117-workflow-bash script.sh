#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html



function usage() {    
    echo "    routines actions"
	echo "    start day|week|month|year"
	echo "    end day|week|month|year"	
	echo 
	echo " working"
	echo " ======="
	echo 
	echo "  workflow start day"
	echo 
	echo "    - commit changes in $doRootPath folder"	
	echo "    - create a journal file with scheduled tasks"
	echo "    - add check in time to $doLogPath file"
	echo        
	echo "  workflow end day"
	echo 
	echo "   - add check out time to $doLogPath file"
	echo "   - add done items from done.txt to journal file"
	echo 
	echo "  workflow start week"
	echo 
	echo "   ! run on monday or pass current week's monday as argument"
	echo "   - schedule todo weekly tasks"	
	echo 
	echo "  workflow start month"
	echo 
	echo "   - clean todo"
	echo "   - invalidate monthly todo items"
	echo "   - schedule todo monthly tasks"
	echo "   - commit do"		
	echo 
	echo "  workflow start year"	
	echo 
	echo "   - invalidate yearly todo items"
	echo "   - schedule todo yearly tasks"	
	echo "   - commit do"
	echo 	
    echo ""    
}

startDay(){		
			
	t journal create "$docJournalFile"
	t log add "checked in"
	# commitdo
	
	# GTD
	t file open "$doRootPath/todo.txt"
	t file open "$doRootPath/inbox.txt"
}

endDay(){

	t log add "checked out"
	
}

startWeek(){
	
	# as per the current implementation run either monday
	# or as pass current week monday as argument otherwise 
	# the command will produce undesired output
	
	if [ $# -eq 0 ]; 
	then
		t plan week
	else
		t plan week "$1"		
	fi	
	commitdo	
}

endWeek(){

 echo

}

startMonth(){

    t doarchive
	t plan month invalidate && \
	t plan month && \
	commitdo
}

endMonth(){
 echo
}

startYear(){

    #doarchive
	t plan year invalidate && \
	t plan year && \
	commitdo
}

endYear(){

 echo

}

alias workflow=_workflow_main_

_workflow_main_(){

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
	re="^(help|start|end)$"
	if [[ "$action" =~ $re ]]; then
		case $action in
		'help')
			usage
			;;
		'start')        
			if [[ -z "$option" ]]; then
			   echo "workflow error : few arguments"
			   #adddonUsage
			else			  	
			   case "$option" in
					day)
						startDay
						;;
					week)
						startWeek
						;;					
					month)
						startMonth
						;;
					year)
						startYear
						;;
					esac
			fi				
			;;
		'end')
			if [[ -z "$option" ]]; then
			   echo "workflow error : few arguments"
			   #adddonUsage
			else			   	
			   case "$option" in
					day)
						endDay
						;;
					week)
						endWeek
						;;					
					month)
						endMonth
						;;
					year)
						endYear
						;;
					esac
			fi				
			;;
		esac
	else
		echo "workflow error: unrecognized option \"$option\"."
		echo "try \" view help\" to get more information."
	fi
}