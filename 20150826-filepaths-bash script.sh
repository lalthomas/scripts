# find the OS type for rootPath

export scriptfolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

case "$OSTYPE" in
	
	darwin*) 
	# OSX
	export rootPath="/Users/"
	;; 
	
	msys*) 
	# Windows
	export rootPath="/d/"
	export eRootPath="/e/"
	;;
	
	cygwin*) 
	# Windows
	export rootPath="d:/"
	export eRootPath="e:/"
	;;
	
	*) 
	echo "unknown: $OSTYPE"
	;;
	
esac

### do file paths
export doRootPath="$rootPath/do"
export doPlannerFile="$doRootPath/planner.md"
export doInvalidFile="$doRootPath/invalid.txt"
export doTodoFile="$doRootPath/todo.txt"
export doLogPath="$doRootPath/log.txt"
export doLessonPath="$doRootPath/lessons.txt"
export referenceRootPath="$doRootPath/reference"
export supportRootPath="$doRootPath/support"

## other files
export toolsRootPath="$eRootPath/scripts"
export docRootPath="$rootPath/doc"	

