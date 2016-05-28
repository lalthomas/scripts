@echo OFF
setlocal
del Blog.html 
type "%programfiles%\Blogit\BlogBodyStart.txt" >>Blog.html
cls
@echo OFF
copy Remarks.txt Comment.txt
if NOT EXIST Remarks.txt (copy "%programfiles%\Blogit\Remarks.txt" Remarks.txt)
cls
@echo OFF
set path=%path%;"%programfiles%\Blogit\Tools"
if exist Comment.txt (csplit -s -z Comment.txt /[@@]/1) 
del Comment.txt
@echo ON
if EXIST xx01 (ren xx01 Comment.txt) else (goto EndOfSec)
if EXIST xx00 (type "%programfiles%\Blogit\BlogTem_1.txt" xx00 >>Blog.html)
@echo OFF
cls
type "%programfiles%\Blogit\BlogPgmStart.txt" >>Blog.html
@echo ON
if /i "%~x1" == ".c" (echo ^<PRE class="brush:c;"^>  >>Blog.html)
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
copy %1 temp12.html
set path=%PATH%;"%programfiles%\Blogit\Tools"
call htb /ke4 "%CD%\temp12.html" "%CD%\temp13.html"
set path=%path%;"%programfiles%\Blogit\Tools"
fart -qC temp13.html "<HTML><BODY><PRE>\r"  " "
fart -qC temp13.html "</PRE></BODY></HTML>\r" " "
type temp13.html >>Blog.html
del temp12.html temp13.html 
@echo ON
echo ^</PRE^>  >>Blog.html
@echo OFF
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
	call "%~n1.exe" >>Blog.html
	echo ^" title=^"OUTPUT^" border=^"0^" hspace=^"0^" src=^"Capture-%s%.jpg^" vspace=^"0^"^> >>Blog.html
	echo ^</DIV^>^</DIV^> >>Blog.html
	set /a s=s+1
	set /a sect=sect+1
goto CHECKPOINT
:CONT
@echo OFF
cls
@echo ON
set s=2
set /a flag=0
echo Parsing Comment file...
:start
    set path=%path%;"%programfiles%\Blogit\Tools"
    if exist Comment.txt (csplit -s -z Comment.txt /[@@]/1) 
    del Comment.txt
    if EXIST xx01 (ren xx01 Comment.txt) else (goto EndOfSec)
    set /a flag=1
    @echo ON   
    if EXIST xx00 (type "%programfiles%\Blogit\BlogTem_%s%.txt" xx00 >>Blog.html)
    set /a s=s+1
    @echo OFF
if exist Comment.txt (goto start) 
:EndOfSec
@echo ON
type "%programfiles%\Blogit\BlogExpStop.txt" >>Blog.html
cls
@echo OFF
set path=%path%;"%programfiles%\Blogit\Tools"
rxfind Blog.html /B:2 /P:[@@] /R:
@echo OFF
set path=%path%;"%programfiles%\Blogit\Tools"
fart -qC Blog.html "lal.thomas.mailgmail.com" "lal.thomas.mail@gmail.com"
@echo ON
type "%programfiles%\Blogit\BlogEnd.txt" >>Blog.html
@echo OFF
cls
@echo OFF
set OldPath=%CD%;
IF NOT EXIST Remarks.txt (copy "%programfiles%\Remarks.txt" "%CD%\Remarks.txt" ) 
endlocal