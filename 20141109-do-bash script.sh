#!/bin/bash -x

# Filename : 20141109-do-bash script.sh
# Author : Lal Thomas 
# Date : 2014-11-09
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 
# do scripts variables

currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# find the OS type for rootPath

case "$OSTYPE" in
	darwin*) 
	# OSX
	export rootPath="/Users/rapid/Dropbox" 		
	;; 
	msys*) 
	# Windows
	export rootPath="/d/Dropbox"  	
	;;		
	cygwin*) 
	# Windows
	export rootPath="d:/Dropbox"  	
	;;		
	*) echo "unknown: $OSTYPE" ;;
esac

### todo.txt

export doRootPath="$rootPath/action/20140310-do"	
export doPlannerFile="$doRootPath/planner.md"
export doTodoFile="$doRootPath/todo.txt"
alias t='sh "$doRootPath/todo.sh" -a -N -f'
alias todo='t list'
alias todoarchive="t archive"
alias addreport="t report"
alias addtodobirdseyereport="t birdseye > '$rootPath/docs/$today-todo birdseye report for week-$weekCount.md'"

# todo routine todo scheduling functions

scheduleToDoDailyTasks() {

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


addDailyTasksForTheMonth(){

	local numberOfDays=$1
    local referencedate="$yearCount-$monthCount-01"

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

alias adddailytasksforthemonth="addDailyTasksForTheMonth"

# The `referencedate` is preferably be the first Monday of the month

scheduleToDoWeeklyTasks() {

	if [ $# -eq 2 ]; 
	then
		local referencedate=$(date "+%Y-%m-%d")
	    #exit 1
	else
		local referencedate="$3"
	fi

	case "$OSTYPE" in
	darwin*) 
		# OSX		
		local currentWeekCount=$(date -j -f '%Y-%m-%d' $referencedate +%V)
		sed -n -e "s/week:NN/week:$currentWeekCount/p" <"$1" | \
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
		tr '\r' ' '>>"$2"
		
		;; 
	
	cygwin|msys*)
		# Windows		
		local currentWeekCount="$(date -d"$referencedate" +%V)"
		sed -n -e "s/week:NN/week:$currentWeekCount/p" <"$1" | \
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
		tr '\r' ' '>>"$2"
		;; 		
					
	*) 
		echo "unknown: $OSTYPE" 
		;;
	esac	
	
}

alias scheduletodoweeklytasks="scheduleToDoWeeklyTasks '$doRootPath/planner.md' '$doRootPath/todo.txt'"

