#!/bin/bash -x

# Filename : 20141109-do-bash script.sh
# Author : Lal Thomas 
# Date : 2014-11-09
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 

currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
alias t='sh "$doRootPath/todo.sh" -a -N -f'
alias todo='t list'
alias df=_do_main_


# main entities are 
#	/archive
#	/hold
#	/reference
#	/support
#	/upcoming
#	calendar.txt
#	context.md
#	done.txt
#	dont.txt
#	dreams.md
#	goals.md
#	project files
#	project-list.csv
#	projects.md
#	purpose.md
#	readmd.md
#	report.txt
#	spark.md
#	tickler.md
#	todo.txt
#	waiting.txt
#	wishlist.md

	
_do_main_(){   

	auto_commit(){
				
		git add *.m3u > /dev/null 2>&1 && gh repo commit "update playlist files"
		git add *manual\ notes* > /dev/null 2>&1 && gh repo commit "update manual notes"
		git add *contact\ file* > /dev/null 2>&1 && gh repo commit "update contact files"
		git add log.txt > /dev/null 2>&1 && gh repo commit "update log file"
		
	}

    clean_todo_files(){
        
        # move done and invalid items to done.txt and invalid.txt respectively
        t archive
        t invalidate 
        
    }

    update_inboxtxt_file(){

		update_projects_file
		update_contexts_file
        get_all_projects_names | sort -u >>inbox.txt
        get_all_contexts_names | sort -u >>inbox.txt
        sort inbox.txt | uniq | sort -o inbox.txt
		echo "inbox.txt file updated"

    }

	update_projects_file(){
	
		t listproj >projects.md
		echo "project.md file updated"
	}

	update_contexts_file(){
	
		t listcon >contexts.md
		echo "context.md file updated"
	}
	
    mail_priority_todo() {  
    
        # mail all todo with priority A     
        mailSubject="$today-$1"         
        echo 
        echo $mailSubject       
        echo 
        sed -n -e "s/(A)\(.*\)/* \1/p" <"$2" >&1 
        echo        
        # send mail
        sed -n -e "s/(A)\(.*\)/* \1/p" <"$2" | mail -s $mailSubject "$3"
        
    }

    mail_todo_priority_list(){
    
        mail_priority_todo 'MIT Todos' $doRootPath/todo.txt 'lal.thomas.mail+todo@gmail.com'
        
    }

    create_tickler_files(){
    
		# create tickler todo.txt files and move tasks from todo.txt
        local referencedate=$yearCount-$monthCount"-01"     
        if [ $# -eq 2 ]; 
        then
            local numberOfDays=$2
        else
            case $monthCount in
                01) numberOfDays=31 ;;  
                02) numberOfDays=29 ;;  
                03) numberOfDays=31 ;;  
                04) numberOfDays=30 ;;
                05) numberOfDays=31 ;;  
                06) numberOfDays=30 ;;  
                07) numberOfDays=31 ;;  
                08) numberOfDays=31 ;;  
                09) numberOfDays=30 ;;  
                10) numberOfDays=31 ;;  
                11) numberOfDays=30 ;;  
                12) numberOfDays=31 ;;      
            esac
        fi
        
        # START=`echo $startDate | tr -d -`;    
        for (( c=0; c<$numberOfDays; c++ ))
        do
            #echo -n "`date --date="$START +$c day" +%Y-%m-%d` ";       
            case "$OSTYPE" in
             darwin*)         
              local doDate="$(date -j -v +"$c"d -f '%Y-%m-%d' $referencedate +%Y-%m-%d)";
              local doShortDate="$(date -j -v +"$c"d -f '%Y-%m-%d' $referencedate +%Y%m%d)";
              # don't refactor        
              grep -e $doDate "$doTodoFile" >> "$doRootPath/$doShortDate-todo.txt"
              sed -i '' -e "/"$doDate"/d" "$doTodoFile"       
            ;; 
            cygwin|msys*)       
             # Windows        
              local doDate="$(date -d"$referencedate +$c days" +%Y-%m-%d)"  
              local doShortDate="$(date -d"$referencedate +$c days" +%Y%m%d)"   
              # don't refactor                
              grep -e $doDate "$doTodoFile" >> "$doRootPath/$doShortDate-todo.txt"
              sed -i '' -e "/"$doDate"/d" "$doTodoFile"       
            ;;      
            esac                   
        done
        
    }

    # remember the milk me update
    # t listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "me todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
    # t archive

    # Hidden Applications
    # open -a 'FileMerge'"

    # remove console colors using sed
    # sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"

	
	# TODO: [ ] add support for csv delimited project list file
    get_all_projects_names(){

        for file in *.txt *.md
        do			
			# skip resources file and goals file
			[ "$file" == "goals.md" ] && continue
			# get the projects from "$file"
			grep -o '[^  ]*+[^  ]\+'  "$file" | grep '^+' | sort -u			
			
        done

    }

	# TODO: [ ] add support for csv delimited project list file
    get_all_contexts_names(){

        for file in *.txt *.md
        do
			# skip resources file and goals file
			[ "$file" == "resources.md" ] && [ "$file" == "goals.md" ] && continue
			# get the contexts from "$file"
			grep -o '[^  ]*@[^  ]\+' "$file" | grep '^@' | sort -u
        done

    }
    
    move_project_matches_to_file(){
		
        # expects 
        # first argument - project name ( e.g. +dev )
        # second argument - archival file name ( e.g. dev project.txt)
		
		# echo arguments are $@	
		# echo Number of argument : $#
		
        if [ -z $0 ];
        then 
            echo "TODO: no enough arguments"
            return
        fi

        projectname=$1
		
        if [ $# -gt 1 ]; 
        then
			shift
            archiveFilename=$*
        else    
            #replace plus symbol
            fileNamePrefix=${projectname//+/}
            # replace backslash in variable
            fileNamePrefix=${fileNamePrefix//\// }
            archiveFilename="archive/$today-$fileNamePrefix.txt"
        fi  
		
		# echo project name : $projectname
		# echo filename : $archiveFilename		

		b replace_lines_in_txt_files_having_term $projectname $archiveFilename
		
        echo "TODO: project '$projectname' archived to '$archiveFilename'"
        
    }
	
	view_project_todos(){
	
		get_all_projects_names | sort -u | while read PRJ; do		
			b terminal "echo $PRJ; echo ; sh \"d://do/todo.sh\" -a -N -f -+ list $PRJ$"
			read -n1 -r -p "$PRJ" key </dev/tty		
		done
		
	}
	
	usage(){

        echo 
        echo "df OPTIONS"      
        echo " helper script to managing do folder"   
        echo 
        echo "OPTIONS are..."
        echo 		
		echo "add_birdseye_report"
		echo "add_todo_report"		
		echo "clean_todo_files"
		echo "create_tickler_files"
		echo "get_all_contexts_names"
		echo "get_all_projects_names"		
		echo "mail_priority_todo"
		echo "mail_todo_priority_list"
		echo "move_project_matches_to_file"
		echo "start_markdown_server"
		echo "start_server"
		echo "update_contexts_file"
		echo "update_inboxtxt_file"
		echo "update_projects_file"		
		echo "commit"
		echo "usage"  		
		
    }

	ACTION=$1
	shift

	# test the script
	# echo $filename $ACTION

	pushd "D:/do" > /dev/null 2>&1
		
	case "$ACTION" in						
		move_project_matches_to_file) move_project_matches_to_file $1 $2 ;;		
		clean_todo_files) clean_todo_files ;;
		create_tickler_files) create_tickler_files ;;
		get_all_contexts_names) get_all_contexts_names ;;
		get_all_projects_names)	get_all_projects_names ;;
		help|usage)	usage ;;
		mail_priority_todo)	mail_priority_todo ;;
		mail_todo_priority_list) mail_todo_priority_list ;;
		start_markdown_server) start_markdown_server ;;
		start_server) start_server ;;
		update_contexts_file) update_contexts_file ;;
		update_inboxtxt_file) update_inboxtxt_file ;;		
		update_projects_file) update_projects_file ;;
		view_project_todos) view_project_todos ;;
		commit) auto_commit ;;
	esac
	
	popd > /dev/null 2>&1
	
}


