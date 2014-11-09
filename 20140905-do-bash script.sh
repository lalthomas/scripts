#!/bin/bash -x

# Hidden Applications
# open -a 'FileMerge'"

# remove console colors using sed
# sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"

# initialize global variables 

longdate=$(date "+%Y-%m-%d")
today=$(date "+%Y%m%d")
dayOfWeeK=$(date +%A)
dayOfWeekLowerCase=$(date +%A | sed -e 's/\(.*\)/\L\1/')
currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

case "$OSTYPE" in
	darwin*) export rootpath="/Users/rapid/Dropbox" ;; # OSX
	msys*) export rootpath="/d/Dropbox"  ;; # Windows
	*) echo "unknown: $OSTYPE" ;;
esac

journalfilename=$today-$dayOfWeekLowerCase" personal journal"$extension
journalfilepath="$rootpath/$journalfilename"


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
	local extension=".md"
	local todofilepath="$rootpath/do/me/todo.txt"
	local plannerfilepath="$rootpath/do/me/planner.md"
	local sectionplannerfilepath="$rootpath/do/me/planner-section.md"	

	#printf $rootpath


	# check if file exists or not
	if [ ! -f "$COPYDIR"/"$journalfilename" ];then

	  createMarkdownHeading "1" "$today" "$journalfilepath"
	  
	  createMarkdownHeading "2" "Scheduled Tasks" "$journalfilepath"   
	  # Dump the today's scheduled task to todo.txt and extra line breaks
	  grep $longdate "$todofilepath" >>"$journalfilepath"
	  printf "\n">>"$journalfilepath"

	  # Read input file into a string variable. 
	  # Thanks : http://stackoverflow.com/a/2789399/2182047  
	  copyfilecontent=$(cat $sectionplannerfilepath)
	  #copy contents to journal file
	  printf "$copyfilecontent" >>"$journalfilepath"  
	  # add two blank line
	  printf "\n\n" >>"$journalfilepath"	  	  
 	  
	  mv "$journalfilepath" "$COPYDIR"/"$journalfilename"

	fi

	# open the file
	# open command don't work on windows	
	case "$OSTYPE" in
	darwin*) 
		# OSX		
		open "$COPYDIR"/"$journalfilename"		
		;; 
	msys*)
		# Windows
		start "" "$COPYDIR"/"$journalfilename"
		;; 		
	*) 
		echo "unknown: $OSTYPE" 
		;;
	esac
}
alias createjournal=createjournalfile

