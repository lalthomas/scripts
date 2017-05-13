#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html


alias gsd='sh "$toolsRootPath/20161026-get-shit-done/get-shit-done.sh"'
alias workflow=_workflow_main_

case "$OSTYPE" in

	msys*)
		configfile=$(echo "/$1" | sed -e 's/\\/\//g' -e 's/://')
		;;
		
	cygwin*)
		# read config file
		configfile=$(cygpath -u "$1")
		;;    		
		
esac

CFG_FILE="$configfile"

[ -r "$CFG_FILE" ] || echo "$1" "fatal error: cannot read configuration file $CFG_FILE"
. "$CFG_FILE"
# end of read config file

usage() {   
	
	echo
	echo "workflow"
	echo "========"
    echo "    routines actions"
    echo "    start day|week|month|year"
    echo "    end day|week|month|year"      
}

# generic routine

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

startDay(){     
    
	git_commit(){
	
		# push path
		pushd "D:\Dropbox\do" > /dev/null 2>&1
		
		# git commit log file
		echo
		echo "# log file"
		echo		
		git add log.txt > /dev/null 2>&1
		git	commit -m"add log entry" > /dev/null 2>&1		
		echo "  [x] changes to $doLogPath commited"							
		
		# git commit project list file
		echo
		echo "# project list file"
		echo		
		git add "reference/20161001-project list-dev gtd.txt" > /dev/null 2>&1
		git	commit -m"update project list" > /dev/null 2>&1		
		echo "  [x] changes to 20161001-project list-dev gtd.txt commited"
						
		# pop path
		popd > /dev/null 2>&1
		
	}
	
	echo 
    echo "welcome to start day program"
    echo 
	echo " here are list of things happening under this program"
	echo 
	echo "  - add computer checkin entry to $doLogPath"
	echo "  - daily action list with context invocation"
	echo "  - create a daily journal file with scheduled tasks"	
	echo "  - prompt for blocking distracting websites"
	echo "  - prompt for opening mail"
	echo "  - prompt for opening todo.txt gui app"	
    echo "  - commit changes in log file"
	echo "  - end of program"
    echo            
	
	echo
	echo "daily actions"
	echo "============="
	echo
	
	# log the workflow start
	echo
	echo "# log file"
	echo
	t log add "check-in into personal computer"
	echo "  [x] log entry added"
	echo
	
	# run action from csv file
	# D:\Dropbox\do\reference\20161120-life gtd day start action support file.csv
	run_actions_from_csv_file "$WORKFLOW_ACTION_FOR_DAY_START_FILE"			
	
	# create journal
	t journal create
	echo
	echo "# journal file"
	echo
	echo "  [x] journal file created and opened"	
	echo		
	
	echo
	read -p "do you want start work by blocking distractions : " opted
	if [ $opted == "y" ]; then
		# block time wasting websites
		echo
		gsd work		
	else
		echo
		read -p "do you want check mail : " opted
		if [ $opted == "y" ]; then
			thunderbird="C:\PortableApps.com\PortableApps\ThunderbirdPortable\ThunderbirdPortable.exe"
			cygstart "$thunderbird"
		fi			
	fi
	
	echo
	read -p "do you want open todo.txt gui app: " opted
		if [ $opted == "y" ]; then
			todoapp="C:\Program Files (x86)\Hughesoft\todotxt.net\todotxt.exe"
			# todoapp="C:\Program Files (x86)\QTodoTxt\qtodotxt.exe"
			cygstart "$todoapp"
	fi	
		
	# start actions for the week
	echo
	echo "# computer/dropbox/lab"	
	echo
	echo " [x] open active projects for action"
	echo 
	
	# commit the changes
	git_commit
	
	# open active projects
	gtd open_active_projects	
	
	echo
	echo "--------------------"
	echo "Have a great day ..."
	echo "--------------------"
	echo
}

