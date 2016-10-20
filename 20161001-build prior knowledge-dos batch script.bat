@echo OFF
echo Welcome to buid prior knowledge program
pause


cls
echo starting inbox folder list
echo.
echo Action and Contexts 
echo --------------------
echo.
echo  []
start explorer "D:\Dropbox\reference\20150906-inbox folder list-dev gtd.txt"
call "D:\Dropbox\action\20131027-scripts project\20150823-open folders from file list-dos script batch script.bat" "D:\Dropbox\reference\20150906-inbox folder list-dev gtd.txt"
echo.
pause
