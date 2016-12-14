@echo OFF
REM alias for dos
REM Lal Thomas
REM ‎2016-11-04 1252

doskey +contact="D:\Dropbox\action\20131027-scripts project\20150710-create contact.bat" "D:\Dropbox\action\20150716-contacts" $*
doskey +file="D:\Dropbox\action\20131027-scripts project\20160827-create file-dos batch script.bat" $*
doskey +inbox="D:\Dropbox\action\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\action\20140310-do\inbox.txt" $*
doskey +lesson="D:\Dropbox\action\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\reference\20160312-life lessons doc-life gtd.md" $*
doskey +log="D:\Dropbox\action\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\action\20140310-do\log.txt" $*
doskey +pomo="C:\Program Files (x86)\Hourglass\Hourglass.exe" $*
doskey +reference="D:\Dropbox\action\20131027-scripts project\20160530-create reference file-dos batch script.bat" "D:\Dropbox\reference" $*
doskey +timer="D:/Portable App/timer app for launchy/Timer.exe" $*
doskey +todoproject="D:\Dropbox\action\20131027-scripts project\20150713-create todo project.bat" "D:\Dropbox\action\20140310-do" $*
doskey copy-filelist="D:/Dropbox/action/20131027-scripts project/20161124-move files from a list of files-dos batch script.bat" $*
doskey gtd-action-files="D:\Dropbox\action\20131027-scripts project\20150823-open folders from file list-dos script batch script.bat" "D:\Dropbox\reference\20161001-active projects-dev gtd.txt"
doskey gtd-inbox-files="D:\Dropbox\action\20131027-scripts project\20150823-open folders from file list-dos script batch script.bat" "D:\Dropbox\reference\20150906-inbox folder list-dev gtd.txt"
doskey gtd-review="D:\Dropbox\action\20131027-scripts project\20161001-build prior knowledge-dos batch script.bat"
doskey hh=doskey /MACROS
doskey log-meditate="D:\Dropbox\action\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\action\20140310-do\log.txt" another great session of meditation with calm.com
doskey log-workout="D:\Dropbox\action\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\action\20140310-do\log.txt" another great session of 7 minute workout with 7-min.com
doskey make-email-summary="D:\Inbox\doc\cleanup thunderbird\temp\20161031-copy email summary line to clipboard from mail csv index file-bash script.sh"
doskey recyclebin-clean="D:\Dropbox\action\20131027-scripts project\20161020-empty recyclebin-dos batch script.bat"
doskey tablet-copy="D:\Dropbox\action\20131027-scripts project\20140222-copy files from a list of files-dos batch script.bat" "D:\Dropbox\action\20140915-playlist\tablet-video-sync-list.m3u" "D:\temp"
doskey wallpaper-default="D:/Dropbox/action/20131027-scripts project/20090411-set image as wallpaper-dos batch script.bat" "C:\Windows\Web\Wallpaper\Windows\img0.jpg"

set NLM=^



REM don't touch above blank lines
set NL=^^^%NLM%%NLM%^%NLM%%NLM%
cls
echo Help%NL%
echo ====%NL%
echo  +contact
echo  +file
echo  +inbox
echo  +log
echo  +pomo
echo  +reference
echo  +timer
echo  +todoproject
echo  copy-filelist
echo  gtd-action-files
echo  gtd-inbox-files
echo  gtd-review
echo  hh
echo  log-meditate
echo  log-workout
echo  make-email-summary
echo  recyclebin-clean
echo  tablet-copy
echo  wallpaper-default
echo %NL%---END----
