REM Install
@echo ON
setlocal

%~d0
cd %~dp0
call :A
call :B
call :C
call :D
echo Install Completed.
pause
exit
endlocal

:A
REM make windows sendto shortcut
call ".\20130819-convert file to markdown using pandoc-dos batch script install.bat"
call ".\20131027-dev-beautify source code-dos batch script install.bat"
call ".\20090411-set image as wallpaper-dos batch script install.bat"
call ".\20100606-make index of image files-dos batch program install.bat"
call ".\20100827-run dev programs-dos batch script install.bat"
call ".\20111220-compile programs-dos batch script install.bat"
call ".\20120713-copy a file to all sub folders-dos batch script install.bat"
call ".\20120727-change file extension dos batch script install.bat"
call ".\20120727-make folder with todays datestamp install.bat"
call ".\20120909-make pictue mail from picture folder-dos batch scripts install.bat"
call ".\20120909-make snapshots from videos-dos batch script install.bat"
call ".\20130216-append foldername to filename-dos batch script install.bat"
call ".\20130728-prepend created datetime to filename-dos batch script install.bat"
call ".\20170426-append filename to list-dos batch file install.bat"
call ".\20151226-git commit changes install.bat"
call ".\20160216-set folder name as tag for image-dos batch script install.bat"
call ".\20160217-fix the tag name of image-dos batch script install.bat"
call ".\20160218-move files to random directory-dos batch program install.bat"
call ".\20160307-delete file and associated files-dos batch script install.bat"
call ".\20160513-print filenames in zip file-dos batch script install.bat"
call ".\20160526-add caption for image-dos batch script install.bat"
call ".\20160723-blog it install.bat"
call ".\20160919-remove all metadata for image-dos batch script install.bat"
call ".\20170707-show image slideshow from a filelist-dos batch script install.bat"
pause
exit /b 0

:B
REM Create Windows Desktop Shortcut
call ".\20161102-aliases for lalthomas pc-dos script support file install.bat"
exit /b 0

:C
REM Windows Task Scheduler Install
call ".\20160214-launch autohotkey scripts autohotkey script install.bat"
call ".\20191025-save screenshot with irfanview windows task sceduler install.bat"
exit /b 0

:D
REM Bash alias install
call ".\20141109-do folder-bash script install.bat"
call ".\20150715-bash helper-bash script install.bat"
call ".\20150715-bookmark-bash script install.bat"
call ".\20150715-git helper-bash script install.bat"
call ".\20150715-iso datetime-bash script install.bat"
call ".\20161108-project folder-bash script install.bat"
call ".\20161114-gtd helper-bash script install.bat"
call ".\20150826-filepaths-bash script install.bat"
call ".\20151117-workflow-bash script install.bat"
call ".\20160222-wish-bash script install.bat"
call ".\20160225-reference folder-bash script install.bat"
call ".\20160225-support folder-bash script install.bat"
call ".\20160509-inbox folder-bash script install.bat"
call ".\20170615-facebook helper-bash script install.bat"
call ".\20170706-wallpaper folder-bash script install.bat"
call ".\20170720-fullcontact helper-bash script install.bat"
call ".\20170924-backup data-bash script install.bat"
exit /b 0