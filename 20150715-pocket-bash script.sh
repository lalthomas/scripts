# Filename : 20150715-pocket-bash script.sh
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

## pocket bookmarks

mailtopocket() {
	echo "$1" | mail -s "$1" "add@getpocket.com"
}
alias mailtopocket=mailtopocket


OrganizeBookmarks() {

 	sed -E "s/\<li\>(.*)\<\/li\>/\1/g" <$rootpath/inbox/ril_export.html | \
	sed -E "s/(.*)time_added\=\"(.*)\" tags=\"(.*)\"/\2-\1\3/g" | \ 
 	sed -E "s/^(.*)$/\<li\>\1<\/li\>/g" >$rootpath/inbox/bookmarks.html \
 	&& pandoc --no-wrap -o $rootpath/inbox/bookmarks.md $rootpath/inbox/bookmarks.html \
 	&& open "$rootpath/inbox/bookmarks.md"
}
alias organizebookmarks=OrganizeBookmarks
