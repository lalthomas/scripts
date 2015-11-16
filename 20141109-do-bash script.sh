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
	echo "Process"
	echo "-------"
	echo "archiveTodo - move done items on todo.txt to done.txt"	
	echo "bumpDailyTodoItems - move todos with day label (day:<NN>) to invalid.txt"
	echo "bumpMonthlyTodoItems - move todos with month label (month:<NN>) to invalid.txt"
	echo "bumpWeeklyTodoItems - move todo with week label (week:<NN>) to invalid.txt"
	echo "bumpYearlyTodoItems - move todo with year label (week:<NN>) to invalid.txt"	
	echo "scheduleToDoDailyTasks - add day todos from planner.txt to todo.txt"
	echo "scheduleToDoDailyTasksForTheMonth - batch add day todos from planner.txt to todo.txt for one month"
	echo "scheduleToDoMonthlyTasks - add month todo from planner.txt template to todo.txt"
	echo "scheduleToDoWeeklyTasks -  add weekly todo from planner.txt template to todo.txt"
	echo "scheduleToDoWeeklyTasks <week number> -  add weekly todo from planner.txt template to todo.txt for the week number"
	echo "scheduleToDoYearlyTasks - add yearly todo from planner.txt template to todo.txt for the current year"	
	echo 
	echo "Print"
	echo "-----"
	echo 
	echo "createDailyTodoPrintFile - create a printable file of daily todo on $docRootPath folder"
	echo "createHomeTodoPrintFile - create a printable file of todo with home context"
	echo "createMonthlylyTodoPrintFil -  create a printable file of monthly todo on $docRootPath folder"
	echo "createNonRecuringTodoPrintFile - create a printable file of non recurring todos on $docRootPath folder"
	echo "createShopTodoPrintFile - create a printable file of shop todos on $docRootPath folder "
	echo "createWeeklyTodoPrintFile - create a printable file of weekly todo on $docRootPath folder"
	echo "createYearlyTodoPrintFile - create a printable file of yearly todo on $docRootPath folder"	
	echo 
	echo "Work Flow"
	echo "--------"
	echo 
	echo "startDay"
	echo " - commit changes in $doRootPath folder"	
	echo " - create a journal file on $journalPath (journal file) with scheduled tasks"
	echo " - add check in time to $doLogPath file"
	echo 
	echo "endDay"
	echo " - add check out time to $doLogPath file"
	echo " - add done items from done.txt to $journalPath(journal file)"
	echo 
	echo "startWeek"
	echo " ! run on monday or pass current week's monday as argument"
	echo " - schedule todo weekly tasks"	
	echo 
	echo "startMonth"
	echo " - archiveTodo"
	echo " - bumpMonthlyTodoItems"
	echo " - scheduleToDoMonthlyTasks"
	echo " - commitdo"		
	echo 
	echo "startYear"	
	echo " - bumpYearlyTodoItems"
	echo " - scheduleToDoYearlyTasks"	
	echo " - commitdo"
	echo "Misc."
	echo "------"
	echo 
	echo "createTicklerFiles - create tickler todo.txt files and move tasks from todo.txt"
	echo "mailTodoPriorityList - mail all todo with priority A"
	
}

alias dohelp="doHelp"

# todo routine todo scheduling functions

archiveTodo(){
 t archive
}

addTodoReport(){
 t report
}

addBirdsEyeReport(){

t birdseye > '$docRootPath/$today-todo birdseye report for week-$weekCount.md'

}

scheduleToDoDailyTasks() {

	# todo: add support for weekdays and specific day tasks

	if [ $# -eq 1 ]; 
	then
		local referencedate="$1"		
	    #exit 1
	else
		local referencedate=$longdate
	fi	
	
	case "$OSTYPE" in

        darwin*)
        # OSX
            local dateNum=$(date -jf "%Y-%m-%d" $referencedate +"%d")
        ;;

        msys*)
        # Windows
            local dateNum=$(date +'%d' --date=$referencedate)
        ;;

        cygwin*)
        # Windows
            local dateNum=$(date +'%d' --date=$referencedate)
        ;;

        *)
            echo "unknown: $OSTYPE"
        ;;
	esac	
	
	sed -n -e "s/day:NN/day:$dateNum/p" <"$doPlannerFile" | \
	sed -n -e "s/\*[[:blank:]]//p" | \
	sed -n -e "s/^/$referencedate /p" | \
	sort -n | \
	uniq | \
	tr '\r' ' '>>"$doTodoFile"
	
}

