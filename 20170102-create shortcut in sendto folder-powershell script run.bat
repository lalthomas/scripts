@echo OFF 	
REM File : 20170102-create shortcut in sendto folder-powershell script run.bat 	
REM Creation Date : 2017-01-17 	
REM Author : Lal Thomas 	
REM Original File : D:\lab\20131027-scripts project\20170102-create shortcut in sendto folder-powershell script.ps1 	
	
powershell -STA -executionpolicy bypass -noexit -File ".\%~nx1" -filename "%~dpnx0" -linkname "test shortcut.lnk"