#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html


alias gsd='sh "$toolsRootPath/20161026-get-shit-done/get-shit-done.sh"'
alias workflow=_workflow_main_

scriptfolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# read config file
configfile=$(cygpath -u "$1")
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

startDay(){     
    
	echo 
    echo "  workflow start day"
    echo 
    echo "    - commit changes in $doRootPath folder"   
    echo "    - create a journal file with scheduled tasks"
    echo "    - add check in time to $doLogPath file"
    echo        
    
	
	# log the workflow start
	t log add "check-in into personal computer"	
		
	todoapp="C:\Program Files (x86)\Hughesoft\todotxt.net\todotxt.exe"
	thunderbird="D:\PortableApps.com\PortableApps\ThunderbirdPortable\ThunderbirdPortable.exe"
	opted="n"

	# create journal
	t journal create "$docJournalFile"		
	
	echo 
	echo "List of People to wish"	
	echo =========================
	echo 
	wish list
	echo
			
	read -p "enter y to wish now : " opted
	if [ $opted == "y" ]; then
		wish email
		t log add "wish friends happy birthday"	
	fi
	
	read -p "do you want start work by blocking distractions : " opted
	if [ $opted == "y" ]; then
		# block time wasting websites
		gsd work
	else	
		read -p "do you want check mail : " opted
		if [ $opted == "y" ]; then
			cygstart "$thunderbird"
		fi			
	fi
	
	read -p "do you want open todotxt app: " opted
		if [ $opted == "y" ]; then
			cygstart "$todoapp"
	fi
	
	echo
	echo "Daily Actions"
	echo	
	gtd run_actions_from_csv_file "$ACTION_FOR_DAY_FILE"
	
	echo
	echo "commiting changes"
	echo
	# commit the changes
	pushd "D:\Dropbox\action\20140310-do" > /dev/null 2>&1
    git add log.txt
	git	commit -m"add log entry"	
	popd > /dev/null 2>&1
	
	clear
	echo
	echo "Have a great day ..."
	echo
}

endDay(){
	
	echo "  workflow end day"
    echo 
    echo "   - add check out time to $doLogPath file"
    echo "   - add done items from done.txt to journal file"
	echo "    -  TODO: daily backup"	
    echo 
	
	echo 
	echo "List of People having birthday tomorrow"	
	echo ========================================
	echo 
	wish list tomorrow
	echo
	
	# unblock sites
	echo
	echo "Unblocking Sites"
	echo 
	gsd play
		
	# show a standup report
	echo
	echo "Standup Report"
	echo 
	t standup 	
	
	# add gratitude
	echo
	read -p "do you want to add gratitude for the day [y|n] ? : " opted
	if [ $opted == "y" ]; then
		echo
	fi

	# add lessons
	echo
	read -p "do you want to add lessons of the day [y|n] ? : " opted
	if [ $opted == "y" ]; then
		echo
	fi
	
	# review
	echo
	echo "Day Review"
	echo
	gtd run_actions_from_csv_file "$REVIEW_DAY_FILE"
	
	t log add "check-out from personal computer"
	
	# commit the changes
	echo
	echo "commiting changes"
	echo	
	pushd "D:\Dropbox\action\20140310-do" > /dev/null 2>&1
	git add log.txt
	git commit -m"add log entry" 
	popd > /dev/null 2>&1	
	
	clear
	echo
	echo "See you again, take care..."
	echo
		
}

startWeek(){
    
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
		pushd "D:\Dropbox\action\20140310-do" > /dev/null 2>&1
		git add todo.txt
		git commit -m"add weekly todos to todo.txt" 
		popd > /dev/null 2>&1				
	fi	    
	
	# weekly actions
	echo
	echo "weekly actions"
	echo
	gtd run_actions_from_csv_file "$ACTION_FOR_WEEK_FILE"
	
	# start actions for the week	
	echo
	echo "Open active projects for action"
	echo 
	gtd open_active_projects
		
	clear	
	echo 
	echo "Have a great week ahead..."
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

	read -p "do you want to weekly review [y|n] ? : " opted
	if [ $opted == "y" ]; then
		# review file is read from config file
		gtd run_actions_from_csv_file "$REVIEW_WEEK_FILE"
	fi
			
	echo
	read -p "do you want to update todo files [y|n] ? : " opted
	if [ $opted == "y" ]; then
		# update do files
		dofolder clean_todo_files
		dofolder update_inbox_file
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
	
	clear	
	echo 
	echo "See you again, take care..."
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
	
	t file open "$doRootPath/inbox.md"
	t file open "$doRootPath/outline.md"
	t file open "$doRootPath/calendar.txt"
	t file open "$doRootPath/projects.md"
	t file open "$doRootPath/contexts.md"
	t file open "$doRootPath/waiting.txt"	
    # t plan month invalidate && \
    # t plan month && 
    # commitdo
}

endMonth(){
 
	echo
	echo "GTD Monthly Review Walk Through"
	echo
	echo "- process inbox folders"
	echo		 
	echo
	read -p "do you want to process inbox folders [y|n] ? : " opted
	if [ $opted == "y" ]; then
		gtd run_actions_from_csv_file "$INBOX_FOLDER_LIST"
	fi
	
}

startYear(){

	echo 
    echo "  workflow start year"    
    echo 
    echo "   - invalidate yearly todo items"
    echo "   - schedule todo yearly tasks"  
    echo "   - commit do"
    echo        
    #doarchive
    t plan year invalidate && \
    t plan year && \
    commitdo
	
}

endYear(){

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
        echo "workflow error: unrecognized option \"$option\"."
        echo "try \" view help\" to get more information."
    fi
}