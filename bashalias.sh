# Hidden Applications

# open -a 'FileMerge'"

# remove console colors using sed
# sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"

case "$OSTYPE" in
	darwin*) export rootpath="/Users/rapid/Dropbox" ;; # OSX
	msys*) export rootpath="/d/Dropbox"  ;; # Windows
	*) echo "unknown: $OSTYPE" ;;
esac


mailtopocket() {

	echo "$1" | mail -s "$1" "add@getpocket.com"
}

alias mailtopocket=mailtopocket


createjournalfile(){

	COPYDIR="$rootpath/Docs"
	longdate=$(date "+%Y-%m-%d")
	today=$(date "+%Y%m%d")
	dayOfWeeK=$(date +%A)
	extension=".md"
	todofilepath="$rootpath/do/me/todo.txt"
	dayplannerfilepath="$rootpath/do/me/planner-day.txt"
	weekplannerfilepath="$rootpath/do/me/planner-week.txt"
	sectionplannerfilepath="$rootpath/do/me/planner-section.md"

	case  $dayOfWeeK  in
		  "Monday") 	
			dayOfWeekNum="1" 
			filename=$today-"monday personal journal"$extension
			;;
		  "Tuesday")	
			dayOfWeekNum="2"
			filename=$today-"tuesday personal journal"$extension
			;;            
		 
		  "Wednesday")	
			dayOfWeekNum="3"
			filename=$today-"wednesday personal journal"$extension
			;;
		  "Thursday") 	
			dayOfWeekNum="4"
			filename=$today-"thursday personal journal"$extension
			;;
		  "Friday") 	
			dayOfWeekNum="5"
			filename=$today-"friday personal journal"$extension
			;;
		  "Saturday")	
			dayOfWeekNum="6"
			filename=$today-"saturday personal journal"$extension
			;;
		  "Sunday") 	
			dayOfWeekNum="7"
			filename=$today-"sunday personal journal"$extension
			;;
		  *)              
	esac 

	journalfilepath="$rootpath/$filename"

	#printf $rootpath


	# check if file exists or not
	if [ ! -f "$COPYDIR"/"$filename" ];then

	  # put the date for heading	
	  printf $today >"$journalfilepath"
	  printf "\n" >>"$journalfilepath"
  
	  # markdown heading 1 label
	  printf "========" >>"$journalfilepath"  
	  printf "\n" >>"$journalfilepath"  
  
	  # add a blank line  
	  printf "\n">>"$journalfilepath"
  
	  printf Scheduled Tasks >>"$journalfilepath"  
	  # add markdown heading 2 label    
	  printf '\n%s' '---------' >>"$journalfilepath"    
  
	  # add a blank line  
	  printf "\n">>"$journalfilepath"   
	  # add a blank line  
	  printf "\n">>"$journalfilepath"
   
   
	  # Dump the today's scheduled task to todo.txt and extra line breaks
	  grep $longdate "$todofilepath" >>"$journalfilepath"
  
	  printf "\n">>"$journalfilepath"

	  # Read input file into a string variable. 
	  # Thanks : http://stackoverflow.com/a/2789399/2182047  
	  copyfilecontent=$(cat $sectionplannerfilepath)
	  #copy contents to journal file
	  printf "$copyfilecontent" >>"$journalfilepath"  
	  # add a blank line
	  printf "\n" >>"$journalfilepath"

	  # add a blank line  
	  printf "\n">>"$journalfilepath"
  
	  printf Routines >>"$journalfilepath"  
	  # add markdown heading 2 label
	  printf '\n%s' '---------' >>"$journalfilepath"    
	  # add a blank line  
	  printf "\n">>"$journalfilepath"
	  # add a blank line  
	  printf "\n">>"$journalfilepath"
   

	  #copy daily tasks to journal file  
	  # Read input file into a string variable. 
	  # Thanks : http://stackoverflow.com/a/2789399/2182047  
	  copyfilecontent=$(cat $dayplannerfilepath)
	  printf "$copyfilecontent" | sed 's/^/* \[\] /' >>"$journalfilepath"  
	  # add a blank line
	  printf "\n" >>"$journalfilepath"
	  # add weekly tasks 
	  grep $dayOfWeekNum "$weekplannerfilepath" | sed 's/^'$dayOfWeekNum'/* \[\]/' >> "$journalfilepath"
   
	  mv "$journalfilepath" "$COPYDIR"/"$filename"

	fi

	# open the file

	open "$COPYDIR"/"$filename"

}

alias createjournal=createjournalfile


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

alias schedulemetodoweeklytasks="scheduleToDoWeeklyTasks '$rootpath/Do/me/predefined-works.md' '$rootpath/Do/me/todo.txt'"
alias scheduledevtodoweeklytasks="scheduleToDoWeeklyTasks '$rootpath/Do/dev/predefined-works.md' '$rootpath/Do/dev/todo.txt'"
alias scheduleworktodoweeklytasks="scheduleToDoWeeklyTasks '$rootpath/Do/work/predefined-works.md' '$rootpath/Do/work/todo.txt'"

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

alias schedulemetodomonthlytasks="scheduleToDoMonthlyTasks '$rootpath/Do/me/predefined-works.md' '$rootpath/Do/me/todo.txt'"
alias scheduledevtodomonthlytasks="scheduleToDoMonthlyTasks '$rootpath/Do/dev/predefined-works.md' '$rootpath/Do/dev/todo.txt'"
alias scheduleworktodomonthlytasks="scheduleToDoMonthlyTasks '$rootpath/Do/work/predefined-works.md' '$rootpath/Do/work/todo.txt'"


## bookmarks

OrganizeBookmarks() {

sed -E "s/\<li\>(.*)\<\/li\>/\1/g" <$rootpath/inbox/ril_export.html | \
sed -E "s/(.*)time_added\=\"(.*)\" tags=\"(.*)\"/\2-\1\3/g" | \ 
sed -E "s/^(.*)$/\<li\>\1<\/li\>/g" >$rootpath/inbox/bookmarks.html \
&& pandoc --no-wrap -o $rootpath/inbox/bookmarks.md $rootpath/inbox/bookmarks.html \
&& open "$rootpath/inbox/bookmarks.md"'

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


### git 

alias commitdo='sh "$rootpath/Do/commit-do-changes.sh"'
alias commitreference='sh $rootpath/Reference/@commit-changes.sh"'
alias commitsupport='sh "$rootpath/Support/@commit-changes.sh"'
alias createblog='sh "$rootpath/Blog/create-blog-post-repo.sh"'
alias createwiki='sh "$rootpath/Office Wiki/create-wiki-post-repo.sh"'



# remember the milk me update

# mt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "me todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# mt archive

# wt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "work todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# wt archive

# dt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "dev todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# dt archive
