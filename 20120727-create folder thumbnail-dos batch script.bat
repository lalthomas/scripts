setlocal
@echo OFF
REM #####################################################
REM Renames the file folder.jpg to avoid deletion of file
REN Folder.jpg temp1.jpg

REM #####################################################
REM Set the path for irfanview this works for file other than jpg
set path="%CD%";C:\Program Files\IrfanView
i_view32.exe %1 /convert=Folder.jpg
REM #####################################################
REM Delete the duplicate file and restores the original folder.jpg
SET FILENAME=%~n1
del %1
ren temp1.jpg "%FILENAME%.jpg"
REM #####################################################
endlocal

