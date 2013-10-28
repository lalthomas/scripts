@echo ON
REM starting of Program
setlocal
::*********************************************************
REM  This makes a copy of original and makes suitable for unsupported formats
set OrgExt=%~x1
set /a FLAG = 0
if %~x1 == .cs (goto csharp)
goto Proceed
:csharp
copy %1 "%~n1.cpp"
set OrgExt=".cpp"
set /a FLAG = 1
::pause
:Proceed
::*********************************************************
REM This produces a formatted Html page of source code
echo Making html file...
set path=%PATH%;"E:\Devel\Mis\SrcHighlite\bin"
::--line-number-ref="L#"
source-highlight -t=4 -f html -i "%~n1%OrgExt%" -o Blog.temp --data-dir "E:\Devel\Mis\SrcHighlite\share\source-highlight" --style-file=Sexy.style
::pause
cls
::*********************************************************
REM This deletes the temporary files
if %FLAG% == 1 (del "%~n1.cpp")
::pause
::*********************************************************
@echo OFF
REM This is to remove the credits of SrcHighlite program (Otherwise 4 <BR> will be added to o/p
set path=%path%;"E:\Devel\Mis\Find"
fart -qC Blog.temp "<!-- Generator: GNU source-highlight 2.1.2" "$"
fart -qC Blog.temp "by Lorenzo Bettini" "$"
fart -qC Blog.temp "http://www.lorenzobettini.it" "$"
fart -qC Blog.temp "http://www.gnu.org/software/src-highlite -->" "$"
::pause
::*********************************************************
cls
@echo OFF
REM This is remove Preformatted tag of formatted page ,
REM since such a code can only be wraped inside the table
REM This will remove all spaces and tabs wise formatting
set path=%path%;"E:\Devel\Mis\Find"
fart -qC Blog.temp "<pre><tt>" "<P>"
fart -qC Blog.temp "</tt></pre>" "</P>"
::*********************************************************
cls
@echo OFF
REM This adds a <BR> to every line of formatted output
fart -qC Blog.temp \r "<BR>"\r
REM This removes $ added previously
fart -qC Blog.temp "$<BR>"\r " "
::pause
::*********************************************************
cls
@echo OFF
REM This is to blockify the content of formatted output
::fart -qC Blog.temp "     " " "
::fart -qC Blog.temp "<b><font color="#F0F653">{" "<blockquote><b><font color="#F0F653">{"
fart -qC Blog.temp "{</font></b><BR>" "<blockquote>{</FONT></B><BR>"
fart -qC Blog.temp "}</font></b><BR>" "}</FONT></B></blockquote>"
fart -qC Blog.temp "};</font></b><BR>" "};</FONT></B></blockquote>"
::pause
::*********************************************************
echo Formatting html file..
REM Here starts the acutal Blog page creation
REM Blog template along with formatted output is concatenated here
cls
@echo ON
type E:\Devel\Mis\BlogStyle.txt >Blog.html
type E:\Devel\Mis\BlogTableStart.txt >>Blog.html
type Blog.temp >>Blog.html
@echo OFF
::*********************************************************
cls
@echo OFF
REM Delete temporary file
del Blog.temp
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
call BeautifyHTML.bat "%CD%\Blog.html"
::pause
::*********************************************************
cls
endlocal