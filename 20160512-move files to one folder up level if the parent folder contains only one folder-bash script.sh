# bash script to move files to one folder up level if the parent folder contains only one folder
# lal thomas 2016-05-12

# runs on cygwin bash

# thanks
# - http://stackoverflow.com/a/32429482/2182047
# - http://unix.stackexchange.com/a/86724/106566
# - http://superuser.com/a/62154/318277

# parse through folders

for d in */ ; do
    echo "$d"
	directory="$( echo $d | sed -e's/\///g')"
	cd $directory
	# echo $PWD
	if [ "$(find "$PWD" -maxdepth 1 -type d -printf 1 | wc -m)" -eq 2 \
			-a "$(find "$PWD" -maxdepth 1 ! -type d -printf 1 | wc -m)" -eq 0 ]; then
		# folder contains only one folder			
		dir="$(find "$PWD" -maxdepth 1 -type d | sed -e's/\.\///g' )"			
		cd "$(ls)"		
		mv * .[^.]* ..  > /dev/null 2>&1
		echo "contends moved..."
		cd ..
   	fi	
	cd ..
done
