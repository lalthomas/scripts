@echo ON
REM Author Lal Thomas (lal.thomas.mail@gmail.com)
REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM starting of Program
setlocal
%~d1
cd "%~p1"

REM copy the html headers
type "%scriptFolderPath%\templates\20151224-blog html head.txt" >Blog.html
if not exist info.txt (type "%scriptFolderPath%\templates\20151224-blog info template.txt" >info.txt)

REM making a copy of info.txt for parsing
copy info.txt info-parse.txt
set s=1
REM Parse the info.txt file to retrieve each section
echo Parsing info-parse.txt file...
:start1
	set path="%scriptFolderPath%\tools\csplit"
	if exist info-parse.txt (csplit -s -z info-parse.txt /[@@]/1) 
	del info-parse.txt
	if EXIST xx01 (ren xx01 info-parse.txt) else (goto EndOfSec1)		
	::xx00 contain first extracted section
	::xx01 contain remaining sections
	if EXIST xx00 (type "%scriptFolderPath%\BlogMetaTem_%s%.txt" xx00 >>Blog.html)
	set /a s=s+1	
if exist info-parse.txt (goto start1) 
:EndOfSec1
type "%scriptFolderPath%\BlogMetaTem_%s%.txt" xx00 >>Blog.html
del xx00
echo ^"^> >>Blog.html

REM Removing @ that are joined to output file
set path="%scriptFolderPath%\tools\rxfind"
rxfind Blog.html /B:2 /P:[@@] /R:


pause
endlocal
