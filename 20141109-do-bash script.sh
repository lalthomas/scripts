#!/bin/bash -x

# Author : Lal Thomas 
# Date : 2014-11-09
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 

today=$(date "+%Y%m%d")
longdate=$(date "+%Y-%m-%d")

weekCount=$(date +'%V')
dayOfWeeK=$(date +%A)

monthCount=$(date +'%m')
yearCount=$(date +'%Y')

dayOfWeekLowerCase=$(date +%A | sed -e 's/\(.*\)/\L\1/')
currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

case "$OSTYPE" in
	darwin*) 
	# OSX
	export rootpath="/Users/rapid/Dropbox" 
	yesterday=$(date -v-1d "+%Y%m%d")
	longyesterday=$(date -v-1d "+%Y-%m-%d")	
	dayofWeekYesterday=$(date -v-1d +%A)
	;; 
	msys*) 
	# Windows
	export rootpath="/d/Dropbox"  
	yesterday=$(date --date='yesterday' +'%Y%m%d')
	longyesterday=$(date --date='yesterday' +'%Y-%m-%d')
	dayofWeekYesterday=$(date --date='yesterday' +%A)
	;;	
	
	cygwin*) 
	# Windows
	export rootpath="d:/Dropbox"  
	yesterday=$(date --date='yesterday' +'%Y%m%d')
	longyesterday=$(date --date='yesterday' +'%Y-%m-%d')
	dayofWeekYesterday=$(date --date='yesterday' +%A)
	;;	
	
	*) echo "unknown: $OSTYPE" ;;
esac

extension=".md"
personaljournalfilename=$today-$dayOfWeeK" personal journal"$extension
workjournalfilename=$today-$dayOfWeeK" work journal"$extension
devjournalfilename=$today-$dayOfWeeK" dev journal"$extension

personaljournalfilepath="$rootpath/docs/$personaljournalfilename"
workjournalfilepath="$rootpath/docs/$workjournalfilename"

yesterdayPersonalJournalFilename=$yesterday-$dayofWeekYesterday" personal journal"$extension
yesterdayPersonalJournalFilepath="$rootpath/docs/$yesterdayPersonalJournalFilename"

mailtopocket() {
	echo "$1" | mail -s "$1" "add@getpocket.com"
}
alias mailtopocket=mailtopocket


printTrailingCharacter(){

 	character=$1
	# markdown heading label
 	COUNTER=0
 	while [  $COUNTER -lt $length ]; do
		printf '%s' $character >>"$2"
	    let COUNTER=COUNTER+1 
	  done
}

createMarkdownHeading(){

  local headingType=$1
  local headingTitle=$2
  local filePath=$3
  local length=${#headingTitle} 
  
  case $headingType in
	1) 
		# Heading I		
		printf "$headingTitle" >>"$filePath"
		printf "\n" >>"$filePath" 
		printTrailingCharacter '=' "$filePath"
		# add two blank line
		printf "\n\n" >>"$filePath"     		
		;;
	2) 
		# Heading II		
		printf "$headingTitle" >>"$filePath"
		printf "\n" >>"$filePath" 
		printTrailingCharacter '-' "$filePath"
		# add two blank line
		printf "\n\n" >>"$filePath"		
		;; 
	3) 
		# Heading III		
		printf "###" >>"$filePath"
		printf "$headingTitle" >>"$filePath"
		printf "\n\n" >>"$filePath"
		;;		
	4) 
		# Heading IV		
		printf "####" >>"$filePath"
		printf "$headingTitle" >>"$filePath"
		printf "\n\n" >>"$filePath"
		;; 
	*) 
		# Heading Unknown		
		echo "unknown heading type" 
		;; 
  esac  
  
}

