@echo OFF
REM Create shortcuts of useful scripts in sendto folder
REm Date : 2017-01-17
REM Author : Lal Thomas
setlocal
%~d0
cd %~p0

call :createShortCut "D:\project\20131027-scripts project\20090411-set image as wallpaper-dos batch script.bat" "# image - set as wallpaper.lnk"
call :createShortCut "D:\project\20131027-scripts project\20100606-make index of image files-dos batch program.bat" "# image - make index of image file.lnk"
call :createShortCut "D:\project\20131027-scripts project\20100827-run dev programs-dos batch script.bat" "# dev - run.lnk"
call :createShortCut "D:\project\20131027-scripts project\20111220-compile programs-dos batch script.bat" "# dev - compile.lnk"
call :createShortCut "D:\project\20131027-scripts project\20120713-copy a file to all sub folders-dos batch script.bat" "# explorer - copy file to all sub folders.lnk"
call :createShortCut "D:\project\20131027-scripts project\20120727-change file extension dos batch script.bat" "# explorer - change file extension.lnk"
call :createShortCut "D:\project\20131027-scripts project\20120727-make folder with todays datestamp.bat" "# explorer - make folder with todays datestamp.lnk"
call :createShortCut "D:\project\20131027-scripts project\20120909-make pictue mail from picture folder-dos batch scripts.bat" "# image - make pictue mail from picture folder.lnk"
call :createShortCut "D:\project\20131027-scripts project\20120909-make snapshots from videos-dos batch script.bat" "# video - make snapshots from videos.lnk"
call :createShortCut "D:\project\20131027-scripts project\20130216-append foldername to filename-dos batch script.bat" "# explorer - append foldername to filename.lnk"
call :createShortCut "D:\project\20131027-scripts project\20130728-prepend created datetime to filename-dos batch script.bat" "# explorer - prepend created datetime to filename.lnk"
call :createShortCut "D:\project\20131027-scripts project\20130819-convert file to markdown using pandoc-dos batch script.bat" "# dev - convert html file to markdown.lnk"
call :createShortCut "D:\project\20131027-scripts project\20131027-dev-beautify source code-dos batch script.bat" "# dev - beautify.lnk"
call :createShortCut "D:\project\20131027-scripts project\20151226-git commit changes.bat" "# dev - git commit.lnk"
call :createShortCut "D:\project\20131027-scripts project\20160216-set folder name as tag for image-dos batch script.bat" "# image - set folder name as tag for image.lnk"
call :createShortCut "D:\project\20131027-scripts project\20160217-fix the tag name of image-dos batch script.bat" "# image - fix the tag name of image.lnk"
call :createShortCut "D:\project\20131027-scripts project\20160218-move files to random directory-dos batch program.bat" "# explorer - move files to random directory.lnk"
call :createShortCut "D:\project\20131027-scripts project\20160307-delete file and associated files-dos batch script.bat" "# explorer - delete file and associated files.lnk"
call :createShortCut "D:\project\20131027-scripts project\20160513-print filenames in zip file-dos batch script.bat" "# zip - print filenames in zip file.lnk"
call :createShortCut "D:\project\20131027-scripts project\20160526-add caption for image-dos batch script.bat" "# image - add caption.lnk"
call :createShortCut "D:\project\20131027-scripts project\20160723-blog it.bat" "# blog it.lnk"
call :createShortCut "D:\project\20131027-scripts project\20160919-remove all metadata for image-dos batch script.bat" "# image - remove all metadata.lnk"
call :createShortCut "D:\project\20131027-scripts project\20170426-append filename to list-dos batch file.bat" "# +f book.lnk" "D:\do\reference\20170426-lalthomas favourite book list.txt"
call :createShortCut "D:\project\20131027-scripts project\20170426-append filename to list-dos batch file.bat" "# +f film.lnk" "D:\do\reference\20170426-lalthomas favourite films playlist.m3u"
call :createShortCut "D:\project\20131027-scripts project\20170426-append filename to list-dos batch file.bat" "# +f image.lnk" "D:\do\reference\20170426-lalthomas favourite image list.txt"
call :createShortCut "D:\project\20131027-scripts project\20170426-append filename to list-dos batch file.bat" "# +f music.lnk" "D:\do\reference\20170426-lalthomas favourite music playlist.m3u"
call :createShortCut "D:\project\20131027-scripts project\20170426-append filename to list-dos batch file.bat" "# +f people.lnk" "D:\do\reference\20170501-lalthomas favourite people list.txt"
call :createShortCut "D:\project\20131027-scripts project\20170426-append filename to list-dos batch file.bat" "# +f video songs.lnk" "D:\do\reference\20170430-lalthomas favourite video songs playlist.m3u"
call :createShortCut "D:\project\20131027-scripts project\20170707-show image slideshow from a filelist-dos batch script.bat" "# image - start slideshow.lnk"

endlocal
exit /b 0

:createShortCut
set scriptfile=".\20170102-create shortcut in sendto folder-powershell script.ps1"
IF [%3] == [] (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 
) ELSE (
	powershell -STA -executionpolicy bypass -File %scriptfile% -filename %1 -linkname %2 -switch %3
)
exit /b 0