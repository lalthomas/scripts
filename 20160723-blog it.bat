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
type "%scriptFolderPath%\templates\20151224-blog.html head.txt" >blog.html
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
	if EXIST xx00 (type "%scriptFolderPath%\BlogMetaTem_%s%.txt" xx00 >>blog.html)
	set /a s=s+1	
if exist info-parse.txt (goto start1) 
:EndOfSec1
type "%scriptFolderPath%\BlogMetaTem_%s%.txt" xx00 >>blog.html
del xx00
echo ^"^> >>blog.html
REM Removing @ that are joined to output file
set path="%scriptFolderPath%\tools\rxfind"
rxfind blog.html /B:2 /P:[@@] /R:
type "%scriptFolderPath%\templates\20151224-blog.html meta.txt" >blog.html
type "%scriptFolderPath%\templates\20151224-blog header include template%~x1%" >>blog.html
type "%scriptFolderPath%\templates\20151224-blog header style.txt" >>blog.html
REM Creating Code Explanation with Comment file
copy "????????-blog remarks.txt" comment.temp
if NOT EXIST "20151224-blog remarks.txt" (copy "%scriptFolderPath%\templates\20151224-blog remarks.txt" "20151224-blog remarks.txt")
::*********************************************************

REM type %scriptFolderPath%\templates\20151224-blog body start.txt >>blog.html

@echo OFF
REM This adds a <BR> to every line of Comment file
::set path=%path%;"E:\Devel\Mis\Find"
::fart -qC comment.temp \r "<BR>"\r
::fart -qC comment.temp "@<BR>" "@"
::fart -qC comment.temp \n \n"<p>"
::fart -qC comment.temp \r "</p>"\r
::*********************************************************
REM Parse the comment file to retrieve the first section
set path="%scriptFolderPath%\tools\csplit"
if exist comment.temp (csplit -s -z comment.temp /[@@]/1) 
del comment.temp
@echo ON
if EXIST xx01 (ren xx01 comment.temp) else (goto EndOfSec)
if EXIST xx00 (type "%scriptFolderPath%\templates\20151224-blog body template 01.txt" xx00 >>blog.html)
type "%scriptFolderPath%\templates\20151224-blog body program section.txt" >>blog.html
if /i "%~x1" == ".c" (echo ^<PRE class="brush:c;"^>  >>blog.html)
if /i "%~x1" == ".php" (echo ^<PRE class="brush:php;"^>  >>blog.html)
if /i "%~x1" == ".cpp" (echo ^<PRE class="brush:cpp;"^>  >>blog.html)
if /i "%~x1" == ".cs" (echo ^<PRE class="brush:csharp;"^>  >>blog.html)
if /i "%~x1" == ".vb" (echo ^<PRE class="brush:vb;"^>  >>blog.html)
if /i "%~x1" == ".java" (echo ^<PRE class="brush:java;"^>  >>blog.html)
if /i "%~x1" == ".html" (echo ^<PRE class="brush:html;"^>  >>blog.html)
if /i "%~x1" == ".xml" (echo ^<PRE class="brush:xml;"^>  >>blog.html)
if /i "%~x1" == ".css" (echo ^<PRE class="brush:css;"^>  >>blog.html)
if /i "%~x1" == ".js" (echo ^<PRE class="brush:js;"^>  >>blog.html)
if /i "%~x1" == ".sql" (echo ^<PRE class="brush:sql;"^>  >>blog.html)
REM This is to convert the special characters in the program to HTML equivalent
copy %1 temp12.html
set path="%scriptFolderPath%\tools\htb"
call htb /ke4 "%CD%\temp12.html" "%CD%\temp13.html"
REM This is to remove the head section that is generated in the previous stage
set path="%scriptFolderPath%\tools\fart"
fart -qC temp13.html "<HTML><BODY><PRE>\r"  " "
fart -qC temp13.html "</PRE></BODY></HTML>\r" " "
REM Output the formated program html to the blog
type temp13.html >>blog.html
del temp12.html temp13.html 
REM Add a closing PRE tag to the blog
echo ^</PRE^>  >>blog.html
REM  Add output to the Blog
set /a s=1
set /a sect=7
:CHECKPOINT
	if EXIST "capture-%s%.jpg" (goto MORE)
	goto CONT
	:MORE
	echo ^<DIV id="sect%sect%"^> >>blog.html
	echo ^<DIV class="secthead"^>  >>blog.html
	echo ^<H4^>OUTPUT - %s%^</H4^>  >>blog.html
	echo ^</DIV^> >>blog.html
	echo ^<DIV class="sectbody"^> >>blog.html
	echo ^<img alt=^" >>blog.html
	REM Add the output of program as ALT text
	call "%~n1.exe" >>blog.html
	echo ^" title=^"OUTPUT^" border=^"0^" hspace=^"0^" src=^"file:///%CD%\capture-%s%.jpg^" vspace=^"0^"^> >>blog.html
	echo ^</DIV^>^</DIV^> >>blog.html
	set /a s=s+1
	set /a sect=sect+1
goto CHECKPOINT
:CONT

REM Parse the comment file to retrieve the remaining sections
@echo ON
set s=2
set /a flag=0
echo Parsing comment file...
:start
    set path="%scriptFolderPath%\tools\csplit"
    if exist comment.temp (csplit -s -z comment.temp /[@@]/1) 
    del comment.temp
    if EXIST xx01 (ren xx01 comment.temp) else (goto EndOfSec)
    set /a flag=1
    @echo ON
    ::xx00 contain first extracted section
    ::xx01 contain remaining sections	
    if EXIST xx00 (type "%scriptFolderPath%\templates\20151224-blog body template 0%s%.txt" xx00 >>blog.html)
    set /a s=s+1
    @echo OFF
if exist comment.temp (goto start) 
:EndOfSec
::This is of special case of having only one section in Remarks file
if %flag% EQU 0 (type "%scriptFolderPath%\templates\20151224-blog body template 01.txt" xx00 >>blog.html)
del xx00

type "%scriptFolderPath%\templates\20151224-blog body div closing.txt" >>blog.html

REM Removing @ that are joined to output file
set path="%scriptFolderPath%\tools\rxfind"
rxfind blog.html /B:2 /P:[@@] /R:

REM This is to avoid the illeffect of removing @ from Blog
set path="%scriptFolderPath%\tools\fart"
fart -qC blog.html "lal.thomas.mailgmail.com" "lal.thomas.mail@gmail.com"

REM  Add closing tags to Blog
type "%scriptFolderPath%\templates\20151224-blog body div closing 02.txt" >>blog.html

REM Properly indent the output file
call "%scriptFolderPath%\20101119-pretty print html file-dos batch script.bat" "%CD%\blog.html"
call "%scriptFolderPath%\20131027-dev-beautify source code-dos batch script.bat" "%CD%\blog.html"

pause
endlocal
