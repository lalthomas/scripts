ReadMe
======

*Date of Creation* : 2015-12-22


config for big files

`call ffmpeg.exe -i %1 -qmin 2 -qmax 5 -ar 22050 "%~n1.mp4"`

config for small files
To improve the video quality, you can use a lower CRF value,e.g. anything down to 18. To get a smaller file, use a higher CRF,but note that this will degrade quality.
To improve the audio quality, use a higher quality value. For FAAC, 100 is default.

