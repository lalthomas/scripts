@echo OFF
REM alias for dos
REM Lal Thomas
REM ‎2016-11-04 1252

doskey +contact="D:\Dropbox\project\20131027-scripts project\20150710-create contact.bat" "D:\Dropbox\do\reference" $*
doskey +file="D:\Dropbox\project\20131027-scripts project\20160827-create file-dos batch script.bat" $*
doskey +inbox="D:\Dropbox\project\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\do\inbox.txt" $*
doskey +lesson="D:\Dropbox\project\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\do\lessons.txt" $*
doskey +log="D:\Dropbox\project\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\do\log.txt" $*
doskey +pomo="C:\Program Files (x86)\Hourglass\Hourglass.exe" $*
doskey +reference="D:\Dropbox\project\20131027-scripts project\20160530-create reference file-dos batch script.bat" "D:\Dropbox\do\reference" $*
doskey +timer="D:/Portable App/timer app for launchy/Timer.exe" $*
doskey +todoproject="D:\Dropbox\project\20131027-scripts project\20150713-create todo project.bat" "D:\Dropbox\do" $*
doskey copy-filelist="D:\Dropbox\project\20131027-scripts project\20161124-move files from a list of files-dos batch script.bat" $*
doskey download-video="D:\Dropbox\project\20131027-scripts project\20170507-download video of url in clipboard.bat"
doskey encode-image="D:\Dropbox\project\20131027-scripts project\20170514-copy base64 encoding of image file to clipboard.bat"
doskey gtd-action-files="D:\Dropbox\project\20131027-scripts project\20150823-open folders from file list-dos script batch script.bat" "D:\Dropbox\do\reference\20161001-gtd project list.txt"
doskey hh=doskey /MACROS
doskey jupyter-notebook=jupyter notebook --notebook-dir="%CD%"
doskey log-meditate="D:\Dropbox\project\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\do\log.txt" another great session of meditation with calm.com
doskey log-workout="D:\Dropbox\project\20131027-scripts project\20160401-add log entry to file-dos batch script.bat" "D:\Dropbox\do\log.txt" another great session of 7 minute workout with 7-min.com
doskey make-email-summary="D:\Dropbox\project\20131027-scripts project\20161031-copy email summary line to clipboard from mail csv index file-bash script.sh"
doskey recyclebin-clean="D:\Dropbox\project\20131027-scripts project\20161020-empty recyclebin-dos batch script.bat"
doskey tablet-copy="D:\Dropbox\project\20131027-scripts project\20140222-copy files from a list of files-dos batch script.bat" "D:\Dropbox\do\reference\20160115-tablet-video-sync-list.m3u" "D:\temp"
doskey wallpaper-default="D:\Dropbox\project\20131027-scripts project\20090411-set image as wallpaper-dos batch script.bat" "C:\Windows\Web\Wallpaper\Windows\img0.jpg"

set NLM=^



REM don't touch above blank lines
set NL=^^^%NLM%%NLM%^%NLM%%NLM%
cls
echo Help%NL%
echo ====%NL%
echo +contact
echo +file
echo +inbox
echo +lesson
echo +log
echo +pomo
echo +reference
echo +timer
echo +todoproject
echo copy-filelist
echo download-video
echo encode-image
echo gtd-action-files
echo hh
echo jupyter-notebook
echo log-meditate
echo log-workout
echo make-email-summary
echo recyclebin-clean
echo tablet-copy
echo wallpaper-default
echo %NL%---END----
