@echo OFF
REM copy date part of eml files to clipboard
REM Lal Thomas
REM 2016-10-27


REM create empty byte file
copy NUL temp.tmp
REM start of file looping
setlocal enabledelayedexpansion
for %%a in ( *.eml ) do (    
	set filename=%%a	
	set year=!filename:~0,4!
	set month=!filename:~4,2!
	set day=!filename:~6,2!	
	echo !year!-!month!-!day! >>temp.tmp
)
set /p names=<temp.tmp
clip<temp.tmp && del temp.tmp