endDay(){
	
	git_commit(){
	
		pushd "D:\Dropbox\do" > /dev/null 2>&1
	
		# commit the changes
		echo
		echo "commiting changes"
		echo	

		# TODO: commit the calendar.txt file
		# TODO: commit the todo.txt file
		
		# git commit log file		
		echo
		echo "# log file"
		echo
		git add log.txt > /dev/null 2>&1
		git commit -m"add log entry" > /dev/null 2>&1
		popd > /dev/null 2>&1	
		
		
		# git commit lesson file
		echo
		echo "# lesson file"
		echo		
		git add lessons.txt > /dev/null 2>&1
		git	commit -m"add lesson entry" > /dev/null 2>&1		
		echo "  [x] changes to lessons file commited"
		
	}
	
	echo
	echo "  workflow end day"
    echo 
    echo "  - add check out time to $doLogPath file"
    echo "  - add done items from done.txt to journal file"
	echo "  - show a list to people having a special day on their life"
	echo "  - prompt for wishing people"
	echo "  - TODO: daily backup"	
    echo 	
	
	
	# unblock sites
	echo
	echo "Unblocking Sites"
	echo 
	gsd play
			
	# show a standup report
	echo
	echo "Done Report"
	echo 
	t xp 0
	
	# add gratitude
	echo
	read -p "do you want to add gratitude for the day [y|n] ? : " opted
	if [ $opted == "y" ]; then
		echo
		t journal add gratitude
	fi

	# add lessons
	echo
	read -p "do you want to add lessons of the day [y|n] ? : " opted
	if [ $opted == "y" ]; then
		t lesson 		
	fi
	
	
	# review
	echo
	echo "Day Review"
	echo
	
	# log items to journal
	t journal add add_todo_done_items
	
	# open journal
	t journal open
	
	# run action from csv file
	# D:\Dropbox\do\reference\20161120-life gtd day end action support file.csv
	run_actions_from_csv_file "$WORKFLOW_ACTION_FOR_DAY_END_FILE"
	
	
	# add day plan
	opted="n"
	echo	
	read -p "do you want to add day plan for tomorrow to todo.txt [y|n] ? : " opted
	if [ $opted == "y" ]; then
		t plan pick tomorrow
	fi
	
	
	opted="n"
	read -p "have you wished your friends ? : " opted
	if [ $opted == "n" ]; then	
		echo 
		echo "List of People to wish"	
		echo =========================
		echo 
		wish list
		echo		
		opted="n"	
		read -p "enter y to wish now : " opted
		if [ $opted == "y" ]; then
			wish email
			t log add "wish friends happy birthday"	
		fi	
	else		
		t log add "wish friends happy birthday"			
	fi
		
	echo  
	echo "List of People having birthday tomorrow"	
	echo ========================================
	echo 
	wish list tomorrow
	echo
	
	# add checkout log entry to log
	t log add "check-out from personal computer"
	
	# commit changes
	git_commit	
		
	echo
	echo "---------------------------"
	echo "See you again, take care..."
	echo "---------------------------"
	echo
		
	
}

