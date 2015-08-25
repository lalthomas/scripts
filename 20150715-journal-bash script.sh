# Filename : 20150715-journal-bash script.sh
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)


# journal utlity functions

createJournalFile(){
		
	# check if file exists or not
	if [ ! -f "$docJournalFile" ];then

	  createMarkdownHeading "1" "$today $dayOfWeeK Journal" "$docJournalFile"
	  createMarkdownParagraph "normal" "*Date of Creation* : $longdate" "$docJournalFile"	  
	  createMarkdownHeading "2" "Scheduled Tasks" "$docJournalFile"   
	  
	  # Dump the today's scheduled task to todo.txt and extra line breaks	  
	  sed -n -e 's/'$longdate'/* &/p'<"$doTodoFile" >>"$docJournalFile"
	  printf "\n">>"$docJournalFile"

	  # Read input file into a string variable. 
	  # Thanks : http://stackoverflow.com/a/2789399/2182047  
	  copyfilecontent=$(cat "$doJournalPath")
	  #copy contents to journal file
	  printf "$copyfilecontent" >>"$docJournalFile"  
	  # add two blank line
	  printf "\n\n" >>"$docJournalFile"	  

	fi

	# open the file
	# open command don't work on windows	
	case "$OSTYPE" in
	darwin*) 
		# OSX		
		open "$docJournalFile"		
		;; 
	msys*)
		# Windows
		start "" "$docJournalFile"
		;; 		
	*) 
		echo "unknown: $OSTYPE" 
		;;
	esac
}

# //TODO : improve

addMyDoneItemsToJournal(){

	createMarkdownHeading "2" "Done Tasks" "$docJournalFile"
	t listall "x $longdate" | sed -n -e 's/[0-9][0-9][0-9] x [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ \* /p'>>"$docJournalFile"
}

addMyDoneItemsToYesterdayJournal(){

	## //TODO : improve
	createMarkdownHeading "2" "Done Tasks" "$docYesterdayJournalFile"
	$1 listall "x $longyesterday" | sed -n -e 's/[0-9][0-9][0-9] x [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ \* /p'>>"$docYesterdayJournalFile"

}

log(){
	
	echo "$now $@">> $doLogPath
}

alias addcheckintimetolog="log 'checkin' "
alias addcheckouttimetolog="log 'checkout'"
