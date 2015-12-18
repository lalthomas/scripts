@echo OFF
setlocal

REM Program variables
set CCompilerPath="C:\Program Files (x86)\Dev-Cpp\MinGW64\bin\gcc.exe"
set CppCompilterPath="C:\Program Files (x86)\Dev-Cpp\MinGW64\bin\g++.exe"
set JavaCompilerPath="C:\Program Files\Java\jdk1.7.0_51\bin\javac.exe"

REM get the script folder path
set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

if /i %~x1 == .c ( goto C )
if /i %~x1 == .cpp ( goto CPP )
if /i %~x1 == .cs ( goto CS)
if /i %~x1 == .java ( goto JAVA )
goto End

REM C
:C
REM The following two line are Npp Hack for not changing the current path
%~d1
cd %~p1
IF EXIST %~n1.exe (del %~n1.exe) ELSE (echo %1 is being processed first time)
%CCompilerPath% %1
IF %ERRORLEVEL% EQU 0 (goto CSuccess ) ELSE (goto CFailure)
:CFailure
echo Program terminated with Compilation Errors
pause
goto End
:CSuccess
ren a.exe %~n1.exe
goto End


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
echo Program terminated with Compilation Errors
goto End
:CppSuccess
ren a.exe %~n1.exe
goto End


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
:EOS
goto End
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
goto End

:End
pause
endlocal