scheduleToDoDailyTasksForTheMonth(){

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
		# echo -n "`date --date="$START +$c day" +%Y-%m-%d` ";		
		case "$OSTYPE" in
		 darwin*) 		
		  local doDate="$(date -j -v +"$c"d -f '%Y-%m-%d' $referencedate +%Y-%m-%d)";
		  # don't refactor
		  scheduleToDoDailyTasks $doDate          
		;; 
		cygwin|msys*)		
		 # Windows		  
		  local doDate="$(date -d"$referencedate +$c days" +%Y-%m-%d)"	
		  # don't refactor
		  scheduleToDoDailyTasks $doDate          
		;; 		
	   esac		
	done
}

# The `referencedate` is preferably be the first Monday of the month

scheduleToDoWeeklyTasks() {

# in order to run the script properly the `referencedate` should be start of the week
# todo: get monday when week count is given
# todo: get current week monday date

	if [ $# -eq 1 ]; 
	then
		local referencedate="$1"		
	    #exit 1
	else
		local referencedate=$longdate
	fi

	case "$OSTYPE" in
	darwin*) 
		# OSX		
		local currentWeekCount=$(date -j -f '%Y-%m-%d' $referencedate +%V)
		sed -n -e "s/week:NN/week:$currentWeekCount/p" <"$doPlannerFile" | \
		sed -n -e "s/\*[[:blank:]]//p" | \
		sed -e "s/^001/$(date -j -v +0d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
		sed -e "s/^002/$(date -j -v +1d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
		sed -e "s/^003/$(date -j -v +2d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
		sed -e "s/^004/$(date -j -v +3d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
		sed -e "s/^005/$(date -j -v +4d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
		sed -e "s/^006/$(date -j -v +5d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
		sed -e "s/^007/$(date -j -v +6d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
		sort -n | \
		uniq | \
		tr '\r' ' '>>"$doTodoFile"
		
		;; 
	
	cygwin|msys*)
		# Windows		
		local currentWeekCount="$(date -d"$referencedate" +%V)"
		sed -n -e "s/week:NN/week:$currentWeekCount/p" <"$doPlannerFile" | \
		sed -n -e "s/\*[[:blank:]]//p" | \
		sed -e "s/^001/$(date +%Y-%m-%d --d "$referencedate + 0 day") &/p" | \
		sed -e "s/^002/$(date +%Y-%m-%d --d "$referencedate + 1 day") &/p" | \
		sed -e "s/^003/$(date +%Y-%m-%d --d "$referencedate + 2 day") &/p" | \
		sed -e "s/^004/$(date +%Y-%m-%d --d "$referencedate + 3 day") &/p" | \
		sed -e "s/^005/$(date +%Y-%m-%d --d "$referencedate + 4 day") &/p" | \
		sed -e "s/^006/$(date +%Y-%m-%d --d "$referencedate + 5 day") &/p" | \
		sed -e "s/^007/$(date +%Y-%m-%d --d "$referencedate + 6 day") &/p" | \
		sort -n | \
		uniq | \
		tr '\r' ' '>>"$doTodoFile"
		;; 		
					
	*) 
		echo "unknown: $OSTYPE" 
		;;
	esac	
	
}

scheduleToDoMonthlyTasks() {

   # todo add support reference month   
   
	sed -n -e "s/month:NN/month:$monthCount/p" <"$doPlannerFile" | \
	sed -n -e "s/\*[[:blank:]]//p" | \
	sed -e "s/^0001/$currentMonthFirstMonday &/p" | \
	sed -e "s/^0002/$currentMonthSecondMonday &/p" | \
	sed -e "s/^0003/$currentMonthThirdMonday &/p" | \
	sed -e "s/^0004/$currentMonthFourthMonday &/p" | \
	sort -n | \
	uniq | \
	tr '\r' ' '>>"$doTodoFile"
	
}

