@echo OFF 	
REM File : 20151227-combine git repositories from a filelist run.bat 	
REM Creation Date : 2017-02-06 	
REM Author : Lal Thomas 	
REM Original File : D:\lab\20131027-scripts project\20151227-combine git repositories from a filelist.sh 	

set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%	

"%scriptFolderPath%\20151227-combine git repositories from a filelist.sh" "D:\temp\files.txt" "D:\temp\test" && pause