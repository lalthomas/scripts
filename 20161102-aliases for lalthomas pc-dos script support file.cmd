@echo OFF
REM alias for dos
REM Lal Thomas
REM ‎2016-11-04 1252

set scriptFolderPathFull=%~dp0%
set scriptFolderPath=%scriptFolderPathFull:~0,-1%

doskey #download-video="%scriptFolderPath%\20170507-download video of url in clipboard.bat"
doskey #encode-image="%scriptFolderPath%\20170514-copy base64 encoding of image file to clipboard.bat"
doskey #gtd-action-files="%scriptFolderPath%\20150823-open folders from file list-dos script batch script.bat" "D:\do\reference\20161001-gtd project list.txt"
doskey #hh=doskey /macros
doskey #jupyter-notebook=jupyter notebook --notebook-dir="%CD%"
doskey #log-meditate="%scriptFolderPath%\20160401-add log entry to file-dos batch script.bat" "D:\do\log.txt" another great session of meditation with calm.com
doskey #log-workout="%scriptFolderPath%\20160401-add log entry to file-dos batch script.bat" "D:\do\log.txt" another great session of 7 minute workout with 7-min.com
doskey #make-email-summary="%scriptFolderPath%\20161031-copy email summary line to clipboard from mail csv index file-bash script.sh"
doskey #move-filelist="%scriptFolderPath%\20161124-move files from a list of files-dos batch script.bat" $*
doskey #open-reg-key="%scriptFolderPath%\20170628-open regedit key directly-dos batch script.bat" $*
doskey #open-files-notepad++="%scriptFolderPath%\20170928-open all files on folders in editor-dos batch script.bat" $*
doskey #recyclebin-clean="%scriptFolderPath%\20161020-empty recyclebin-dos batch script.bat"
doskey #tablet-copy="%scriptFolderPath%\20140222-copy files from a list of files-dos batch script.bat" "D:\do\reference\20160115-tablet-sync-list.m3u" "D:\temp"
doskey #pendrive-copy="%scriptFolderPath%\20170722-refill pendrive with media-dos batch script.bat" "D:\do\reference\20170722-pendrive.m3u" "D:\do\reference\20150319-watched.txt" "P:\" "courses"
doskey #wallpaper-default="%scriptFolderPath%\20090411-set image as wallpaper-dos batch script.bat" "C:\Windows\Web\Wallpaper\Windows\img0.jpg"
doskey +contact="%scriptFolderPath%\20150710-create contact.bat" "D:\do\reference" $*
doskey +file="%scriptFolderPath%\20160827-create file-dos batch script.bat" $*
doskey +inbox="%scriptFolderPath%\20160401-add log entry to file-dos batch script.bat" "D:\do\inbox.txt" $*
doskey +lesson="%scriptFolderPath%\20160401-add log entry to file-dos batch script.bat" "D:\do\lessons.txt" $*
doskey +log="%scriptFolderPath%\20160401-add log entry to file-dos batch script.bat" "D:\do\log.txt" $*
doskey +pomo="%PROGRAMFILES%\Hourglass\Hourglass.exe" $*
doskey +reference="%scriptFolderPath%\20160530-create reference file-dos batch script.bat" "D:\do\reference" $*
doskey +timer="D:/Portable App/timer app for launchy/Timer.exe" $*
doskey +todoproject="%scriptFolderPath%\20150713-create todo project.bat" "D:\do" $*

set NLM=^



REM don't touch above blank lines
set NL=^^^%NLM%%NLM%^%NLM%%NLM%
cls
call :help
%*
exit /b 0

:help
echo Help%NL%
echo ====%NL%

echo  #download-video
echo  #encode-image
echo  #gtd-action-files
echo  #hh
echo  #jupyter-notebook
echo  #log-meditate
echo  #log-workout
echo  #make-email-summary
echo  #move-filelist
echo  #open-reg-key
echo  #open-files-notepad++
echo  #pendrive-copy
echo  #recyclebin-clean
echo  #tablet-copy
echo  #wallpaper-default
echo  +contact
echo  +file
echo  +inbox
echo  +lesson
echo  +log
echo  +pomo
echo  +reference
echo  +timer
echo  +todoproject

echo %NL%---END----
exit /b 0