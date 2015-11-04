@echo OFF
setlocal

if /i %~x1 == .c ( goto C )
if /i %~x1 == .cpp ( goto CPP )
if /i %~x1 == .cs ( goto CS)
if /i %~x1 == .java ( goto JAVA )
goto End

REM C
:C
set path=%PATH%;"C:\Program Files (x86)\Dev-Cpp\MinGW64\bin"
REM The following two line are Npp Hack for not changing the current path
%~d1
cd "%~p1"
IF EXIST "%~n1".exe (del "%~n1".exe) ELSE (echo %1 is being processed first time)
gcc "%1"
IF %ERRORLEVEL% EQU 0 (goto CSuccess ) ELSE (goto CFailure)
:CFailure
echo Program terminated with Compilation Errors
pause
goto End
:CSuccess
ren a.exe "%~n1".exe
goto End


REM Cpp
:CPP
@echo OFF
setlocal
set path=%PATH%;"C:\Program Files (x86)\Dev-Cpp\MinGW64\bin"
REM The following two line are Npp Hack for not changing the current path
%~d1
cd "%~p1"
IF EXIST "%~n1".exe (del "%~n1".exe) ELSE (echo %1 is being processed first time)
g++ "%1"
IF %ERRORLEVEL% EQU 0 (goto CppSuccess ) ELSE (goto CppFailure)
:CppFailure
echo Program terminated with Compilation Errors
pause
goto End
:CppSuccess
ren a.exe "%~n1".exe
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
type E:\Devel\Mis\csc.txt "%CD%\CmdOpt.txt" E:\Devel\Mis\space.txt>>temp.bat 
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
set path=%PATH%;D:\Program Files\Java\jdk1.6.0_23\bin
REM The following two line are Npp Hack for not changing the current path
%~d1
cd "%~p1"
::javac %1
javac %1
goto End

:End
pause
endlocal