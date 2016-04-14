@echo OFF
setlocal

REM Program variables
set CCompilerPath="C:\Program Files (x86)\Dev-Cpp\MinGW64\bin\gcc.exe"
set CppCompilterPath="C:\Program Files (x86)\Dev-Cpp\MinGW64\bin\g++.exe"
set JavaCompilerPath="C:\Program Files\Java\jdk1.7.0_51\bin\javac.exe"

REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

REM Thanks you http://stackoverflow.com/a/2541820
IF [%~x1] == [] ( 
IF EXIST %1 ( CALL:FOLDER %1 )
) ELSE ( 
IF EXIST %1 ( CALL:MAP %1 )
)
REM premature exit to define functions beneath
EXIT /B %ERRORLEVEL%

REM Subroutine
:MAP
REM echo %1
if /i %~x1 == .c ( goto C )
if /i %~x1 == .cpp ( goto CPP )
if /i %~x1 == .cs ( goto CS)
if /i %~x1 == .java ( goto JAVA )
if /i %~x1 == .tex ( goto LATEX )
if /i %~x1 == .md ( goto MARKDOWN )
EXIT /b 0

REM C
:C
REM The following two line are Npp Hack for not changing the current path
%~d1
cd %~p1
IF EXIST %~n1.exe (del %~n1.exe) ELSE (echo %1 is being processed first time)
%CCompilerPath% %1
IF %ERRORLEVEL% EQU 0 (goto CSuccess ) ELSE (goto CFailure)
:CFailure
echo Program terminated with compilation errors
SET /p option="press o to open file : " 
IF "%option%" == "o" ( start explorer %1)
pause
EXIT /b 0
:CSuccess
ren a.exe "%~n1".exe
echo "%~n1%~x1" compiled successfully
EXIT /b 0


REM Cpp
:CPP
@echo OFF
setlocal
REM The following two line are Npp Hack for not changing the current path
%~d1
cd %~p1
IF EXIST %~n1.exe (del %~n1.exe) ELSE (echo %1 is being processed first time)
%CppCompilterPath% %1
IF %ERRORLEVEL% EQU 0 (goto CppSuccess ) ELSE (goto CppFailure)
:CppFailure
echo Program terminated with compilation errors
SET /p option="press o to open file : " 
IF "%option%" == "o" ( start explorer %1)
pause
EXIT /b 0
:CppSuccess
ren a.exe "%~n1".exe
echo "%~n1%~x1" compiled successfully
EXIT /b 0


REM CSharp
:CS
@echo OFF
setlocal
set path=%path%;C:\WINDOWS\Microsoft.NET\Framework\v3.5\
if EXIST CmdOpt.txt ( goto Args )
call csc %1
goto EOS
:Args
echo Parsing Arguments...
REM Creating another temporary batch file
type E:\Devel\Mis\csc.txt "%CD%\CmdOpt.txt" %scriptFolderPath%\space.txt>>temp.bat 
echo %1 >>temp.bat
echo IF %%ERRORLEVEL%% EQU 0 ( echo "Successfully Compiled..." ) >>temp.bat
cls
call temp.bat
del temp.bat
pause
:EOS
EXIT /b 0
endlocal

REM Java
:JAVA
@echo OFF
setlocal
REM The following two line are Npp Hack for not changing the current path
%~d1
cd %~p1
::javac %1
%JavaCompilerPath% %1
IF %ERRORLEVEL% EQU 0 (goto JavaSuccess ) ELSE (goto JavaFailure)
:JavaFailure
echo Program terminated with compilation errors
SET /p option="press o to open file : " 
IF "%option%" == "o" ( start explorer %1)
pause
EXIT /b 0
:JavaSuccess
echo "%~n1%~x1" compiled successfully
EXIT /b 0


REM LATEX
:LATEX
@echo OFF
setlocal
REM The following two line are Npp Hack for not changing the current path
%~d1
cd %~p1

IF NOT EXIST "%~dp1\build" mkdir build

REM clean up
del build\*.dvi
del build\*.aux
del build\*.bbl
del build\*.blg
del build\*.brf
del build\*.out
pdflatex -draftmode -interaction=batchmode -aux-directory="%~pd1\build" -output-directory="%~pd1\build" %1
type "%~dp1\build\%~n1.log" | findstr Warning:
:: Run pdflatex -&gt; bibtex -&gt; pdflatex -&gt; pdflatex
bibtex.exe "%~dp1\build\%~n1.aux"
:: If you are using multibib the following will run bibtex on all aux files
:: FOR /R . %%G IN (*.aux) DO bibtex %%G
pdflatex.exe -draftmode -interaction=batchmode -aux-directory="%~pd1\build" -output-directory="%~pd1\build" %1
pdflatex.exe -interaction=batchmode -aux-directory="%~pd1\build" -output-directory="%~pd1\build" %1 -quiet 
IF %ERRORLEVEL% EQU 0 (goto LatexSuccess ) ELSE (goto LatexFailure)
:LatexFailure
pause
EXIT /b 0
:LatexSuccess
start "SumatraPDF" "D:\PortableApps.com\PortableApps\SumatraPDFPortable\SumatraPDFPortable.exe" "%~dp1\build\%~n1.pdf"
EXIT /b 0


:MARKDOWN
%~d1
cd %~p1
IF NOT EXIST "%~dp1\build" mkdir build
call pandoc -o "%~pd1\%~n1.pdf" %1
IF %ERRORLEVEL% EQU 0 (goto MarkdownFirstSuccess ) ELSE (goto MarkdownFirstFailure)
EXIT /b 0
:MarkdownFirstSuccess
move "%~pd1\%~n1.pdf" "%~pd1\build" && START "" "%~pd1\build\%~n1.pdf"
EXIT /b 0
:MarkdownFirstFailure
echo. 
echo ==================================================== 
echo compiling failed..., trying with html, press any key
echo ====================================================
echo.
pause
call pandoc -o "%~pd1\build\%~n1.html" %1
IF %ERRORLEVEL% EQU 0 ( goto MarkdownSecondSuccess ) ELSE ( goto MarkdownSecondFailure )
EXIT /b 0
:MarkdownSecondSuccess
START "" "%~pd1\build\%~n1.html"
EXIT /b 0
:MarkdownSecondFailure
echo compiling failed again...
pause
EXIT /b 0

:FOLDER
SET /p _Opt="Are you sure to compile all files on the folder(y/n)" 
IF "%_Opt%" == "n" ( goto :EOF)
echo Batch Processing folder... : %1 
for %%a in (%1\*.*) do ( CALL:MAP "%%a" )
EXIT /b 0

endlocal