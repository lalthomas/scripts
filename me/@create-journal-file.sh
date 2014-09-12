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
extension=".md"
calendarfilepath="$BASEDIR/calendar.txt"

case  $dayOfWeeK  in
      "Monday") 	
      	filetocopy="/planner-01-monday.md" 
      	filename=$today-"monday personal journal"$extension
      	;;
      "Tuesday")	
      	filetocopy="/planner-02-tuesday.md"
      	filename=$today-"tuesday personal journal"$extension
      	;;            
      	 
      "Wednesday")	
      	filetocopy="/planner-03-wednesday.md"
      	filename=$today-"wednesday personal journal"$extension
      	;;
      "Thursday") 	
      	filetocopy="/planner-04-thursday.md"
      	filename=$today-"thursday personal journal"$extension
      	;;
      "Friday") 	
      	filetocopy="/planner-05-friday.md"
      	filename=$today-"friday personal journal"$extension
      	;;
      "Saturday")	
      	filetocopy="/planner-06-saturday.md"
      	filename=$today-"saturday personal journal"$extension
      	;;
      "Sunday") 	
      	filetocopy="/planner-07-sunday.md"
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
  copyfilecontent=$(cat $BASEDIR"/planner-section.md")
  #copy contents to journal file
  echo "$copyfilecontent" >>"$journalfilepath"  

  
  # Read input file into a string variable. 
  # Thanks : http://stackoverflow.com/a/2789399/2182047
  copyfilecontent=$(cat $BASEDIR$filetocopy)  
  #copy contents to journal file
  echo "$copyfilecontent" | tr -d "\n" >>"$journalfilepath"
    
  
  mv "$journalfilepath" "$COPYDIR"/"$filename"

fi

# open the file

open "$COPYDIR"/"$filename"