scheduleToDoYearlyTasks() {

	# TODO : add support for referenceYear
	
	sed -n -e "s/year:NNNN/year:$yearCount/p" <"$doPlannerFile" | \
	sed -n -e "s/\*[[:blank:]]//p" | \
	sed -e "s/^00001/$yearCount-01-01 &/p" | \
	sed -e "s/^00002/$yearCount-02-01 &/p" | \
	sed -e "s/^00003/$yearCount-03-01 &/p" | \
	sed -e "s/^00004/$yearCount-04-01 &/p" | \
	sed -e "s/^00005/$yearCount-05-01 &/p" | \
	sed -e "s/^00006/$yearCount-06-01 &/p" | \
	sed -e "s/^00007/$yearCount-07-01 &/p" | \
	sed -e "s/^00008/$yearCount-08-01 &/p" | \
	sed -e "s/^00009/$yearCount-09-01 &/p" | \
	sed -e "s/^00010/$yearCount-10-01 &/p" | \
	sed -e "s/^00011/$yearCount-11-01 &/p" | \
	sed -e "s/^00012/$yearCount-12-01 &/p" | \
	sort -n | \
	uniq | \
	tr '\r' ' '>>"$doTodoFile"
	
}

bumpDailyTodoItems(){	

	grep -e "\day:[0-9][0-9]" "$doTodoFile" >> "$doInvalidFile"
	# thanks :  http://robots.thoughtbot.com/sed-102-replace-in-place
	sed -i '' -e "/day:[0-9][0-9]/d" "$doTodoFile"
	
}

bumpWeeklyTodoItems(){

	grep -e "\week:[0-9][0-9]" "$doTodoFile" >> "$doInvalidFile"
	sed -i '' -e "/week:[0-9][0-9]/d" "$doTodoFile"

}

bumpMonthlyTodoItems(){

	grep -e "\month:[0-9][0-9]" "$doTodoFile" >> "$doInvalidFile"
	sed -i '' -e "/month:[0-9][0-9]/d" "$doTodoFile"

}

bumpYearlyTodoItems(){
	
	grep -e "\year:[0-9][0-9][0-9][0-9]" "$doTodoFile" >> "$doInvalidFile"
	sed -i '' -e "/year:[0-9][0-9][0-9][0-9]/d" "$doTodoFile"

}

mailPriorityToDo() {
	sed -n -e "s/(A)\(.*\)/* \1/p" <"$2" | mail -s "$today-$1" "$3"
}

mailTodoPriorityList(){
	mailPriorityToDo 'my todo' '$doRootPath/todo.txt' 'lal.thomas.mail+todo@gmail.com'
}

# starty of day functions

startDay(){		
			
	createJournalFile "$doPlannerFile" "$journalPath" "$doPlannerFile" "$doRootPath/journal.md"
	addCheckInTimetoLog
	commitdo
	
	# GTD
	# open "$doRootPath/$today-todo.txt"
	openFile "$doRootPath/inbox.txt"
}

endDay(){

	addCheckOutTimetoLog	
	addMyDoneItemsToJournal
}

