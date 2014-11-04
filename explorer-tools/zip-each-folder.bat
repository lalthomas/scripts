set path=%path%;D:\Program Files\7-Zip
for /D %%d in (*.*) do 7z a -tzip "%%d.zip" ".\%%d\*"