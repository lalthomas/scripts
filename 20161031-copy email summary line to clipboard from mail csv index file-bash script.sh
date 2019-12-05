# !/bin/bash
# copy email summary line to clipboard from mail csv index file
# Lal Thomas
# 2016-10-31

currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pushd "D:\Temp"

echo -e "$(
IFS=","
while read subject sender recipient date x1
do 		
	# remove spaces
	maildate=$(echo $date)
	# change to iso date
	isodate=$(date -d "$maildate" +'%Y-%m-%d')	
	echo -e "$isodate	$sender sent email with subject $subject to $recipient"	
done < index.csv)\n" > /dev/clipboard  &&   rm -f index.csv

popd

# TODO:  correctly implement return status
if [ $? -eq 0 ]
then
	echo "action taken"
	echo "subject of emails listed in index.csv copied..."
	echo "index.csv file trashed..."	
else
  echo "Could not find file" >&2
fi

exit
