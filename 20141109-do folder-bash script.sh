#!/bin/bash -x

# Filename : 20141109-do-bash script.sh
# Author : Lal Thomas 
# Date : 2014-11-09
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 
# do scripts variables

currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
alias t='sh "$doRootPath/todo.sh" -a -N -f'
alias todo='t list'
alias dofolder=_do_main_

_do_main_(){   

    clean_todo_files(){
        
        # move done and invalid items to done.txt and invalid.txt respectively
        t archive
        t invalidate 
        
    }

    add_todo_report(){
        
        #  add todo done count to report.txt
        t report
        openFile "$doRootPath/report.txt"
    }
    
    update_inbox_file(){

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
	
    add_birdseye_report(){
    
        # add birdseye report to $docRootPath folder        
        cd $docRootPath
        t birdseye > $docRootPath/$today"-todo birdseye report for week"-$weekCount.md
        openFile $docRootPath/$today"-todo birdseye report for week"-$weekCount.md      
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

    start_server(){
    
        local serverRootPath=$2
        cd "$serverRootPath"    
        python "$rootpath/scripts/source/20140607-start simple http server with markdown support-python script.py"  
        
    }

    start_markdown_server(){
    
        python "$rootpath/scripts/project/20150106-brainerd markdown server/brainerd.py"
        
    }

    get_all_projects_names(){

        for file in *.txt *.md
        do			
			# skip resources file and goals file
			[ "$file" == "resources.md" ] && [ "$file" == "goals.md" ] && continue
			# get the projects from "$file"
			grep -o '[^  ]*+[^  ]\+'  "$file" | grep '^+' | sort -u			
			
        done

    }

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

		replace_lines_in_txt_files_having_term $projectname $archiveFilename
		
        echo "TODO: project '$projectname' archived to '$archiveFilename'"
        
    }
	
	aggregate_lines_with_term(){
	
		# expects 
        # first argument - term ( e.g. +dev )
        # second argument - file name ( e.g. dev project.txt)
		
		 if [ -z $0 ];
        then 
            echo "TODO: no enough arguments"
            return
        fi

        term=$1		
		
        if [ $# -gt 1 ]; 
        then
			shift
            filename=$*
        else    
            #replace plus symbol
            fileNamePrefix=${term//+/}
            # replace backslash in variable
            fileNamePrefix=${fileNamePrefix//\// }
            filename="$today-$fileNamePrefix.txt"
        fi  
		
		replace_lines_in_txt_files_having_term $term $filename
		
	}
	
	replace_lines_in_txt_files_having_term(){
				
		term=$1
		shift
		filename=$*
		
        for file in *.txt 
        do
             grep "$term" "$file">>"$filename"
             # thanks http://stackoverflow.com/a/10467453/2182047
             # sed escape before replace 
             sed -i'' "/$(echo $term | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/d" "$file"
        done
        sort "$filename" | uniq | sort -o "$filename"
	
	}
	
	view_project_todos(){
	
		get_all_projects_names | sort -u | while read PRJ; do		
			
			echo
			echo $PRJ			
			echo 
			t -+ listall $PRJ
			echo
			read -n1 -r -p "Press any key to continue ..." key </dev/tty	
			echo
			clear
			
		done
		
	}
	
	
	usage(){

        echo 
        echo "dofolder OPTIONS"      
        echo " helper script to managing do folder"   
        echo 
        echo "OPTIONS are..."
        echo 		
		echo "add_birdseye_report"
		echo "add_todo_report"
		echo "aggregate_lines_with_term"
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
		echo "update_inbox_file"
		echo "update_projects_file"
		echo "usage"  		
		
    }

	ACTION=$1
	shift

	# test the script
	# echo $filename $ACTION

	pushd "D:\Dropbox\action\20140310-do" > /dev/null 2>&1
		
	case "$ACTION" in		
		add_birdseye_report) add_birdseye_report ;;
		add_todo_report) add_todo_report ;;
		move_project_matches_to_file) move_project_matches_to_file $1 $2 ;;
		aggregate_lines_with_term) aggregate_lines_with_term $1 $2 ;;
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
		update_inbox_file) update_inbox_file ;;		
		update_projects_file) update_projects_file ;;
		view_project_todos) view_project_todos ;;
	esac
	
	popd > /dev/null 2>&1
	
}


