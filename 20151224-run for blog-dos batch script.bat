@echo OFF
set OldPath=%CD%;
::set path=%path%;E:\Devel\Mis
IF NOT EXIST BlogInfo.txt (copy "E:\Devel\Mis\BlogInfo.txt" "%CD%\BlogInfo.txt" ) 
IF NOT EXIST Remarks.txt (copy "E:\Devel\Mis\Remarks.txt" "%CD%\Remarks.txt" ) 
IF NOT EXIST %~n1.exe (call E:\Devel\Mis\Compile.bat %1)
cls
IF EXIST %~n1.exe (%~n1.exe)
 PAUSE >nul