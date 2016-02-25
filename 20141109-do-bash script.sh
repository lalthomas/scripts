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

doHelp(){
	echo "todo.txt planning helper scripts"	
	echo "=================================="
	echo 	
	echo "Reporting"
	echo "---------"
	echo 
	echo "addBirdsEyeReport - add birdseye report to $docRootPath folder"
	echo "addTodoReport - add todo done count to report.txt"	
	echo 
	echo "Misc."
	echo "------"
	echo 
	echo "createTicklerFiles - create tickler todo.txt files and move tasks from todo.txt"
	echo "mailTodoPriorityList - mail all todo with priority A"	
}

alias dohelp="doHelp"

# todo routine todo scheduling functions

cleanTodo(){
 t archive
 t invalidate 
}

addTodoReport(){
 t report
 openFile "$doRootPath/report.txt"
}

addBirdsEyeReport(){

cd $docRootPath
t birdseye > $docRootPath/$today"-todo birdseye report for week"-$weekCount.md
openFile $docRootPath/$today"-todo birdseye report for week"-$weekCount.md

}

mailPriorityToDo() {	

	mailSubject="$today-$1"	
	
	echo 
	echo $mailSubject		
	echo 
	
	sed -n -e "s/(A)\(.*\)/* \1/p" <"$2" >&1 
	echo 
	
	# send mail
	sed -n -e "s/(A)\(.*\)/* \1/p" <"$2" | mail -s $mailSubject "$3"
}

mailTodoPriorityList(){
	mailPriorityToDo 'MIT Todos' $doRootPath/todo.txt 'lal.thomas.mail+todo@gmail.com'
}


createTicklerFiles(){
	
	local referencedate=$yearCount-$monthCount"-01"		
	if [ $# -eq 1 ]; 
	then
		local numberOfDays=$1
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


StartServer(){

	local serverRootPath=$1
	cd "$serverRootPath"	
	python "$rootpath/scripts/source/20140607-start simple http server with markdown support-python script.py"	

}

StartMarkdownServer(){

	python "$rootpath/scripts/project/20150106-brainerd markdown server/brainerd.py"

}

alias startserverat="StartServer"
alias startbirthdayserver="StartMarkdownServer"


