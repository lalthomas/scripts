
for file in *.txt *.md
do
 # do something on "$file"
 grep -o '[^  ]*+[^  ]\+'  "$file" | grep '^+' | sort -u >>inbox.txt
 grep -o '[^  ]*@[^  ]\+' "$file" | grep '^@' | sort -u >>inbox.txt
done
