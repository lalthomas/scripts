set path=%path%;C:\Program Files\Git\bin
for /D %%d in (*.) do (
setlocal
cd %%d
git init
endlocal
)
pause