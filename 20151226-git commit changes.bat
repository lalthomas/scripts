@echo ON

set gitPath="C:\Program Files (x86)\Git\bin\sh.exe"

set /p _commitMessage=Enter the commit message :

%gitPath% --login -i -c "git add -A" "%~1" && %gitPath% --login -i -c "git commit -am'%_commitMessage%' " "%~1"

pause