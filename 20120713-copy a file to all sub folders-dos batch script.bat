REM Author Lal Thomas
@echo OFF
%~d1
cd %~p1

SET /p _Opt_=Enter the path of file : 

IF NOT EXIST %_Opt_% ( 
	echo file "%_Opt_%" not exists
	pause
	exit
)

set file=%_Opt_%

IF [%~x1] == [] ( 
IF EXIST %1 ( CALL:FOLDER %1 )
) ELSE ( 
IF EXIST %1 ( CALL:FILE %1 )
)

:FOLDER
set folderPath=%1
goto :PROCESS

:FILE
set folderPath=%~dp1
goto :PROCESS

:PROCESS
REM for batch file use %%f else use %f
for /f "tokens=*" %%f in ('dir %folderPath% /ad/b') do copy %_Opt_% %folderPath%\%%f

pause