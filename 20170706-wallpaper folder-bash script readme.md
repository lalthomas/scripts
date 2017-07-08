% 20170706-wallpaper folder-bash script readme.md 	
% 2017-07-06 	
% Lal Thomas 	
% 20170706-wallpaper folder-bash script.sh 	
	
### Useful Extif Functionalities



thanks : https://petapixel.com/2012/05/25/hack-your-exif-data-from-the-command-line-five-fun-uses-for-exiftool/

extracts the focal length of each image, and writes it to a tabulated text file.

	exiftool -T -r -lens -focallength directory > exifoutput.txt
	
shutter speed habits.

	exiftool -T -r -lens -shutterspeed directory > exifoutput.txt


camera temperature

	    exiftool -T -r -lens -cameratemperature directory > exifoutput.txt
		
thanks : http://owl.phy.queensu.ca/~phil/exiftool/examples.html

Write to all files in a directory

    exiftool -artist=me c:/images
	
Print common meta information for all images in dir.

	exiftool -common dir

List meta information in tab-delimited column form for all images in directory DIR to an output text file named "out.txt".

	exiftool -T -createdate -aperture -shutterspeed -iso DIR > out.txt

Recursively extract common meta information from files in C directory, writing text output into files with the same names but with a C<.txt> extension

	exiftool -r -w .txt -common pictures

Extract all tags with names containing the word "Resolution" from an image.

	exiftool "-*resolution*" image.jpg
	
thanks : http://ninedegreesbelow.com/photography/exiftool-commands.html

	exiftool '-Directory<CreateDate' -d /media/ingest/newfolder/%y/%y%m -r /media/ingest/oldfolder

thanks : https://gist.github.com/rjames86/33b9af12548adf091a26	

Create CSV of Geo Information

	exiftool -csv -filename -imagesize -gps:GPSLatitude -gps:GPSLongitude ./ > long.csv
	
	
