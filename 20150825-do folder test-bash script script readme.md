% 20150825-do-bash script-testing script readme.md 	
% 2016-10-29 	
% Lal Thomas 	
% D:\Dropbox\action\20131027-scripts project\20150825-do-bash script-testing script.sh 	
	
Testing Checklist
-----------------

* is `currentScriptFolder` variable is echoing the correct current folder like `/cygdrive/d/Dropbox/action/20131027-scripts project` 
* is `rootPath` variable getting right OS and path like `d:/Dropbox`
* is `doRootPath` variable getting the right path to the do folder like `d:/Dropbox/action/20140310-do`
* is typing `t` produces the following similar output as follows 

	Usage: todo.sh [-fhpantvV] [-d todo_config] action [task_number] [task_descripti                                                                                      on]
	Try 'todo.sh -h' for more information.

* is typing `todo` produces following similar output 

	[a list of text from the todo.txt file]

* is typing `todoarchive` produces output similar to the following

	TODO:  d:/Dropbox/action/20140310-do/todo.txt archived.

* is typing `addreport` produces output similar to the following

	TODO:  d:/Dropbox/action/20140310-do/todo.txt archived.
	2015-08-25T23:19:26 1890 7043
	TODO: Report file updated.

* is typing `addtodobirdseyereport` produces the similar output

	(a file with filename similar to `20150825-todo birdseye report for week-35.md` is created on docs folder)

* is typing `scheduletododailytasks` produces the similar output

	(contend filter with daily items as added to todo.txt )
	
