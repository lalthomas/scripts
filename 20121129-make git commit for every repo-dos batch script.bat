set path=%path%;C:\Program Files\Git\bin
for /D %%d in (*.) do (
setlocal
cd %%d
git add .
git commit -m "Add initial files"
endlocal
)
pause