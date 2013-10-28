@echo OFF
REM starting of Program
setlocal
::*********************************************************
REM This produces a formatted Html page of source code
echo Making html file...
set path=%PATH%;"E:\Devel\Mis\SrcHighlite\bin"
source-highlight -t=4 -f html -i %1 -o Blog.temp --data-dir "E:\Devel\Mis\SrcHighlite\share\source-highlight" --style-file=Sexy.style
::*********************************************************
cls
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
fart -qC Blog.temp "$<BR>"\r " "
::pause
::*********************************************************
cls
@echo OFF
REM This is to blockify the content of formatted output
fart -qC Blog.temp "{</font></b><BR>" "<blockquote>{</FONT></B><BR>"
fart -qC Blog.temp "}</font></b><BR>" "}</FONT></B></blockquote>"
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
set s=1
copy Remarks.html Comment.txt
::*********************************************************
cls
@echo OFF
REM This adds a <BR> to every line of Comment file
set path=%path%;"E:\Devel\Mis\Find"
fart -qC Comment.txt \r "<BR>"\r
fart -qC Comment.txt "*<BR>" "*"
::*********************************************************
cls
@echo OFF
REM Parse the Comment file to retrieve each section
echo Parsing Comment file...
:start
    type E:\Devel\Mis\BlogTem_%s%.txt >>Blog.html
    set /a s=s+1
    set path=%path%;C:\Program Files\GnuWin32\CoreUltil\bin
    if exist Comment.txt (for %%j in (*.txt) do (csplit -s Comment.txt /[*****]/1))
    del Comment.txt
    @echo ON
    ::xx00 contain first extracted section
    ::xx01 contain remaining sections
    if EXIST xx00 (type xx00 >>Blog.html)
    @echo OFF
    if EXIST xx01 (ren xx01 Comment.txt)
if exist Comment.txt (goto start)
::*********************************************************
type E:\Devel\Mis\BlogEnd.txt >>Blog.html
::*********************************************************
cls
@echo OFF
REM Removing * that are joined to output file
set path=%path%;"E:\Devel\Mis\Find"
rxfind Blog.html /B:2 /P:[*] /R:
::*********************************************************
cls
@echo OFF
REM Properly indent the output file
set path=%path%;"E:\Devel\Mis"
BeautifyHTML.bat "%CD%\Blog.html"
::*********************************************************
cls
endlocal