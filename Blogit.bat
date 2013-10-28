@echo OFF
REM starting of Program
setlocal
cls
@echo ON
type E:\Devel\Mis\Blogit\BlogHead1.txt >Blog.html 

@echo OFF
REM Creating Meta Data with Bog Info File
copy BlogInfo.txt BgInf.txt
if not exist BlogInfo.txt (copy E:\Devel\Mis\Blogit\BlogInfo.txt BlogInfo.txt)
::*********************************************************
cls
@echo ON
set s=1
set /a flag=0
REM Parse the BlogInfo.txt file to retrieve each section
echo Parsing BgInf.txt file...
:start1
    set path=%path%;E:\Devel\Mis\Blogit\Tools
    if exist BgInf.txt (csplit -s -z BgInf.txt /[@@]/1) 
    del BgInf.txt
    if EXIST xx01 (ren xx01 BgInf.txt) else (goto EndOfSec1)
    set /a flag=1
    @echo ON
    ::xx00 contain first extracted section
    ::xx01 contain remaining sections
    if EXIST xx00 (type E:\Devel\Mis\Blogit\BlogMetaTem_%s%.txt xx00 >>Blog.html)
    set /a s=s+1
    @echo OFF
if exist BgInf.txt (goto start1) 
:EndOfSec1
@echo ON
::This is of special case of having only one section in Remarks file
::if %flag% EQU 0
type E:\Devel\Mis\Blogit\BlogMetaTem_%s%.txt xx00 >>Blog.html
del xx00
::pause
::*********************************************************
@echo ON
echo ^"^> >>Blog.html
@echo OFF
REM Removing @ that are joined to output file
set path=%path%;"E:\Devel\Mis\Find"
rxfind Blog.html /B:2 /P:[@@] /R:
::pause
::********************************************************

::pause
::*********************************************************
cls
@echo ON
type E:\Devel\Mis\Blogit\BlogHead2.txt >>Blog.html 

type E:\Devel\Mis\Blogit\Blog%~x1% >>Blog.html
::pause
type E:\Devel\Mis\Blogit\BlogStyle.txt >>Blog.html
type E:\Devel\Mis\Blogit\BlogBodyStart.txt >>Blog.html

@echo OFF
::*********************************************************


::*********************************************************
cls
@echo OFF
REM Creating Code Explanation with Comment file
copy Remarks.txt Comment.txt
if NOT EXIST Remarks.txt (copy E:\Devel\Mis\Blogit\Remarks.txt Remarks.txt)
::*********************************************************
cls
@echo OFF
REM This adds a <BR> to every line of Comment file
set path=%path%;"E:\Devel\Mis\Find"
::fart -qC Comment.txt \r "<BR>"\r
::fart -qC Comment.txt "@<BR>" "@"
fart -qC Comment.txt \n \n"<p>"
fart -qC Comment.txt \r "</p>"\r
::*********************************************************
cls
@echo ON
set s=1
set /a flag=0
REM Parse the Comment file to retrieve each section
echo Parsing Comment file...
:start
    set path=%path%;E:\Devel\Mis\Blogit\Tools
    if exist Comment.txt (csplit -s -z Comment.txt /[@@]/1) 
    del Comment.txt
    if EXIST xx01 (ren xx01 Comment.txt) else (goto EndOfSec)
    set /a flag=1
    @echo ON
    ::xx00 contain first extracted section
    ::xx01 contain remaining sections
    if EXIST xx00 (type E:\Devel\Mis\Blogit\BlogTem_%s%.txt xx00 >>Blog.html)
    set /a s=s+1
    @echo OFF
if exist Comment.txt (goto start) 
:EndOfSec
@echo ON
::This is of special case of having only one section in Remarks file
::if %flag% EQU 0
type E:\Devel\Mis\Blogit\BlogTem_%s%.txt xx00 >>Blog.html
del xx00
::pause
::*********************************************************
type E:\Devel\Mis\Blogit\BlogExpStop.txt >>Blog.html

cls
@echo OFF
REM Removing @ that are joined to output file
set path=%path%;"E:\Devel\Mis\Find"
rxfind Blog.html /B:2 /P:[@@] /R:
::pause
::*********************************************************
::cls
@echo OFF
REM This is to avoid the illeffect of removing @ from Blog
set path=%path%;"E:\Devel\Mis\Find"
fart -qC Blog.html "lal.thomas.mailgmail.com" "lal.thomas.mail@gmail.com"
::*********************************************************
cls
type E:\Devel\Mis\Blogit\BlogPgmStart.txt >>Blog.html

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

REM This is to convert the special characters in the program to HTML equivalent
copy %1 temp12.html
set path=%PATH%;E:\Devel\Mis\HTB
call htb /ke4 "%CD%\temp12.html" "%CD%\temp13.html"

REM This is to remove the head section that is generated in the previous stage
set path=%path%;"E:\Devel\Mis\Find"
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
	echo ^" title=^"OUTPUT^" border=^"0^" hspace=^"0^" src=^"Capture-%s%.jpg^" vspace=^"0^"^> >>Blog.html
	echo ^</DIV^>^</DIV^> >>Blog.html
	set /a s=s+1
	set /a sect=sect+1
goto CHECKPOINT
:CONT
@echo OFF
::pause
::*********************************************************

::*********************************************************
REM  Add closing tags to Blog
@echo ON
type E:\Devel\Mis\Blogit\BlogEnd.txt >>Blog.html
@echo OFF
::pause
::*********************************************************

::*********************************************************
cls
@echo OFF
REM Properly indent the output file
set path=%path%;"E:\Devel\Mis"
call E:\Devel\Mis\CorrectHTML.bat "%CD%\Blog.html"
call E:\Devel\Mis\Beautify.bat "%CD%\Blog.html"
::pause
::*********************************************************
cls
@echo OFF
set OldPath=%CD%;
::set path=%path%;E:\Devel\Mis
IF NOT EXIST BlogInfo.txt (copy "E:\Devel\Mis\BlogInfo.txt" "%CD%\BlogInfo.txt" ) 
IF NOT EXIST Remarks.txt (copy "E:\Devel\Mis\Remarks.txt" "%CD%\Remarks.txt" ) 
endlocal