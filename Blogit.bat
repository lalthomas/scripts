@echo OFF
REM starting of Program
setlocal
cls
@echo ON
type E:\Devel\Mis\BlogHead1.txt >Blog.html 
echo %~n1 >>Blog.html
@echo OFF
type E:\Devel\Mis\BlogHead2.txt >>Blog.html 
type E:\Devel\Mis\BlogStyle.txt >>Blog.html
type E:\Devel\Mis\BlogBodyStart.txt >>Blog.html
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
set path=%PATH%;E:\Devel\Mis\HTB
call htb /ke4 "%CD%\temp12.html" "%CD%\temp13.html"

set path=%path%;"E:\Devel\Mis\Find"
fart -qC temp13.html "<HTML><BODY><PRE>\r"  " "
fart -qC temp13.html "</PRE></BODY></HTML>\r" " "

type temp13.html >>Blog.html
del temp12.html temp13.html 

@echo ON
echo ^</PRE^>  >>Blog.html
@echo OFF

@echo OFF
::*********************************************************
cls
@echo OFF
REM Creating Code Explanation with Comment file
copy Remarks.html Comment.txt
::*********************************************************
cls
@echo OFF
REM This adds a <BR> to every line of Comment file
set path=%path%;"E:\Devel\Mis\Find"
fart -qC Comment.txt \r "<BR>"\r
fart -qC Comment.txt "@<BR>" "@"
::*********************************************************
cls
@echo ON
set s=1
set /a flag=0
REM Parse the Comment file to retrieve each section
echo Parsing Comment file...
:start
    set path=%path%;C:\Program Files\GnuWin32\CoreUtils\bin
    if exist Comment.txt (csplit -s -z Comment.txt /[@@@@@]/1) 
    del Comment.txt
    if EXIST xx01 (ren xx01 Comment.txt) else (goto EndOfSec)
    set /a flag=1
    @echo ON
    ::xx00 contain first extracted section
    ::xx01 contain remaining sections
    if EXIST xx00 (type E:\Devel\Mis\BlogTem_%s%.txt xx00 >>Blog.html)
    set /a s=s+1
    @echo OFF
if exist Comment.txt (goto start) 
:EndOfSec
@echo ON
::This is of special case of having only one section in Remarks file
::if %flag% EQU 0
type E:\Devel\Mis\BlogTem_%s%.txt xx00 >>Blog.html
del xx00
::pause
::*********************************************************
@echo ON
type E:\Devel\Mis\BlogEnd.txt >>Blog.html
@echo OFF
::pause
::*********************************************************
cls
@echo OFF
REM Removing @ that are joined to output file
set path=%path%;"E:\Devel\Mis\Find"
rxfind Blog.html /B:2 /P:[@] /R:
::pause
::*********************************************************
cls
@echo OFF
REM This adds a <BR> to every line of Comment file
set path=%path%;"E:\Devel\Mis\Find"
fart -qC Blog.html "lal.thomas.mailgmail.com" "lal.thomas.mail@gmail.com"
::*********************************************************
cls
@echo OFF
REM Properly indent the output file
set path=%path%;"E:\Devel\Mis"
call E:\Devel\Mis\Beautify.bat "%CD%\Blog.html"
::pause
::*********************************************************
cls
endlocal