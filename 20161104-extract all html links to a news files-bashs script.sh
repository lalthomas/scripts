
for filename in *.html; do
	grep "<a href=" "$filename" | sed "s/<a href/\\n<a href/g" | sed 's/\"/\"><\/a>\n/2'| grep href| sort | uniq >>links.html
done