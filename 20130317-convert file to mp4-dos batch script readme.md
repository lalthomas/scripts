% 20130317-convert file to mp4-dos batch script readme.md 	
% 2015-12-22	
% Lal Thomas 	
% D:\Dropbox\project\20131027-scripts project\20130317-convert file to mp4-dos batch script.bat 	
	

config for big files

`call ffmpeg.exe -i %1 -qmin 2 -qmax 5 -ar 22050 "%~n1.mp4"`

config for small files
To improve the video quality, you can use a lower CRF value,e.g. anything down to 18. To get a smaller file, use a higher CRF,but note that this will degrade quality.
To improve the audio quality, use a higher quality value. For FAAC, 100 is default.

