# Hidden Applications

# open -a 'FileMerge'"

# remove console colors using sed
# sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"

case "$OSTYPE" in
darwin*) export rootpath="/Users/rapid/Dropbox" ;; # OSX
msys*) export rootpath="/d/Dropbox"  ;; # Windows
*) echo "unknown: $OSTYPE" ;;
esac


# alias
alias clearhistory="history -c"
alias commitdo='sh "$rootpath/Do/commit-do-changes.sh"'
alias commitreference='sh $rootpath/Reference/@commit-changes.sh"'
alias commitsupport='sh "$rootpath/Support/@commit-changes.sh"'
alias createblog='sh "$rootpath/Blog/create-blog-post-repo.sh"'
alias createwiki='sh "$rootpath/Office Wiki/create-wiki-post-repo.sh"'
alias devtodo='sh $rootpath/Do/dev/todo.sh list'
alias doarchive="mt archive && wt archive && dt archive"
alias dt='sh "$rootpath/Do/dev/todo.sh"'
alias exportbashhistory="grep -v '^#' $HISTFILE >'$rootpath/Office Docs/work bash history.txt'"
alias metodo='sh $rootpath/Do/me/todo.sh list'
alias metodobirdseyereport="mt birdseye > '$rootpath/Office Docs/me todo birdseye report for week-.md'"
alias mt='sh "$rootpath/Do/me/todo.sh"'
alias organizebookmarks='sed -E "s/\<li\>(.*)\<\/li\>/\1/g" <$rootpath/inbox/ril_export.html | sed -E "s/(.*)time_added\=\"(.*)\" tags=\"(.*)\"/\2-\1\3/g" | sed -E "s/^(.*)$/\<li\>\1<\/li\>/g" >$rootpath/inbox/bookmarks.html && pandoc --no-wrap -o $rootpath/inbox/bookmarks.md $rootpath/inbox/bookmarks.html && open "$rootpath/inbox/bookmarks.md"'
alias startday='sh "$rootpath/scripts/office/start-of-day.sh"'
alias today="$(date '+%Y%m%d')"
alias worktodo='sh $rootpath/Do/work/todo.sh list'
alias worktodobirdseyereport="wt birdseye > '$rootpath/Docs/work todo birdseye report for week-.md'"
alias wt='sh "$rootpath/Do/work/todo.sh"'

# remember the milk me update

# mt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "me todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# mt archive

# wt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "work todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# wt archive

# dt listpri | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | sed -E "s/([0-9]{3})[[:space:]](\((A|B|C)\))[[:space:]]([0-9]{4}-[0-9]{2}-[0-9]{2})//g"  | sed -E "s/(\+(.*))|(\@(.*))//g"  | sed '/TODO\:/d' | sed '/--/d' | mail -s  "dev todo" 'lalthomas+24a2d5+import@rmilk.com' 'lal.thomas.mail+todo@gmail.com'
# dt archive
