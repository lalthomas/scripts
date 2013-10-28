@echo OFF

REM ****************************************************
REM Script to get the last folder in the file path
REM Credit : http://stackoverflow.com/questions/2396003/get-parent-directory-name-for-a-particular-file-using-dos-batch-scripting
setlocal
set path=%PATH%;E:\Devel\Mis\MakeMail
REM set ParentDir=%~p1
set ParentDir=%CD%
REM echo %ParentDir%

REM Replaces every space with colon
set ParentDir=%ParentDir: =:%
REM echo %ParentDir%

REM Replaces every back slash with space
set ParentDir=%ParentDir:\= %
REM echo %ParentDir%

REM Calls a routine that calculates the last folder
call :getparentdir %ParentDir%

REM Replaces every colon with space
set ParentDir=%ParentDir::= %
REM echo ParentDir is %ParentDir%

echo From - Wed Jul 18 11:06:40 2012 >>index.eml                                                                              
echo Message-ID: ^<50064B68.2070405@gmail.com^> >>index.eml
echo Date: Wed, 18 Jul 2012 11:06:40 +0530 >>index.eml
echo MIME-Version: 1.0 >>index.eml
echo Subject: %ParentDir% >>index.eml
echo Content-Type: text/html; charset=ISO-8859-1 >>index.eml
echo Content-Transfer-Encoding: 7bit >>index.eml
echo.>>index.eml
echo ^<html^>^<head^>^<meta http-equiv=^"content-type^" content=^"text/html; charset=ISO-8859-1^"^>^<title^>%ParentDir%^</title^> ^</head^>^<body^> >>index.eml

echo ^<h1^> %ParentDir% ^</h1^> >>index.eml
echo ^<center^> >>index.eml

REM Loop through all images in the folder
for %%a in ( *.jpg,*.png,*.gif ) do (

REM Encodes the image to Base64 encoding
base64 -e %%a "encodeimage.txt"

REM Extracts the IPTC Caption of the image
call exiftool -iptc:Caption-Abstract %%a >captionimage.txt

REM call :getcaption %caption%
echo ^<img src=^"data:image/jpeg;base64,>>index.eml
REM pause

type encodeimage.txt>>index.eml
echo ^"/^> >>index.eml
echo ^<br/^> >>index.eml

for /f "delims=" %%x in (captionimage.txt) do echo ^<p^>%%x^</p^> >>index.eml
echo ^<p^>^</p^> >>index.eml

REM Clean Up
del encodeimage.txt
del captionimage.txt

)
echo ^</center^> >>index.eml

call fart index.eml "<p>Caption-Abstract                : " "<p>"

echo ^</body^>^</html^> >>index.eml


del "%ParentDir%.eml"
ren "index.eml" "%ParentDir%.eml"

goto :EOF

REM Routine that remove the first part of the string separated by colon
setlocal
:getcaption
echo %*
shift
set caption=%~1
goto :EOF
endlocal
REM End of Script
REM ****************************************************


REM Routine that returns the last word of the string
setlocal
:getparentdir
if "%~1" EQU "" goto :EOF
Set ParentDir=%~1
shift
goto getparentdir
endlocal


