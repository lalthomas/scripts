
REM move film files and associated files to OK folder


for %%f in (*.flv)  do ( 

	move "%%~dpnf.*" OK 
	move "%%~dpnf-fanart.*" OK
	move "%%~dpnf-poster.*" OK
 )



for %%f in (*.avi)  do ( 

	move "%%~dpnf.*" OK 
	move "%%~dpnf-fanart.*" OK
	move "%%~dpnf-poster.*" OK
 )


for %%f in (*.divx) do ( 

	move "%%~dpnf.*" OK 
	move "%%~dpnf-fanart.*" OK
	move "%%~dpnf-poster.*" OK

)

for %%f in (*.m4v)  do ( 

	move "%%~dpnf.*" OK 
	move "%%~dpnf-fanart.*" OK
	move "%%~dpnf-poster.*" OK

)

for %%f in (*.mkv)  do ( 

	move "%%~dpnf.*" OK 
	move "%%~dpnf-fanart.*" OK
	move "%%~dpnf-poster.*" OK

)

for %%f in (*.mp4)  do ( 

	move "%%~dpnf.*" OK 
	move "%%~dpnf-fanart.*" OK
	move "%%~dpnf-poster.*" OK

)

for %%f in (*.mpg)  do ( 

	move "%%~dpnf.*" OK 
	move "%%~dpnf-fanart.*" OK
	move "%%~dpnf-poster.*" OK

)

for %%f in (*.vob)  do ( 

	move "%%~dpnf.*" OK 
	move "%%~dpnf-fanart.*" OK
	move "%%~dpnf-poster.*" OK

)

for %%f in (*.rmvb)  do ( 

	move "%%~dpnf.*" OK 
	move "%%~dpnf-fanart.*" OK
	move "%%~dpnf-poster.*" OK

)
