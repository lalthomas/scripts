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

export doRootPath="$rootPath/do"
export referenceRootPath="$rootPath/do/reference"
export supportRootPath="$rootPath/do/support"
export toolsRootPath="$rootPath/tool"
export docRootPath="$rootPath/doc"	
export doPlannerFile="$doRootPath/planner.md"
export doInvalidFile="$doRootPath/invalid.txt"
export doTodoFile="$doRootPath/todo.txt"
export doJournalPath="$doRootPath/journal.md"
export doLogPath="$doRootPath/log.txt"
export docJournalFile="$docRootPath/$today-journal.md"
export docYesterdayJournalFile="$docRootPath/$yesterday-journal.md"



