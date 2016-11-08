#!/bin/bash
# script for managing daily work flow
# Copyright (c) Lal Thomas, http://lalamboori.blogspot.in
# License: GPL3, http://www.gnu.org/copyleft/gpl.html


alias gsd='sh "$toolsRootPath/20161026-get-shit-done/get-shit-done.sh"'
alias workflow=_workflow_main_

usage() {   
	echo "workflow"
	echo "========"
    echo "    routines actions"
    echo "    start day|week|month|year"
    echo "    end day|week|month|year"  
    echo 
    echo " working"
    echo " -------"
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
    
	browser="C:\Program Files\Mozilla Firefox\firefox.exe"
	todoapp="C:\Program Files (x86)\Hughesoft\todotxt.net\todotxt.exe"
	thunderbird="D:\PortableApps.com\PortableApps\ThunderbirdPortable\ThunderbirdPortable.exe"
	opted="n"
	cygstart "$browser"		
	t journal create "$docJournalFile"	    
	t log add "check-in into personal computer"	
	
	pushd "D:\Dropbox\action\20140310-do"
    git add log.txt
	git	commit -m"add log entry"	
	popd
	
    # GTD
    t file open "$doRootPath/todo.txt"	
	echo 
	echo "List of People to wish"	
	echo =========================
	echo 
	wish today
	echo
	
	read -p "enter y to wish now : " opted
	if [ $opted == "y" ]; then
		wish today email
	fi
	
	read -p "do you want start work : " opted
	if [ $opted == "y" ]; then
		# block time wasting websites
		gsd work
	else	
		read -p "do you want check mail : " opted
		if [ $opted == "y" ]; then
			cygstart "$thunderbird"
		fi	
	
		read -p "do you want start plan : " opted
		if [ $opted == "y" ]; then
			cygstart "$todoapp"
		fi	
	fi
}

endDay(){

	pushd "D:\Dropbox\action\20140310-do"
    t log add "check-out from personal computer "
	git add log.txt
	git	commit -m"add log entry"
	popd
    
	# unblock sites
	gsd play
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
    	
	dofolder clean_todo_file
	dofolder update_contexts_file
	dofolder update_projects_file
	dofolder update_inbox_file
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