createjournalfile(){

	local COPYDIR="$rootpath/Docs"
	local todofolder="$1"
	local journalname="$2"
	local todofilepath="$todofolder/todo.txt"
	local journalpath="$todofolder/$journalname"
	local plannerfilepath="$todofolder/planner.md"
	local sectionplannerfilepath="$todofolder/journal.md"	

	#printf $rootpath


	# check if file exists or not
	if [ ! -f "$COPYDIR"/"$journalname" ];then

	  createMarkdownHeading "1" "$today" "$journalpath"
	  
	  createMarkdownHeading "2" "Scheduled Tasks" "$journalpath"   
	  
	  # Dump the today's scheduled task to todo.txt and extra line breaks	  
	  sed -n -e 's/'$longdate'/* &/p'<"$todofilepath" >>"$journalpath"
	  printf "\n">>"$journalpath"

	  # Read input file into a string variable. 
	  # Thanks : http://stackoverflow.com/a/2789399/2182047  
	  copyfilecontent=$(cat $sectionplannerfilepath)
	  #copy contents to journal file
	  printf "$copyfilecontent" >>"$journalpath"  
	  # add two blank line
	  printf "\n\n" >>"$journalpath"	  	  
 	  
	  mv "$journalpath" "$COPYDIR"/"$journalname"

	fi

	# open the file
	# open command don't work on windows	
	case "$OSTYPE" in
	darwin*) 
		# OSX		
		open "$COPYDIR"/"$journalname"		
		;; 
	msys*)
		# Windows
		start "" "$COPYDIR"/"$journalname"
		;; 		
	*) 
		echo "unknown: $OSTYPE" 
		;;
	esac
}
alias createmejournal="createjournalfile '$rootpath/do/me' '$personaljournalfilename'"
alias createworkjournal="createjournalfile '$rootpath/do/work' '$workjournalfilename' "
alias createdevjournal="createjournalfile '$rootpath/do/dev' '$devjournalfilename' "
alias createjournal="createmejournal && createworkjournal && createdevjournal"

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

alias createshoptodoprintfile="createContextList 'shop' '$rootpath/do/me' '$rootpath/docs/$today-shop list for month-$monthCount.md'"
alias createhometodoprintfile="createContextList 'home' '$rootpath/do/me' '$rootpath/docs/$today-home list for month-$monthCount.md'"

scheduleToDoDailyTasks() {

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
	
	sed -n -e "s/day:NN/day:$dateNum/p" <"$1" | \
	sed -n -e "s/\*[[:blank:]]//p" | \
	sed -n -e "s/^/$referencedate /p" | \
	sort -n | \
	uniq | \
	tr '\r' ' '>>$2
	
}


alias schedulemetododailytasks="scheduleToDoDailyTasks '$rootpath/Do/me/planner.md' '$rootpath/Do/me/todo.txt'"
alias scheduledevtododailytasks="scheduleToDoDailyTasks '$rootpath/Do/dev/planner.md' '$rootpath/Do/dev/todo.txt'"
alias scheduleworktododailytasks="scheduleToDoDailyTasks '$rootpath/Do/work/planner.md' '$rootpath/Do/work/todo.txt'"

scheduleBatchTodoDailyTasks() {

    if [ $# -eq 1 ];
    then
        schedulemetododailytasks "$1"
        scheduledevtododailytasks "$1"
        scheduleworktododailytasks "$1"

    else
        schedulemetododailytasks
        scheduledevtododailytasks
        scheduleworktododailytasks
    fi

}

alias scheduletododailytasks="scheduleBatchTodoDailyTasks"


addDailyTasksForTheMonth(){

	local numberOfDays=$1
    local referencedate="$yearCount-$monthCount-01"

	# START=`echo $startDate | tr -d -`;	
	for (( c=0; c<$numberOfDays; c++ ))
	do
		# echo -n "`date --date="$START +$c day" +%Y-%m-%d` ";
		local doDate="$(date -j -v +"$c"d -f '%Y-%m-%d' $referencedate +%Y-%m-%d)";
        schedulemetododailytasks $doDate
        scheduledevtododailytasks $doDate
        scheduleworktododailytasks $doDate
        #echo $doDate

	done
	
}

alias adddailytasksforthemonth="addDailyTasksForTheMonth"


scheduleToDoWeeklyTasks() {

	if [ $# -eq 2 ]; 
	then
		local referencedate=$(date "+%Y-%m-%d")
	    #exit 1
	else
		local referencedate="$3"
	fi

       local currentWeekCount=$(date -j -f '%Y-%m-%d' $referencedate +%V)

	case "$OSTYPE" in
	darwin*) 
		# OSX		
		
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
		tr '\r' ' '>>$2
		
		;; 
	msys*)
		# Windows
		sed -n -e "s/week:NN/week:$currentWeekCount/p" <"$1" | \
		sed -n -e "s/\*[[:blank:]]//p" | \
		sed -e "s/^001/$(date +%Y-%m-%d -d "$referencedate + 0 day") &/p" | \
		sed -e "s/^002/$(date +%Y-%m-%d -d "$referencedate + 1 day") &/p" | \
		sed -e "s/^003/$(date +%Y-%m-%d -d "$referencedate + 2 day") &/p" | \
		sed -e "s/^004/$(date +%Y-%m-%d -d "$referencedate + 3 day") &/p" | \
		sed -e "s/^005/$(date +%Y-%m-%d -d "$referencedate + 4 day") &/p" | \
		sed -e "s/^006/$(date +%Y-%m-%d -d "$referencedate + 5 day") &/p" | \
		sed -e "s/^007/$(date +%Y-%m-%d -d "$referencedate + 6 day") &/p" | \
		sort -n | \
		uniq | \
		tr '\r' ' '>>$2
		;; 		
					
	*) 
		echo "unknown: $OSTYPE" 
		;;
	esac	
	
}

