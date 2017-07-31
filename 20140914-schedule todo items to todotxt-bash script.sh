# Dump the today's scheduled task to todo.txt

BASEDIR=$(dirname $0)
calendarfilepath="$BASEDIR/calendar.txt"
todofilepath="$BASEDIR/todo.txt"

# find the string and remove the double of the result returned by grep
  
grep $longdate "$calendarfilepath" | tr -d "\n" >> "$todofilepath"