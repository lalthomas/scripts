# Cygwin Bash Script to analaye the zip file content extensions 
# and extract the mostly present extension 
# and rename the file with that
# Lal Thomas
# thanks : http://unix.stackexchange.com/a/41480/106566
# thanks : http://stackoverflow.com/a/25122981/2182047
# thanks : http://unix.stackexchange.com/a/147109/106566

for file in *.zip; 
do 
	echo "Processing $file file..";
	extension="${file##*.}"                     # get the extension
	filename="${file%.*}"                       # get the filename
	projecttype="$(unzip -l "$file" | awk 'NR > 3 {print $4}' | sed -e 's/.*\.//g' | tr -c '[:alnum:]' '[\n*]' | sort | uniq -c | sort -nr | head  -1 | awk '{ print $2}')" 
	wait
	if [[ $projecttype = *[!\ ]* ]]; then
		# $projecttype contains characters other than space"
		mv "$file" "${filename} $projecttype script.${extension}"    # rename file by moving it	
	fi
	
done