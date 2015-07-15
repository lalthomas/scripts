# Filename : 20150715-journal-bash script.sh
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

extension=".md"
journalfilename=$today-$dayOfWeeK" journal"$extension
journalfilepath="$rootpath/docs/$journalfilename"
yesterdayjournalfilename=$yesterday-$dayofWeekYesterday" journal"$extension
yesterdayjournalfilepath="$rootpath/docs/$yesterdayjournalfilename"

# journal utlity functions

createJournalFile(){

	local todofolder="$1"
	local copydir="$2"
	local journalname="$3"
	local todofilepath="$todofolder/todo.txt"
	local journalpath="$copydir/$journalname"
	local plannerfilepath="$todofolder/planner.md"
	local sectionplannerfilepath="$todofolder/journal.md"	

	#printf $rootpath


	# check if file exists or not
	if [ ! -f "$copydir"/"$journalname" ];then

	  createMarkdownHeading "1" "$today" "$journalpath"	  
	  createMarkdownHeading "2" "Scheduled Tasks" "$journalpath"   
	  
	  # Dump the today's scheduled task to todo.txt and extra line breaks	  
	  sed -n -e 's/'$longdate'/* &/p'<"$todofilepath" >>"$journalpath"
	  printf "\n">>"$journalpath"

	  # Read input file into a string variable. 
	  # Thanks : http://stackoverflow.com/a/2789399/2182047  
	  copyfilecontent=$(cat "$sectionplannerfilepath")
	  #copy contents to journal file
	  printf "$copyfilecontent" >>"$journalpath"  
	  # add two blank line
	  printf "\n\n" >>"$journalpath"	  	   	  
	  mv "$journalpath" "$copydir"/"$journalname"

	fi

	# open the file
	# open command don't work on windows	
	case "$OSTYPE" in
	darwin*) 
		# OSX		
		open "$copydir"/"$journalname"		
		;; 
	msys*)
		# Windows
		start "" "$copydir"/"$journalname"
		;; 		
	*) 
		echo "unknown: $OSTYPE" 
		;;
	esac
}

# //TODO : improve

addMyDoneItemsToJournal(){

createMarkdownHeading "2" "Done Tasks" "$journalfilepath"
t listall "x $longdate" | sed -n -e 's/[0-9][0-9][0-9] x [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ \* /p'>>"$journalfilepath"
}

addMyDoneItemsToYesterdayJournal(){

	## //TODO : improve
	createMarkdownHeading "2" "Done Tasks" "$yesterdayjournalfilename"
	$1 listall "x $longyesterday" | sed -n -e 's/[0-9][0-9][0-9] x [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ \* /p'>>"$yesterdayjournalfilename"

}

alias adddoneitemstomyjournal="addMyDoneItemsToJournal"
alias adddoneitemstoyesterdaymyjournal="addMyDoneItemsToYesterdayJournal"

alias createmyjournal="createJournalFile '$rootpath/do' '$rootpath/docs' '$journalfilename'"
alias createjournal="createmyjournal && createworkjournal && createdevjournal"

AddTimeToFile(){

	local tag=$1
	local filename=$2
	echo "* $tag : $(date +'%T')" >> "$filename"

}

alias addcheckintimetoworkjournal="AddTimeToFile 'Checkin Time' '$workjournalfilepath'"
alias addcheckouttimetoworkjournal="AddTimeToFile 'Checkout Time' '$workjournalfilepath'"
