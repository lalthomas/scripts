# bash script to move files to one folder up level if the parent folder contains only one folder
# lal thomas 2016-05-12

# runs on cygwin bash
# runs this script on the base folder
# base/01/AB/01.txt -> base/01/01.txt
# where 01 is having only AB folder


# thanks
# - http://stackoverflow.com/a/32429482/2182047
# - http://unix.stackexchange.com/a/86724/106566
# - http://superuser.com/a/62154/318277

# parse through folders

for d in */ ; do
    echo "$d"
	directory="$( echo $d | sed -e's/\///g')"
	cd "$directory"	
	# check for cd success
	if [ $? -eq 0 ]; then		
		# echo $PWD
		if [ "$(find "$PWD" -maxdepth 1 -type d -printf 1 | wc -m)" -eq 2 \
			-a "$(find "$PWD" -maxdepth 1 ! -type d -printf 1 | wc -m)" -eq 0 ]; then
			# folder contains only one folder			
			dir="$(find "$PWD" -maxdepth 1 -type d | sed -e's/\.\///g' )"			
			cd "$(ls)"		
			if [ $? -eq 0 ]; then
				mv * .[^.]* ..  > /dev/null 2>&1
				echo "contends moved..."
				cd ..
			fi						
		fi				
		cd ..
	fi		
done