startWeek(){
    
	# [ ] check the weather prediction for building prior knowledge
	# [ ] check the 3 days newspaper
	# [ ] read through dont.txt todo items
	# [ ] read through dream.txt todo items
	# [ ] add next actions for todo items in outline.txt
	# [ ] move todo from waiting.txt if ok 
	# [ ] schedule todo from open projects to todo.txt
	# [ ] add tasks for the week to todo.txt from calendar.txt
	# [ ] take sticky todo from gtd file and add to plan paper
	# [ ] prioritize important tasks
	
	echo 
    echo "  workflow start week"
    echo 
    echo "   ! run on monday or pass current week's monday as argument"
    echo "   - schedule todo weekly tasks"  
    echo 
	
    # as per the current implementation run either monday
    # or as pass current week monday as argument otherwise 
    # the command will produce undesired output
    
	# add todos for the week to todo.txt
	echo
	echo "warning : confirm the following question only if today is monday"
	echo "          otherwise run the command with arugment with monday date (YYYYY-MM-DD)"
	echo 
	read -p "do you want to add todos of the week to todo.txt [y|n] ? : " opted	
	if [ $opted == "y" ]; then				
		# add weekly todos
		[ $# -eq 0 ] &&  t plan week || t plan week "$1"			
		# commit the changes
		echo
		echo "commiting changes"
		echo	
		pushd "D:\Dropbox\do" > /dev/null 2>&1
		git add todo.txt
		git commit -m"add weekly todos to todo.txt" 
		popd > /dev/null 2>&1				
	fi	    
	
	# weekly actions
	echo
	echo "weekly actions"
	echo
	# D:\Dropbox\do\reference\20161130-life gtd week action support file.csv
	run_actions_from_csv_file "$WORKFLOW_ACTION_FOR_WEEK_START_FILE"
			
	echo 
	echo "--------------------------"
	echo "Have a great week ahead..."
	echo "--------------------------"
	echo 
	
}

endWeek(){
			
	echo
	echo "GTD Weekly Review Walk Through"
	echo						
	echo "- analyse todo projects"
	echo "- pritorize todo projects"				
	echo "- generate and view reports"
	echo "- commit changes"
	echo "- add lessons"
	echo "- add gratitude"
	echo "- reward yourself"
	echo

	read -p "do you want start weekly actions [y|n] ? : " opted
	if [ $opted == "y" ]; then
		# review file is read from config file
		# D:\Dropbox\do\reference\20161114-life gtd week review support file.csv
		run_actions_from_csv_file "$WORKFLOW_ACTION_FOR_WEEK_END_FILE"
	fi
	
	
	echo
	read -p "do you want to review every todo project [y|n] ? : " opted
	if [ $opted == "y" ]; then	
		# TODO: create doc with prepopulated list of todo projects for adding review notes
		echo
		echo "# todo.txt project"	
		echo
		echo " [] copy todo item numbers of all done and invalid items"
		echo " [] create and save a note of review points"
		echo 
		dofolder view_project_todos	
		echo
		echo "# todo.txt project"	
		echo		
		echo " [] mark the done and invalid todos"
		echo		
	fi
	
	
	
	echo
	read -p "do you want to update todo files [y|n] ? : " opted
	if [ $opted == "y" ]; then
		# update do files
		dofolder clean_todo_files
		dofolder update_inboxtxt_file
	fi
	
	echo
	read -p "do you want to analyse todo projects [y|n] ? : " opted
	if [ $opted == "y" ]; then
		gtd analyse_todo_projects
	fi
		
	echo
	read -p "do you want to pritorize todo projects [y|n] ? : " opted
	if [ $opted == "y" ]; then
		gtd pritorize_todo_projects
	fi
	
	echo
	read -p "do you want to generate and view reports [y|n] ? : " opted
	if [ $opted == "y" ]; then
		gtd generate_and_view_reports
	fi
				
	echo
	read -p "do you want to reward yourself [y|n] ? : " opted
	if [ $opted == "y" ]; then
		gtd reward_yourself
	fi			
	
	echo
	read -p "do you want to commit changes [y|n] ? : " opted
	if [ $opted == "y" ]; then
		echo
		# TODO: commit the changes
	fi
	
	echo 
	echo "---------------------------"
	echo "See you again, take care..."
	echo "---------------------------"
	echo 

}

startMonth(){
    
	echo "  workflow start month"
    echo 
    echo "   - clean todo"
    echo "   - invalidate monthly todo items"
    echo "   - schedule todo monthly tasks"
    echo "   - commit do"       
    echo 
	
	# [ ] check todos that can be scheduled 
	# [ ] prepare the list of recurring tasks for the month to calendar.txt
	
	# add recurring todos to calendar.txt	
	
	opted="n"
	echo	
	read -p "do you want to add todos for the month [y|n] ? : " opted
	if [ $opted == "y" ]; then
		t plan day month
	fi
	
	
	# [ ] move todo related to current month from tickler.txt to todo.txt 
	# [ ] brainstorm for open todo projects
	# [ ] prepare next actions for unclear tasks 
	# [ ] review projects
	# [ ] review waiting
	# [ ] clean todo.txt
	# [ ] update contexts.md
	# [ ] update projects.md
	
	t file open "$doRootPath/inbox.md"
	t file open "$doRootPath/outline.md"
	t file open "$doRootPath/calendar.txt"
	t file open "$doRootPath/projects.md"
	t file open "$doRootPath/contexts.md"
	t file open "$doRootPath/waiting.txt"	
    # t plan month invalidate && \
    # t plan month && 
    # commitdo
	
	# run action from csv file
	# D:\Dropbox\do\reference\20170101-life gtd month action support file.csv
	run_actions_from_csv_file "$WORKFLOW_ACTION_FOR_MONTH_START_FILE"	
	
	echo
	echo "----------------------"
	echo "Have a great month ..."
	echo "----------------------"
	echo
	
}

endMonth(){
 
	echo
	echo "GTD Monthly Review Walk Through"
	echo
	echo "- process inbox folders"
	echo		 
	echo
	
	# run action from csv file
	run_actions_from_csv_file "$WORKFLOW_ACTION_FOR_MONTH_END_FILE"
	
	# [ ] move done.txt todo items to project files
	# [ ] move invalid.txt todo items to project files
	# [ ] update the status of main projects
	# [ ] commit changes to do folder
	# [ ] add birdseye report for todo items
	# [ ] go through journal notes of the month
	
	read -p "do you want to process inbox folders [y|n] ? : " opted
	if [ $opted == "y" ]; then
		run_actions_from_csv_file "$INBOX_FOLDER_LIST"
	fi
	
	
	echo 
	echo "---------------------------"
	echo "See you again, take care..."
	echo "---------------------------"
	echo 
	
}

startYear(){

	echo 
    echo "  workflow start year"    
    echo 
    echo "   - invalidate yearly todo items"
    echo "   - schedule todo yearly tasks"  
    echo "   - commit do"
    echo        
    
	# run action from csv file
	# D:\Dropbox\do\reference\20170101-life gtd year action support file.csv
	run_actions_from_csv_file "$WORKFLOW_ACTION_FOR_YEAR_START_FILE"
	
	#doarchive
    t plan year invalidate && \
    t plan year && \
    commitdo
	
	echo
	echo "----------------------"
	echo "Have a great year ..."
	echo "----------------------"
	echo
}

endYear(){
	
	
	# run action from csv file
	# D:\Dropbox\do\reference\20170101-life gtd year review support file.csv
	run_actions_from_csv_file "$WORKFLOW_ACTION_FOR_YEAR_END_FILE"
	
	echo 
	echo "---------------------------"
	echo "See you again, take care..."
	echo "---------------------------"
	echo
 
}

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
    if [[ "$action"=~$re ]]; then
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
                        startWeek "$@"
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
        echo "workflow error: unrecognised option \"$option\"."
        echo "try \" view help\" to get more information."
    fi
}