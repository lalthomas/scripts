set path=%path%;C:\Program Files\7-Zip
for /D %%d in (*.*) do 7z a -tzip "%%d.zip" ".\%%d\*"