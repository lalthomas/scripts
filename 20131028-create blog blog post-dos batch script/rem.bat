
::pause
::*********************************************************
@echo ON
type D:\Dropbox\action\20131027-scripts project\BlogHead2.txt >>Blog.html 
type D:\Dropbox\action\20131027-scripts project\Blog%~x1% >>Blog.html
::pause
type D:\Dropbox\action\20131027-scripts project\BlogStyle.txt >>Blog.html
REM Destructive be careful
REM type %scriptFolderPath%\BlogBodyStart.txt >Blog.html
REM @echo OFF
::*********************************************************


::*********************************************************
@echo OFF
REM Creating Code Explanation with Comment file
copy Remarks.txt Comment.txt
if NOT EXIST Remarks.txt (copy %scriptFolderPath%\Remarks.txt Remarks.txt)
::*********************************************************
@echo OFF
REM This adds a <BR> to every line of Comment file
::set path=%path%;"E:\Devel\Mis\Find"
::fart -qC Comment.txt \r "<BR>"\r
::fart -qC Comment.txt "@<BR>" "@"
::fart -qC Comment.txt \n \n"<p>"
::fart -qC Comment.txt \r "</p>"\r
::*********************************************************
REM Parse the Comment file to retrieve the first section
set path=%path%;%scriptFolderPath%\Tools
if exist Comment.txt (csplit -s -z Comment.txt /[@@]/1) 
del Comment.txt
@echo ON
if EXIST xx01 (ren xx01 Comment.txt) else (goto EndOfSec)
if EXIST xx00 (type %scriptFolderPath%\BlogTem_1.txt xx00 >>Blog.html)
@echo OFF
::*********************************************************

type %scriptFolderPath%\BlogPgmStart.txt >>Blog.html

@echo ON
if /i "%~x1" == ".c" (echo ^<PRE class="brush:c;"^>  >>Blog.html)
if /i "%~x1" == ".php" (echo ^<PRE class="brush:php;"^>  >>Blog.html)
if /i "%~x1" == ".cpp" (echo ^<PRE class="brush:cpp;"^>  >>Blog.html)
if /i "%~x1" == ".cs" (echo ^<PRE class="brush:csharp;"^>  >>Blog.html)
if /i "%~x1" == ".vb" (echo ^<PRE class="brush:vb;"^>  >>Blog.html)
if /i "%~x1" == ".java" (echo ^<PRE class="brush:java;"^>  >>Blog.html)
if /i "%~x1" == ".html" (echo ^<PRE class="brush:html;"^>  >>Blog.html)
if /i "%~x1" == ".xml" (echo ^<PRE class="brush:xml;"^>  >>Blog.html)
if /i "%~x1" == ".css" (echo ^<PRE class="brush:css;"^>  >>Blog.html)
if /i "%~x1" == ".js" (echo ^<PRE class="brush:js;"^>  >>Blog.html)
if /i "%~x1" == ".sql" (echo ^<PRE class="brush:sql;"^>  >>Blog.html)
@echo OFF

REM This is to convert the special characters in the program to HTML equivalent
copy %1 temp12.html
set path=%PATH%;"D:\Dropbox\action\20131027-scripts project\tools\htb"
call htb /ke4 "%CD%\temp12.html" "%CD%\temp13.html"

REM This is to remove the head section that is generated in the previous stage
set path=%path%;"D:\Dropbox\action\20131027-scripts project\tools\fart"
fart -qC temp13.html "<HTML><BODY><PRE>\r"  " "
fart -qC temp13.html "</PRE></BODY></HTML>\r" " "

REM Output the formated program html to the blog
type temp13.html >>Blog.html
del temp12.html temp13.html 

::*********************************************************
REM Add a closing PRE tag to the blog
@echo ON
echo ^</PRE^>  >>Blog.html
@echo OFF
::*********************************************************

::*********************************************************
REM  Add output to the Blog
@echo ON

set /a s=1
set /a sect=7
:CHECKPOINT
	if EXIST "Capture-%s%.jpg" (goto MORE)
	goto CONT
	:MORE
	echo ^<DIV id="sect%sect%"^> >>Blog.html
	echo ^<DIV class="secthead"^>  >>Blog.html
	echo ^<H4^>OUTPUT - %s%^</H4^>  >>Blog.html
	echo ^</DIV^> >>Blog.html
	echo ^<DIV class="sectbody"^> >>Blog.html
	echo ^<img alt=^" >>Blog.html
	REM Add the output of program as ALT text
	call "%~n1.exe" >>Blog.html
	echo ^" title=^"OUTPUT^" border=^"0^" hspace=^"0^" src=^"file:///%CD%\Capture-%s%.jpg^" vspace=^"0^"^> >>Blog.html
	echo ^</DIV^>^</DIV^> >>Blog.html
	set /a s=s+1
	set /a sect=sect+1
goto CHECKPOINT
:CONT
@echo OFF
::pause
::*********************************************************
REM Parse the Comment file to retrieve the remaining sections
@echo ON
set s=2
set /a flag=0
echo Parsing Comment file...
:start
    set path=%path%;%scriptFolderPath%\Tools
    if exist Comment.txt (csplit -s -z Comment.txt /[@@]/1) 
    del Comment.txt
    if EXIST xx01 (ren xx01 Comment.txt) else (goto EndOfSec)
    set /a flag=1
    @echo ON
    ::xx00 contain first extracted section
    ::xx01 contain remaining sections
    if EXIST xx00 (type %scriptFolderPath%\BlogTem_%s%.txt xx00 >>Blog.html)
    set /a s=s+1
    @echo OFF
if exist Comment.txt (goto start) 
:EndOfSec

@echo ON
::This is of special case of having only one section in Remarks file
::if %flag% EQU 0
::type %scriptFolderPath%\BlogTem_1.txt xx00 >>Blog.html
::del xx00
::pause
::*********************************************************
type %scriptFolderPath%\BlogExpStop.txt >>Blog.html

@echo OFF
REM Removing @ that are joined to output file
set path=%path%;"D:\Dropbox\action\20131027-scripts project\tools\fart"
rxfind Blog.html /B:2 /P:[@@] /R:
::pause
::*********************************************************
@echo OFF
REM This is to avoid the illeffect of removing @ from Blog
set path=%path%;"D:\Dropbox\action\20131027-scripts project\tools\fart"
fart -qC Blog.html "lal.thomas.mailgmail.com" "lal.thomas.mail@gmail.com"
::*********************************************************

::*********************************************************
REM  Add closing tags to Blog
@echo ON
type %scriptFolderPath%\BlogEnd.txt >>Blog.html
@echo OFF
::pause
::*********************************************************

::*********************************************************
@echo OFF
REM Properly indent the output file
set path=%path%;"D:\Dropbox\action\20131027-scripts project"
call E:\Devel\Mis\CorrectHTML.bat "%CD%\Blog.html"
call E:\Devel\Mis\Beautify.bat "%CD%\Blog.html"
::pause
::*********************************************************
@echo OFF
set OldPath=%CD%;
::set path=%path%;E:\Devel\Mis
::IF NOT EXIST BlogInfo.txt (copy "E:\Devel\Mis\BlogInfo.txt" "%CD%\BlogInfo.txt" ) 
IF NOT EXIST Remarks.txt (copy "E:\Devel\Mis\Remarks.txt" "%CD%\Remarks.txt" ) 
pause
endlocal