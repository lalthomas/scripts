@echo OFF
SET /p _Opt="Are you sure to delete the folder(y/n)" 
@echo ON
echo %1
REM IF "%_Opt%" == "y" ( cmd /c cd /d %1 && del /s /f /q *.*)
IF "%_Opt%" == "n" ( goto :EOF)
pause

@echo OFF