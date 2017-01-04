@echo OFF 	
REM File : 20170102-create useful shortcuts of scripts in send to folder-powershell script run.bat 	
REM Creation Date : 2017-01-03 	
REM Author : Lal Thomas 	
REM Original File : D:\Dropbox\project\20131027-scripts project\20170102-create useful shortcuts of scripts in send to folder-powershell script.ps1 	

%~d0
cd "%~p0"
powershell -noexit -executionpolicy bypass "& ""20170102-create useful shortcuts of scripts in send to folder-powershell script.ps1""
pause
