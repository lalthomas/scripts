@echo OFF
REM This will start explorer with a folder
REM start explorer  "D:\Dropbox\action\20150716-contacts"

REM This will start explorer++ with a list of folders
REM "D:\PortableApps.com\PortableApps\Explorer++Portable\Explorer++Portable.exe" "D:\Dropbox\action\20150716-contacts" "D:\Dropbox\action\20140915-playlist"

cd "D:\Dropbox\reference\"
for /f "tokens=*" %%a in (20150823-home_computer_actionable_folder_list.txt) do (  
  start explorer "%%a"
)
