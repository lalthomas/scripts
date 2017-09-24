#!/bin/bash -x

# Filename : 20170923-create facebook friend url list.sh
# Author : Lal Thomas 
# Date : 2017-09-23
# © Lal Thomas (lal.thomas.mail@gmail.com)


# to run this script facebook inner html of friend list should be copied to clipboard
# only cygwin support

currentpath=$PWD
getclip >clipboard.html

winfilepath="$(cygpath -w "$PWD\clipboard.html")"
configpath="$(cygpath -w  "$scriptfolder/tools/tidy/setting-just-indent.ini")"

pushd "$scriptfolder\tools\tidy" > /dev/null 2>&1
# output=$(./tidy.exe  -config "$configpath" "$winfilepath")
./tidy.exe  -config "$configpath" "$winfilepath" >"$currentpath/tidy.html" 2>&1
popd > /dev/null 2>&1

# thanks : https://stackoverflow.com/a/16502803/2182047
egrep -o 'https?://www.facebook.com/[^ ]+' "tidy.html" | sort | uniq >links.txt

# to preserve old profile ids and strip characters after ? and &
findtext="profile.php?id="
replacetext=""
sed -i'' "s|$findtext|$replacetext|g; s/[\?\&\"].*//g" "links.txt"