scheduleToDoDailyTasks() {

	if [ $# -eq 2 ]; 
	then
		export referencedate=$(date "+%Y-%m-%d")	
	    #exit 1
	else
		export referencedate="$3"	    
	fi
	
	sed -n -e "s/\+day-NN/\+day-$(date +'%d')/p" <"$1" | \
	sed -n -e "s/\*[[:blank:]]//p" | \
	sed -n -e "s/^/$referencedate /p" | \
	sort -n | \
	uniq | \
	tr '\r' ' '>>$2
	
}

alias schedulemetododailytasks="scheduleToDoDailyTasks '$rootpath/Do/me/planner.md' '$rootpath/Do/me/todo.txt'"
alias scheduledevtododailytasks="scheduleToDoDailyTasks '$rootpath/Do/dev/planner.md' '$rootpath/Do/dev/todo.txt'"
alias scheduleworktododailyytasks="scheduleToDoDailyTasks '$rootpath/Do/work/planner.md' '$rootpath/Do/work/todo.txt'"

scheduleToDoWeeklyTasks() {

	if [ $# -eq 2 ]; 
	then
		export referencedate=$(date "+%Y-%m-%d")	
	    #exit 1
	else
		export referencedate="$3"	    
	fi
	
	sed -n -e "s/\+week-NN/\+week-$(date +'%W')/p" <"$1" | \
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
	
}
alias schedulemetodoweeklytasks="scheduleToDoWeeklyTasks '$rootpath/Do/me/planner.md' '$rootpath/Do/me/todo.txt'"
alias scheduledevtodoweeklytasks="scheduleToDoWeeklyTasks '$rootpath/Do/dev/planner.md' '$rootpath/Do/dev/todo.txt'"
alias scheduleworktodoweeklytasks="scheduleToDoWeeklyTasks '$rootpath/Do/work/planner.md' '$rootpath/Do/work/todo.txt'"
scheduleToDoMonthlyTasks() {

	if [ $# -eq 2 ]; 
	then
		export referencedate=$(date -v -Mon "+%Y-%m-%d")
	else
		export referencedate=$(date -j -v "mon" -f '%Y-%m-%d' "$3" +%Y-%m-%d)	    
	fi
	
	sed -n -e "s/\+month-NN/\+month-$(date +'%m')/p" <"$1" | \
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
## bookmarks
OrganizeBookmarks() {

sed -E "s/\<li\>(.*)\<\/li\>/\1/g" <$rootpath/inbox/ril_export.html | \
sed -E "s/(.*)time_added\=\"(.*)\" tags=\"(.*)\"/\2-\1\3/g" | \ 
sed -E "s/^(.*)$/\<li\>\1<\/li\>/g" >$rootpath/inbox/bookmarks.html \
&& pandoc --no-wrap -o $rootpath/inbox/bookmarks.md $rootpath/inbox/bookmarks.html \
&& open "$rootpath/inbox/bookmarks.md"
}
alias organizebookmarks=OrganizeBookmarks
StartDay(){

	#!/bin/bash
	# Apps
	open -a "firefox"
	open -a "Momentics"
	# open -a "Xcode-5-1"
	open -a "thunderbird"
	# open -a "todotxtmac"
	# open -a "qtodotxt"

	# GTD

	open "$rootpath/do/birthdays.md"
	open "$rootpath/do/work/todo.txt"
	open "$rootpath/do/work/done.txt"
	open "$rootpath/do/me/todo.txt"
	open "$rootpath/do/me/done.txt"
	
	sh "$rootpath/do/me/@schedule-to-todo.sh"
	sh "$rootpath/do/me/@create-journal-file.sh"
	sh "$rootpath/do/work/@schedule-to-todo.sh"
	sh "$rootpath/do/work/@create-journal-file.sh"
	
	python "/Users/rapid/Dropbox/scripts/python-simplehttpserver-with-markdown.py"

}
alias startday=StartDay
### bash
alias clearhistory="history -c"
alias exportbashhistory="grep -v '^#' $HISTFILE >'$rootpath/Office Docs/work bash history.txt'"
### todo.txt
alias doarchive="mt archive && wt archive && dt archive"
alias devtodo='sh $rootpath/Do/dev/todo.sh list'
alias devtodobirdseyereport="dt birdseye > '$rootpath/Office Docs/dev todo birdseye report for week-.md'"
alias dt='sh "$rootpath/Do/dev/todo.sh"'
alias metodo='sh $rootpath/Do/me/todo.sh list'
alias metodobirdseyereport="mt birdseye > '$rootpath/Office Docs/me todo birdseye report for week-.md'"
alias mt='sh "$rootpath/Do/me/todo.sh"'
alias worktodo='sh $rootpath/Do/work/todo.sh list'
alias worktodobirdseyereport="wt birdseye > '$rootpath/Docs/work todo birdseye report for week-.md'"
alias wt='sh "$rootpath/Do/work/todo.sh"'

addMeDoneItemsToJournal(){
	mt listall "x $longdate" | sed -n -e 's/[0-9][0-9][0-9] x [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ \* /p' >> "$journalfilepath"
}
alias addmedoneitemstojournal="addMeDoneItemsToJournal"


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
	git add * -A 
	git commit -m "$commitMessage"
	echo $1 "folder changes committed" 
	
}

alias commitdo="commitGitRepoChanges '$rootpath/Do/'"
alias commitreference="commitGitRepoChanges '$rootpath/Reference/'"
alias commitsupport="commitGitRepoChanges '$rootpath/Support/'"
alias commitscript="commitGitRepoChanges '$rootpath/scripts/source'"

createBlogPostRepository(){

	read -p "enter article name and press [enter]: " articlename		
	mkdir -p "$1/$today-$articlename"	
	echo "$articlename" > "$1/$today-$articlename/$articlename".md			
	createGitRepo "$1/$today-$articlename" >/dev/null
	echo "article repo created successfully"	
	open "$DIR/$articlename/$articlename".md
	
}

alias createblogpost="createBlogPostRepository '$rootpath/Blog'"
alias createwiki="createBlogPostRepository '$rootpath/Office Wiki'"

# remember the milk me update

# mt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "me todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# mt archive

# wt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "work todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# wt archive

# dt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "dev todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# dt archive