scheduleBatchTodoWeeklyTasks() {

if [ $# -eq 1 ]; 
	then
		schedulemetodoweeklytasks "$1"
		scheduledevtodoweeklytasks "$1"
		scheduleworktodoweeklytasks "$1" 
		
	else						
		schedulemetodoweeklytasks
		scheduledevtodoweeklytasks
		scheduleworktodoweeklytasks								
	fi

}

alias schedulemetodoweeklytasks="scheduleToDoWeeklyTasks '$rootpath/Do/me/planner.md' '$rootpath/Do/me/todo.txt'"
alias scheduledevtodoweeklytasks="scheduleToDoWeeklyTasks '$rootpath/Do/dev/planner.md' '$rootpath/Do/dev/todo.txt'"
alias scheduleworktodoweeklytasks="scheduleToDoWeeklyTasks '$rootpath/Do/work/planner.md' '$rootpath/Do/work/todo.txt'"
alias scheduletodoweeklytasks="scheduleBatchTodoWeeklyTasks"

scheduleToDoMonthlyTasks() {

   # TODO : add cygwin support

	if [ $# -eq 2 ]; 
	then
		export referencedate=$(date -v -Mon "+%Y-%m-%d")
	else
		export referencedate=$(date -j -v "mon" -f '%Y-%m-%d' "$3" +%Y-%m-%d)	    
	fi
	
	sed -n -e "s/month:NN/month:$monthCount/p" <"$1" | \
	sed -n -e "s/\*[[:blank:]]//p" | \
	sed -e "s/^0001/$(date -j -v +0d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
	sed -e "s/^0002/$(date -j -v +7d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
	sed -e "s/^0003/$(date -j -v +14d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
	sed -e "s/^0004/$(date -j -v +21d -f '%Y-%m-%d' $referencedate +%Y-%m-%d) &/p" | \
	sort -n | \
	uniq | \
	tr '\r' ' '>>$2
	
}
alias schedulemetodomonthlytasks="scheduleToDoMonthlyTasks '$rootpath/Do/me/planner.md' '$rootpath/Do/me/todo.txt'"
alias scheduledevtodomonthlytasks="scheduleToDoMonthlyTasks '$rootpath/Do/dev/planner.md' '$rootpath/Do/dev/todo.txt'"
alias scheduleworktodomonthlytasks="scheduleToDoMonthlyTasks '$rootpath/Do/work/planner.md' '$rootpath/Do/work/todo.txt'"
alias scheduletodomonthlytasks="schedulemetodomonthlytasks && scheduledevtodomonthlytasks && scheduleworktodomonthlytasks"


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


alias schedulemetodoyearlytasks="scheduleToDoYearlyTasks '$rootpath/Do/me/planner.md' '$rootpath/Do/me/todo.txt'"
alias scheduledevtodoyearlytasks="scheduleToDoYearlyTasks '$rootpath/Do/dev/planner.md' '$rootpath/Do/dev/todo.txt'"
alias scheduleworktodoyearlytasks="scheduleToDoYearlyTasks '$rootpath/Do/work/planner.md' '$rootpath/Do/work/todo.txt'"


scheduleBatchTodoYearlyTasks() {

    if [ $# -eq 1 ];
    then
        schedulemetodoyearlytasks "$1"
        scheduledevtodoyearlytasks "$1"
        scheduleworktodoyearlytasks "$1"
    else
        schedulemetodoyearlytasks
        scheduledevtodoyearlytasks
        scheduleworktodoyearlytasks
    fi

}


alias scheduletodoyearlytasks="scheduleBatchTodoYearlyTasks"

bumpDailyTodoItems(){

	local todofilepath=$1
	local todoundonefilepath=$2	
	local temptodopath=$todofilepath-".temp"
	
	grep -e "\day:[0-9][0-9]" $todofilepath >> $todoundonefilepath
	
	# thanks :  http://robots.thoughtbot.com/sed-102-replace-in-place
	sed -i '' -e "/day:[0-9][0-9]/d" $todofilepath
	
	# cp $todofilepath $temptodopath && sed -i -e "/+day\-[0-9][0-9]/d" $temptodopath && cat  $todofilepath && rm $temptodopath
	
}

alias bumpmetododailyitems="bumpDailyTodoItems  '$rootpath/Do/me/todo.txt' '$rootpath/Do/me/undone.txt' "
alias bumpdevtododailyitems="bumpDailyTodoItems  '$rootpath/Do/dev/todo.txt' '$rootpath/Do/dev/undone.txt' "
alias bumpworktododailyitems="bumpDailyTodoItems  '$rootpath/Do/work/todo.txt' '$rootpath/Do/work/undone.txt' "
alias bumptododailyitems="bumpmetododailyitems && bumpdevtododailyitems && bumpworktododailyitems"


bumpWeeklyTodoItems(){

	local todofilepath=$1
	local todoundonefilepath=$2
	
	grep -e "\week:[0-9][0-9]" $todofilepath >> $todoundonefilepath
	sed -i '' -e "/week:[0-9][0-9]/d" $todofilepath

}

alias bumpmetodoweeklyitems="bumpWeeklyTodoItems  '$rootpath/Do/me/todo.txt' '$rootpath/Do/me/undone.txt' "
alias bumpdevtodoweeklyitems="bumpWeeklyTodoItems  '$rootpath/Do/dev/todo.txt' '$rootpath/Do/dev/undone.txt' "
alias bumpworktodoweeklyitems="bumpWeeklyTodoItems  '$rootpath/Do/work/todo.txt' '$rootpath/Do/work/undone.txt' "
alias bumptodoweeklyitems="bumpmetodoweeklyitems && bumpdevtodoweeklyitems && bumpworktodoweeklyitems"

bumpMonthlyTodoItems(){

	local todofilepath=$1
	local todoundonefilepath=$2
	
	grep -e "\month:[0-9][0-9]" $todofilepath >> $todoundonefilepath
	sed -i '' -e "/month:[0-9][0-9]/d" $todofilepath

}

alias bumpmetodomonthlyitems="bumpMonthlyTodoItems '$rootpath/Do/me/todo.txt' '$rootpath/Do/me/undone.txt' "
alias bumpdevtodomonthlyitems="bumpMonthlyTodoItems '$rootpath/Do/dev/todo.txt' '$rootpath/Do/dev/undone.txt' "
alias bumpworktodomonthlyitems="bumpMonthlyTodoItems '$rootpath/Do/work/todo.txt' '$rootpath/Do/work/undone.txt' "
alias bumptodomonthlyitems="bumpmetodomonthlyitems && bumpdevtodomonthlyitems && bumpworktodomonthlyitems"

bumpYearlyTodoItems(){

	local todofilepath=$1
	local todoundonefilepath=$2
	
	grep -e "\year:[0-9][0-9][0-9][0-9]" $todofilepath >> $todoundonefilepath
	sed -i '' -e "/year:[0-9][0-9][0-9][0-9]/d" $todofilepath

}

alias bumpmetodoyearlyitems="bumpYearlyTodoItems '$rootpath/Do/me/todo.txt' '$rootpath/Do/me/undone.txt' "
alias bumpdevtodoyearlyitems="bumpYearlyTodoItems '$rootpath/Do/dev/todo.txt' '$rootpath/Do/dev/undone.txt' "
alias bumpworktodoyearlyitems="bumpYearlyTodoItems '$rootpath/Do/work/todo.txt' '$rootpath/Do/work/undone.txt' "
alias bumptodoyearlyitems="bumpmetodoyearlyitems && bumpdevtodoyearlyitems && bumpworktodoyearlyitems"


## bookmarks
OrganizeBookmarks() {

 	sed -E "s/\<li\>(.*)\<\/li\>/\1/g" <$rootpath/inbox/ril_export.html | \
	sed -E "s/(.*)time_added\=\"(.*)\" tags=\"(.*)\"/\2-\1\3/g" | \ 
 	sed -E "s/^(.*)$/\<li\>\1<\/li\>/g" >$rootpath/inbox/bookmarks.html \
 	&& pandoc --no-wrap -o $rootpath/inbox/bookmarks.md $rootpath/inbox/bookmarks.html \
 	&& open "$rootpath/inbox/bookmarks.md"
}
alias organizebookmarks=OrganizeBookmarks

### bash
alias clearhistory="history -c"
alias exportbashhistory="grep -v '^#' $HISTFILE >'$rootpath/docs/$today-bash history.txt'"
### todo.txt


alias dt='sh "$rootpath/Do/dev/todo.sh"'
alias mt='sh "$rootpath/Do/me/todo.sh"'
alias wt='sh "$rootpath/Do/work/todo.sh"'
alias doarchive="mt archive && wt archive && dt archive"
alias addddoreport="mt report && wt report && dt report"
alias devtodo='sh $rootpath/Do/dev/todo.sh list'
alias metodo='sh $rootpath/Do/me/todo.sh list'
alias worktodo='sh $rootpath/Do/work/todo.sh list'

alias devtodobirdseyereport="dt birdseye > '$rootpath/docs/$today-dev todo birdseye report for week-$weekCount.md'"
alias metodobirdseyereport="mt birdseye > '$rootpath/docs/$today-me todo birdseye report for week-$weekCount.md'"
alias worktodobirdseyereport="wt birdseye > '$rootpath/docs/$today-work todo birdseye report for week-$weekCount.md'"

alias addtodobirdseyereport="devtodobirdseyereport && metodobirdseyereport && worktodobirdseyereport"

mailPriorityToDo() {
	sed -n -e "s/(A)\(.*\)/* \1/p" <"$2" | mail -s "$today-$1" "lal.thomas.mail+todo@gmail.com"
}

alias mailmetodopriority="mailPriorityToDo 'me todo' '$rootpath/Do/me/todo.txt'" 
alias mailworktodopriority="mailPriorityToDo 'work todo' '$rootpath/Do/work/todo.txt'" 
alias maildevtodopriority="mailPriorityToDo 'dev todo' '$rootpath/Do/dev/todo.txt'" 
alias mailtodopriority="mailmetodopriority && mailworktodopriority && maildevtodopriority"


# //TODO : improve

addMeDoneItemsToJournal(){
	
	createMarkdownHeading "2" "Done Tasks" "$personaljournalfilepath"   
	mt listall "x $longdate" | sed -n -e 's/[0-9][0-9][0-9] x [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ \* /p'>>"$personaljournalfilepath"
}

addMeDoneItemsToYesterdayJournal(){

	createMarkdownHeading "2" "Done Tasks" "$yesterdayPersonalJournalFilename"   
	$1 listall "x $longyesterday" | sed -n -e 's/[0-9][0-9][0-9] x [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ \* /p'>>"$yesterdayPersonalJournalFilename"
}


alias addmedoneitemstojournal="addMeDoneItemsToJournal"
alias addmedoneitemstoyesterdayjournal="addMeDoneItemsToYesterdayJournal"

### git 

createGitRepo(){ 

 git init "$1"
 commitGitRepoChanges "$1" 'init repo' 
 
}

commitGitRepoChanges(){
	
	if [ $# -eq 2 ]; 
	then	
		commitMessage=$2		
	else		
		commitMessage="commit changes"
	fi
	
	cd "$1"	
	git add -A 
	git commit -m "$commitMessage"
	echo $1 "folder changes committed" 
	
}

alias commitdo="commitGitRepoChanges '$rootpath/Do/'"
alias commitreference="commitGitRepoChanges '$rootpath/Reference/'"
alias commitsupport="commitGitRepoChanges '$rootpath/Support/'"
alias commitscript="commitGitRepoChanges '$rootpath/scripts/source'"

createArticleRepository(){

	read -p "enter article name and press [enter]: " articlename		
	mkdir -p "$1/$today-$articlename"	
	createMarkdownHeading "1" "$articlename" "$1/$today-$articlename/$articlename".md			
	open "$1/$today-$articlename/$articlename".md
	createGitRepo "$1/$today-$articlename" >/dev/null
	echo "article repo created successfully"		
	
}


alias createblogpost="createArticleRepository '$rootpath/Blog'"
alias createwikiarticle="createArticleRepository '$rootpath/Office Wiki'"


# thanks https://www.gitignore.io/docs

# run creategitignore xcode >.gitignore

function creategitignore() { 

curl -L -s "https://www.gitignore.io/api/$@"

}

alias creategitignore=creategitignore


createProjectRepository(){

	local projectType=$2	
	
	if [ $# -eq 2 ]; 
	then
		read -p "enter project name and press [enter]: " projectname
	    #exit 1
	else
		export projectname="$3"	    
	fi		
	
	mkdir -p "$1/$today-$projectname"		
	local projectPath="$1/$today-$projectname"
	
	createMarkdownHeading "1" "ReadMe" "$projectPath/readme.md"

	case "$projectType" in
		xcode*) 
			creategitignore 'objective-c,osx'>"$projectPath/.gitignore" 		
			;; 
		momemtics*)		
			echo "Momentics gitignore not made"
		  ;;
		*) 
			echo "unknown: $OSTYPE" 
		 ;;
	esac
	
	createGitRepo "$projectPath" >/dev/null
	echo "project repo created successfully"
}

alias createxcodeproject="createProjectRepository '$rootpath/Office' 'xcode'"


AddTimeToFile(){

	local tag=$1
	local filename=$2

	echo "* $tag : $(date +'%T')" >> "$filename"

}

alias addcheckintimetoworkjournal="AddTimeToFile 'Checkin Time' '$workjournalfilepath'"
alias addcheckouttimetoworkjournal="AddTimeToFile 'Checkout Time' '$workjournalfilepath'"

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

StartDay(){
	
	commitdo
	commitreference
	commitsupport
	doarchive

}

StartMyDay(){		
		
    # bumpmetododailyitems && \ schedulemetododailytasks
	createmejournal	
	
	# GTD
	open "$rootpath/do/me/next.txt"
	open "$rootpath/do/me/contexts.md"
	open "$rootpath/do/me/projects.md"
	
}
alias startmeday=StartMyDay


StartWorkDay(){

    # bumpworktododailyitems && \	scheduleworktododailytasks
	createworkjournal
	addcheckintimetoworkjournal

	# Apps
	open -a "Xcode"
	open -a "firefox"
	open -a "thunderbird"
	open -a "skype"
	open -a "todotxtmac"
	#open -a "Momentics"

	# GTD
	open "$rootpath/do/work/next.txt"
	open "$rootpath/do/work/contexts.md"
	open "$rootpath/do/work/projects.md"


}

alias startworkday=StartWorkDay

StartDevDay(){

    # bumpdevtododailyitems && \ scheduledevtododailytasks
	createdevjournal
	
	# GTD
	open "$rootpath/do/dev/next.txt"
	open "$rootpath/do/dev/contexts.md"
	open "$rootpath/do/dev/projects.md"

}


alias startworkingday="StartDay && startmeday && startworkday && startbirthdayserver"
alias startholiday="StartDay && startmeday && startbirthdayserver"


EndDay(){

	echo ""

}

alias endday=EndDay


EndWorkDay(){

	addcheckouttimetoworkjournal	
	
}

alias endworkday=EndWorkDay

alias endworkingday="endday && endworkday"

StartWeek(){

	doarchive && \ 
	bumptodoweeklyitems
		
	if [ $# -eq 0 ]; 
	then
		scheduletodoweeklytasks	    		
	else
		scheduletodoweeklytasks "$1"		
	fi
	
	commitdo
}

alias startweek=StartWeek

StartMonth(){

	doarchive && \ 
	bumptodomonthlyitems && \
	scheduletodomonthlytasks && \
	commitdo
}

alias startmonth=StartMonth


StartYear(){

	doarchive && \ 
	bumptodoyearlyitems && \
	scheduletodoyearlytasks && \
	commitdo
}

alias startyear=StartYear


ConvertAllFilenamesToLower(){

	cd "$1"
	for f in *; do mv "$f" "`echo $f | tr "[:upper:]" "[:lower:]"`"; done

}

alias renamedocfilenamestolowercase="ConvertAllFilenamesToLower $rootpath/docs"



createDailyTodoPrintFile(){

    local COPYDIR="$rootpath/Docs"
    local printFile="$COPYDIR/$today-me daily todo print list for the month.md"

    echo >"$printFile"
    echo >"$printFile.html"

    for (( c=1; c<=31; c++ ))
    do

        local dayNum=$(printf "%02d" $c)
        createMarkdownHeading "2" "Day $dayNum" "$printFile"
        # truncate characters from interating marker day which includes interating symbol (here day) context and projects
        mt view context "day:$dayNum" | sed "s/day:.*//" >>"$printFile"

        # add page break after each day todos
        echo "<p style='page-break-after:always;'></p>">>"$printFile"
        printf "\n\n" >>"$printFile"

    done

    # Formatting the file
    sed -i '' -e "s/=====  Contexts  =====//" "$printFile"

    # thanks http://stackoverflow.com/a/7567839/2182047
    sed -i '' "s/--- \(.*\) ---/### \1 \\`echo -e '\r'`/" "$printFile"

    # remove double space with one space
    sed -i '' -e 's/  */ /g' "$printFile"

    # add li listing
    sed -i '' -e 's/^[0-9]\{4\}/ * &/g' "$printFile"

    # convert to markdown
    pandoc -o "$printFile.html" "$printFile"


}


createWeeklyTodoPrintFile(){


    local COPYDIR="$rootpath/Docs"
    local printFile="$COPYDIR/$today-me weekly todo print list for the month.md"

    echo >"$printFile"
    echo >"$printFile.html"

    weeklyTasks=($( mt list "week:" | grep -oh "week:[0-9][0-9]" | sort | uniq | grep -oh "[0-9][0-9]" ))

    for i in "${!weeklyTasks[@]}"
    do
        #echo "$i=>${weeklyTasks[i]}"

        createMarkdownHeading "2" "Week ${weeklyTasks[i]}" "$printFile"
        # truncate characters from interating marker day which includes interating symbol (here day) context and projects
        mt view context "week:${weeklyTasks[i]}" | sed "s/week:.*//" >>"$printFile"

        # add page break after each day todos
        echo "<p style='page-break-after:always;'></p>">>"$printFile"
        printf "\n\n" >>"$printFile"

    done

    # Formatting the file
    sed -i '' -e "s/=====  Contexts  =====//" "$printFile"

    # thanks http://stackoverflow.com/a/7567839/2182047
    sed -i '' "s/--- \(.*\) ---/### \1 \\`echo -e '\r'`/" "$printFile"

    # remove double space with one space
    sed -i '' -e 's/  */ /g' "$printFile"

    # add li listing
    sed -i '' -e 's/^[0-9]\{4\}/ * &/g' "$printFile"

    # convert to markdown
    pandoc -o "$printFile.html" "$printFile"


}


# remember the milk me update

# mt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "me todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# mt archive

# wt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "work todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# wt archive

# dt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "dev todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# dt archive

# Hidden Applications
# open -a 'FileMerge'"

# remove console colors using sed
# sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"