scheduleBatchTodoWeeklyTasks() {

if [ $# -eq 1 ]; 
	then
		scheduletodoweeklytasks "$1"		
		
	else						
		scheduletodoweeklytasks		
	fi

}

alias scheduletodoweeklytasks="scheduleBatchTodoWeeklyTasks"

scheduleToDoMonthlyTasks() {

   # add cygwin support

   currentMonthFirstMonday=$(d=$(date -d `date +%Y%m"01"` +%u);date -d `date +%Y-%m-"0"$(((9-$d)%7))` '+%Y-%m-%d') # cygwin, git-bash 
   currentMonthSecondMonday=$(date -d "$currentMonthFirstMonday 7 days" '+%Y-%m-%d')
   currentMonthThirdMonday=$(date -d "$currentMonthFirstMonday 14 days" '+%Y-%m-%d')
   currentMonthFourthMonday=$(date -d "$currentMonthFirstMonday 21 days" '+%Y-%m-%d')

	if [ $# -eq 2 ]; 
	then
		export referencedate=$(date -v -Mon "+%Y-%m-%d") # we get the current week's Monday
	else
		export referencedate=$(date -j -v "mon" -f '%Y-%m-%d' "$3" +%Y-%m-%d)	    
	fi
	
	sed -n -e "s/month:NN/month:$monthCount/p" <"$1" | \
	sed -n -e "s/\*[[:blank:]]//p" | \
	sed -e "s/^0001/$currentMonthFirstMonday &/p" | \
	sed -e "s/^0002/$currentMonthSecondMonday &/p" | \
	sed -e "s/^0003/$currentMonthThirdMonday &/p" | \
	sed -e "s/^0004/$currentMonthFourthMonday &/p" | \

#	sed -e "s/^0001/$(date -j -v +0d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
#	sed -e "s/^0002/$(date -j -v +7d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
#	sed -e "s/^0003/$(date -j -v +14d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
#	sed -e "s/^0004/$(date -j -v +21d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \

	sort -n | \
	uniq | \
	tr '\r' ' '>>"$2"
	
}

alias scheduletodomonthlytasks="scheduleToDoMonthlyTasks '$doRootPath/planner.md' '$doRootPath/todo.txt'"
alias scheduletodomonthlytasks="scheduletodomonthlytasks"

scheduleToDoYearlyTasks() {

	# TODO : add cygwin support

	if [ $# -eq 2 ]; 
	then
		export referencedate=$(date -v -Mon "+%Y-%m-%d")
	else
		export referencedate=$(date -j -v "mon" -f '%Y-%m-%d' "$3" +%Y-%m-%d)	    
	fi
	
	sed -n -e "s/year:NNNN/year:$yearCount/p" <"$1" | \
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
	tr '\r' ' '>>$2
	
}

alias scheduletodoyearlytasks="scheduleToDoYearlyTasks '$doRootPath/planner.md' '$doRootPath/todo.txt'"


scheduleBatchTodoYearlyTasks() {

    if [ $# -eq 1 ];
    then
        scheduletodoyearlytasks "$1"        
    else
        scheduletodoyearlytasks        
    fi

}

alias scheduletodoyearlytasks="scheduleBatchTodoYearlyTasks"

bumpDailyTodoItems(){

	local todofilepath="$1"
	local todoundonefilepath="$2"
	
	grep -e "\day:[0-9][0-9]" "$todofilepath" >> "$todoundonefilepath"
	# thanks :  http://robots.thoughtbot.com/sed-102-replace-in-place
	sed -i '' -e "/day:[0-9][0-9]/d" "$todofilepath"
	
}

alias bumptododailyitems="bumpDailyTodoItems '$doRootPath/todo.txt' '$doRootPath/undone.txt' "
alias bumptododailyitems="bumptododailyitems"

bumpWeeklyTodoItems(){

	local todofilepath="$1"
	local todoundonefilepath="$2"
	
	grep -e "\week:[0-9][0-9]" "$todofilepath" >> "$todoundonefilepath"
	sed -i '' -e "/week:[0-9][0-9]/d" "$todofilepath"

}

alias bumptodoweeklyitems="bumpWeeklyTodoItems '$doRootPath/todo.txt' '$doRootPath/undone.txt' "
alias bumptodoweeklyitems="bumptodoweeklyitems"

bumpMonthlyTodoItems(){

	local todofilepath=$1
	local todoundonefilepath=$2
	
	grep -e "\month:[0-9][0-9]" "$todofilepath" >> "$todoundonefilepath"
	sed -i '' -e "/month:[0-9][0-9]/d" "$todofilepath"

}

alias bumptodomonthlyitems="bumpMonthlyTodoItems '$doRootPath/todo.txt' '$doRootPath/undone.txt' "
alias bumptodomonthlyitems="bumptodomonthlyitems"

bumpYearlyTodoItems(){

	local todofilepath=$1
	local todoundonefilepath=$2
	
	grep -e "\year:[0-9][0-9][0-9][0-9]" "$todofilepath" >> "$todoundonefilepath"
	sed -i '' -e "/year:[0-9][0-9][0-9][0-9]/d" "$todofilepath"

}

alias bumptodoyearlyitems="bumpYearlyTodoItems '$doRootPath/todo.txt' '$doRootPath/undone.txt' "
alias bumptodoyearlyitems="bumptodoyearlyitems"


mailPriorityToDo() {
	sed -n -e "s/(A)\(.*\)/* \1/p" <"$2" | mail -s "$today-$1" "$3"
}

alias mailtodoprioritylist="mailPriorityToDo 'my todo' '$doRootPath/todo.txt' 'lal.thomas.mail+todo@gmail.com'"
alias mailtodopriority="mailtodoprioritylist"

# starty of day functions

StartMyDay(){		
		
    # bumpmetododailyitems && \ schedulemetododailytasks
    
    commitdo 
    commitreference
    commitsupport   
	createmyjournal		
	
	# GTD
	open "$doRootPath/next.txt"
	open "$doRootPath/contexts.md"
	open "$doRootPath/projects.md"
	
}
alias startmyday="StartMyDay && startbirthdayserver"

StartWorkDay(){

    # bumpworktododailyitems && scheduleworktododailytasks
	commitdowork 
    commitreferencework
    commitsupportwork	
	createworkjournal
	addcheckintimetoworkjournal
	
	# GTD
	open "$doRootPath work/next.txt"
	open "$doRootPath work/contexts.md"
	open "$doRootPath work/projects.md"

	# Apps
	open -a "Xcode"
	open -a "firefox"
	open -a "thunderbird"
	open -a "todotxtmac"
	# open -a "skype"
	#open -a "Momentics"
}

alias startworkday=StartWorkDay

StartDevDay(){

    # bumpdevtododailyitems && \ scheduledevtododailytasks
    commitdodev
    commitreferencedev
    commitsupportdev	
	createdevjournal
	
	# GTD
	open "$doRootPath dev/next.txt"
	open "$doRootPath dev/contexts.md"
	open "$doRootPath dev/projects.md"

}

alias startdevday=StartDevDay

EndWorkDay(){

	addcheckouttimetoworkjournal	
	
}

alias endworkday=EndWorkDay

StartMyWeek(){

    #doarchive
    #bumptodoweeklyitems
		
	if [ $# -eq 0 ]; 
	then
		scheduletodoweeklytasks	    		
	else
		scheduletodoweeklytasks "$1"		
	fi	
	commitdo	
}

alias startweek=StartMyWeek

StartMyMonth(){

    #doarchive
	bumptodomonthlyitems && \
	scheduletodomonthlytasks && \
	commitdo
}

alias startmymonth=StartMyMonth

StartMyYear(){

    #doarchive
	bumptodoyearlyitems && \
	scheduletodoyearlytasks && \
	commitdo
}

alias startyear=StartMyYear

# print todo functions

createDailyTodoPrintFile(){

    local COPYDIR="$rootPath/Docs"
    local printFile="$COPYDIR/$today-me daily todo print list for the month.md"

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

    # Formatting the file - remove context heading
    # sed -i '' -e "s/=====  Contexts  =====//" "$printFile"

    # thanks http://stackoverflow.com/a/7567839/2182047
    # sed -i '' "s/--- \(.*\) ---/### \1 \\`echo -e '\r'`/" "$printFile"

    # remove double space with one space
    # sed -i '' -e 's/  */ /g' "$printFile"

    # add li listing
    # sed -i '' -e 's/^[0-9]\{4\}/ * &/g' "$printFile"

    # convert to markdown
    pandoc -o "$printFile.html" "$printFile"


}


createWeeklyTodoPrintFile(){

    local COPYDIR="$rootPath/docs"
    local printFile="$COPYDIR/$today-me weekly todo print list for the month.md"

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

    # Formatting the file
    #sed -i '' -e "s/=====  Contexts  =====//" "$printFile"

    # thanks http://stackoverflow.com/a/7567839/2182047
    #sed -i '' "s/--- \(.*\) ---/### \1 \\`echo -e '\r'`/" "$printFile"

    # remove double space with one space
    #sed -i '' -e 's/  */ /g' "$printFile"

    # add li listing
    #sed -i '' -e 's/^[0-9]\{4\}/ * &/g' "$printFile"

    # convert to markdown
    pandoc -o "$printFile.html" "$printFile"


}


createMonthlylyTodoPrintFile(){

    local COPYDIR="$rootPath/docs"
    local printFile="$COPYDIR/$today-me monthly todo print list for the month.md"

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

    # Formatting the file
    #sed -i '' -e "s/=====  Contexts  =====//" "$printFile"

    # thanks http://stackoverflow.com/a/7567839/2182047
    #sed -i '' "s/--- \(.*\) ---/### \1 \\`echo -e '\r'`/" "$printFile"

    # remove double space with one space
    #sed -i '' -e 's/  */ /g' "$printFile"

    # add li listing
    #sed -i '' -e 's/^[0-9]\{4\}/ * &/g' "$printFile"

    # convert to markdown
    pandoc -o "$printFile.html" "$printFile"

}


createYearlyTodoPrintFile(){

    local COPYDIR="$rootPath/docs"
    local printFile="$COPYDIR/$today-me yearly todo print list for the month.md"

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

    # Formatting the file
    # sed -i '' -e "s/=====  Contexts  =====//" "$printFile"

    # thanks http://stackoverflow.com/a/7567839/2182047
    # sed -i '' "s/--- \(.*\) ---/### \1 \\`echo -e '\r'`/" "$printFile"

    # remove double space with one space
    # sed -i '' -e 's/  */ /g' "$printFile"

    # add li listing
    # sed -i '' -e 's/^[0-9]\{4\}/ * &/g' "$printFile"

    # convert to markdown
    pandoc -o "$printFile.html" "$printFile"

}


createNonRecuringTodoPrintFile(){

    local COPYDIR="$rootPath/docs"
    local printFile="$COPYDIR/$today-me yearly todo print list for projects.md"

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

    grep -i "\@$context" <"$2/todo.txt" | \
    sed -n -e "s/^\(.*\)/* &/p" >>"$printfile"

    echo >>"$printfile"

    grep -i "\@$context" <"$2/next.md" >>"$printfile"

}

alias createshoptodoprintfile="createContextList 'shop' '$doRootPath' '$rootPath/docs/$today-shop list for month-$monthCount.md'"
alias createhometodoprintfile="createContextList 'home' '$doRootPath' '$rootPath/docs/$today-home list for month-$monthCount.md'"

# remember the milk me update

# t listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "me todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# t archive

# Hidden Applications
# open -a 'FileMerge'"

# remove console colors using sed
# sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"

