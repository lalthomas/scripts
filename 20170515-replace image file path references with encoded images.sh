# !/bin/bash -x
# Filename : 20170515-replace image file path references with encoded images.sh
# Author : Lal Thomas 
# Date : 2017-05-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

pushd "D:\temp\new" > /dev/null 2>&1
for p in *.jpg; do									
	
	# echo "$p"		
	
	# remove the extension of file
	filenameNoExt="${p%.*}"
	# escape the filename
	escFilename=$(echo "$filenameNoExt" | sed -e 's/\([[\/.*]\|\]\)/\\&/g')	
	
	# files
	# echo "data:image/jpeg;base64,$(base64 -w 0 "${p}")" >$p.txt
	
	# images
	echo "![${escFilename}](data:image/jpeg;base64,$(base64 -w 0 "${p}"))" >"$p.tmp"
	
	# echo $output	
	for f in *.md; do	
		
		# echo $f
		
		# couldn't do it with sed as the replace string is big 
		# thanks https://unix.stackexchange.com/a/284331
		# printf '%s\n' '/BASE64/r base64.txt' 1 '/BASE64/d' w | ed "$PWD/$f"
		printf '%s\n' "/$p/r $p.tmp" 1 "/$p/d" w | ed "$PWD/$f"	> /dev/null 2>&1
		
	done			
	
	rm "$p.tmp"
	
	# remove file if any included in markdown file	
	# thanks http://stackoverflow.com/a/4749368/2182047
	# exit status is 0 (true) if the name was found, 1 (false) 
	if grep -q "${escFilename}" *.md
	then
		rm "$p"
	fi
	
done
popd > /dev/null 2>&1

# read -n1 -r -p "Press any key to continue ..." key


