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

### todo file paths

export doRootPath="$rootPath/action/20140310-do"
export doPlannerFile="$doRootPath/planner.md"
export doTodoFile="$doRootPath/todo.txt"
export doInvalidFile="$doRootPath/invalid.txt"
export doJournalPath="$doRootPath/journal.md"
export doLogPath="$doRootPath/log.txt"

### reference

export referenceRootPath="$rootPath/reference"

### support

export supportRootPath="$rootPath/support"


### docs

export docRootPath="$rootPath/docs"	
export docJournalFile="$docRootPath/$today-journal.md"
export docYesterdayJournalFile="$docRootPath/$yesterday-journal.md"


openFile(){

# open the file
	# open command don't work on windows	
	case "$OSTYPE" in
	cygwin*)		
		 "C:/Program Files (x86)/Notepad++/notepad++.exe" "$1"
		;;	
	darwin*) 
		# OSX		
		open  "$1"		
		;; 
	msys*)
		# Windows
		start ""  "$1"
		;; 		
	*) 
		echo "unknown: $OSTYPE" 
		;;
	esac
}