startWeek(){
	
	# as per the current implementation run either monday
	# or as pass current week monday as argument otherwise 
	# the command will produce undesired output
	
	if [ $# -eq 0 ]; 
	then
		scheduleToDoWeeklyTasks	    		
	else
		scheduleToDoWeeklyTasks "$1"		
	fi	
	commitdo	
}

startMonth(){

    doarchive
	bumpMonthlyTodoItems && \
	scheduleToDoMonthlyTasks && \
	commitdo
}

startYear(){

    #doarchive
	bumpYearlyTodoItems && \
	scheduleToDoYearlyTasks && \
	commitdo
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


# print todo functions

createDailyTodoPrintFile(){
    
    local printFile="$docRootPath/$today-daily todo list.md"

    echo >"$printFile"
    echo >"$printFile.html"

    local dailyTasks=($( t list "day:" | grep -oh "day:[0-9][0-9]" | sort | uniq | grep -oh "[0-9][0-9]" ))

    for i in "${!dailyTasks[@]}"
    do

        createMarkdownHeading "1" "Day ${dailyTasks[i]}" "$printFile"
        # truncate characters from interating marker day which includes interating symbol (here day) context and projects
        t mdview context "day:${dailyTasks[i]}" | sed "s/day:.*//" >>"$printFile"

        # add page break after each day todos
        echo "<p style='page-break-after:always;'></p>">>"$printFile"
        printf "\n\n" >>"$printFile"

    done
    pandoc -o "$printFile.html" "$printFile"

}


createWeeklyTodoPrintFile(){

    local printFile="$docRootPath/$today-weekly todo list.md"

    echo >"$printFile"
    echo >"$printFile.html"

    local weeklyTasks=($( t list "week:" | grep -oh "week:[0-9][0-9]" | sort | uniq | grep -oh "[0-9][0-9]" ))

    for i in "${!weeklyTasks[@]}"
    do
        #echo "$i=>${weeklyTasks[i]}"

        createMarkdownHeading "1" "Week ${weeklyTasks[i]}" "$printFile"
        # truncate characters from interating marker day which includes interating symbol (here day) context and projects
        t mdview context "week:${weeklyTasks[i]}" | sed "s/week:.*//" >>"$printFile"

        # add page break after each day todos
        echo "<p style='page-break-after:always;'></p>">>"$printFile"
        printf "\n\n" >>"$printFile"

    done
    pandoc -o "$printFile.html" "$printFile"
}


createMonthlylyTodoPrintFile(){

    local printFile="$docRootPath/$today-monthly todo list.md"

    echo >"$printFile"
    echo >"$printFile.html"

    local monthlyTasks=($( t list "month:" | grep -oh "month:[0-9][0-9]" | sort | uniq | grep -oh "[0-9][0-9]" ))

    for i in "${!monthlyTasks[@]}"
    do
        #echo "$i=>${weeklyTasks[i]}"
        createMarkdownHeading "1" "Month ${monthlyTasks[i]}" "$printFile"
        # truncate characters from interating marker day which includes interating symbol (here day) context and projects
        t mdview context "month:${monthlyTasks[i]}" | sed "s/month:.*//" >>"$printFile"
        # add page break after each day todos
        echo "<p style='page-break-after:always;'></p>">>"$printFile"
        printf "\n\n" >>"$printFile"
    done

    # convert to markdown
    pandoc -o "$printFile.html" "$printFile"

}


createYearlyTodoPrintFile(){
    
    local printFile="$docRootPath/$today-yearly todo list.md"

    echo >"$printFile"
    echo >"$printFile.html"

    local yearlyTasks=($( t list "year:" | grep -oh "year:[0-9][0-9][0-9][0-9]" | sort | uniq | grep -oh "[0-9][0-9][0-9][0-9]" ))

    for i in "${!yearlyTasks[@]}"
    do
        #echo "$i=>${weeklyTasks[i]}"
        createMarkdownHeading "1" "Year ${yearlyTasks[i]}" "$printFile"
        # truncate characters from interating marker day which includes interating symbol (here day) context and projects
        t mdview context "year:${yearlyTasks[i]}" | sed "s/year:.*//" >>"$printFile"
        # add page break after each day todos
        echo "<p style='page-break-after:always;'></p>">>"$printFile"
        printf "\n\n" >>"$printFile"
    done
	
    pandoc -o "$printFile.html" "$printFile"

}


createNonRecuringTodoPrintFile(){

    local printFile="$docRootPath/$today-projects todo list.md"

    # \:\|month\:\|week\:\|day\:
    t -+ -p view project | sed -e '/year:/d' | sed -e '/month:/d' | sed -e '/week:/d' | sed -e '/day:/d'  >>"$printFile"

    # Formatting the file
    sed -i '' -e "s/=====  Projects  =====//" "$printFile"

    # thanks http://stackoverflow.com/a/7567839/2182047
    sed -i '' "s/--- \(.*\) ---/### \1 \\`echo -e '\r'`/" "$printFile"

    # remove double space with one space
    sed -i '' -e 's/  */ /g' "$printFile"

    # add li listing
    sed -i '' -e 's/^[0-9]\{4\}/ * &/g' "$printFile"

    # convert to markdown
    pandoc -o "$printFile.html" "$printFile"


}


createContextList(){

    local context=$1
    local filename=$2
    local printfile=$3

    echo>"$printfile"
    createMarkdownHeading "1" "$context todo list" "$printfile"
    echo "*Date of Creation* : $longdate" >>"$printfile"
    echo >>"$printfile"

    grep -i "\@$context" <"$doTodoFile" | \
    sed -n -e "s/^\(.*\)/* &/p" >>"$printfile"
    echo >>"$printfile"    

}

createShopTodoPrintFile(){

createContextList 'shop' '$doRootPath' '$docRootPath/$today-shop list for month-$monthCount.md'

}

createHomeTodoPrintFile(){

createContextList 'home' '$doRootPath' '$docRootPath/$today-home list for month-$monthCount.md'

}

# remember the milk me update

# t listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "me todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# t archive

# Hidden Applications
# open -a 'FileMerge'"

# remove console colors using sed
# sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"

