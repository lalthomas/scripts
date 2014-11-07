#!/bin/bash

# Run by typing sh /Users/rapidvalue/Dropbox/do/me/@create-journal-file.sh

# set path from the script location 
# thanks : http://stackoverflow.com/a/246128/2182047
# thanks : http://unix.stackexchange.com/a/26059

BASEDIR=$(dirname $0)
COPYDIR="/Users/rapid/Dropbox/Docs"
PATH=$PATH:$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
longdate=$(date "+%Y-%m-%d")
today=$(date "+%Y%m%d")
dayOfWeeK=$(date +%A)
dayOfWeekNum =$(date +%U)
extension=".md"
calendarfilepath="$BASEDIR/calendar.txt"
dayplannerfilepath="$BASEDIR/planner-day.txt"
weekplannerfilepath="$BASEDIR/planner-week.txt"
sectionplannerfilepath="$BASEDIR/planner-section.md"

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

journalfilepath="$BASEDIR/$filename"

#echo $BASEDIR


# check if file exists or not
if [ ! -f "$COPYDIR"/"$filename" ];then

  # put the date for heading	
  echo $today >"$journalfilepath"
  # markdown heading 1 label
  echo ======== >>"$journalfilepath"  
  
  # add a blank line
  echo >>"$journalfilepath"  
  
  echo Scheduled Tasks >>"$journalfilepath"  
  # add markdown heading 2 label
  echo --------------- >>"$journalfilepath"  
  # add a blank line
  echo >>"$journalfilepath"  
  
  # Dump the today's scheduled task to todo.txt and extra line breaks
  grep $longdate "$calendarfilepath"  | tr -d "\n" >> "$journalfilepath"

  # Read input file into a string variable. 
  # Thanks : http://stackoverflow.com/a/2789399/2182047  
  copyfilecontent=$(cat $sectionplannerfilepath)
  #copy contents to journal file
  echo "$copyfilecontent" >>"$journalfilepath"  
  # add a blank line
  echo >>"$journalfilepath"  

  echo Routines >>"$journalfilepath"  
  # add markdown heading 2 label
  echo -------- >>"$journalfilepath" 
  # add a blank line
  echo >>"$journalfilepath"  

  #copy daily tasks to journal file  
  # Read input file into a string variable. 
  # Thanks : http://stackoverflow.com/a/2789399/2182047  
  copyfilecontent=$(cat $dayplannerfilepath)
  echo "$copyfilecontent"  | sed 's/^/* \[\] /' >>"$journalfilepath"  
  # add a blank line
  echo >>"$journalfilepath"  
  # add weekly tasks 
  # | tr -d "\n"
  grep $dayOfWeekNum "$weekplannerfilepath" | sed 's/^'$dayOfWeekNum'/* \[\]/' >> "$journalfilepath"
   
  mv "$journalfilepath" "$COPYDIR"/"$filename"

fi

# open the file

open "$COPYDIR"/"$filename"
