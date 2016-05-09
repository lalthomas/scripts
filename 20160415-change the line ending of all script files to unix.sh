for file in *.sh
do
# do something on "$file"
dos2unix --force --m2d "$file"
done