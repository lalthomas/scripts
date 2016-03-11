# Filename : 20160222-wish-bash script.sh
# Author : Lal Thomas 
# Date : 2016-02-22
# © Lal Thomas (lal.thomas.mail@gmail.com)

# get the file to process
filename=$1
shift

alias wish=_wish_main_

_wish_main_(){	

	dieWithHelp(){
		case "$1" in
			help)       
			help;;
			shorthelp) 
			shorthelp;;
		esac
		shift
		die "$@"
	}

	die(){
		echo "$*"
		exit 1
	}
	
	add(){	 
	
	read -p "enter occasion title [ happy birthday (default)] :" occasion		
	[[ -z "${occasion// }" ]] && occasion="happy birthday"	
	read -p "enter name : " name
	read -p "enter email : " address
	read -p "enter comment : " comment
	read -p "enter date of occasion YYYYMMDD : " occasionDate 
	# echo the lowercase
	echo "$occasionDate | $name <$address> | $occasion | $comment" | awk '{print tolower($0)}' >>"$filename"	
	echo "entry : \"$occasionDate | $name <$address> | $occasion | $comment\" added successfully..."
	
	}

	list(){
	 
	 echo "No | Occasion  | Name(s)                   | Comment             "
	 echo "---| ----------| ------------------------- | --------------------"
	 counter=1
	 grep -e "[0-9]\{4\}$monthCount$dayCount" "$filename" | while read -r  line ; do      
	  name=$(echo $line | awk -F'|' '{print $2}')
	  occasion=$(echo $line | awk -F'|' '{print $3}')
	  comment=$(echo $line | awk -F'|' '{print $4}')
	  echo $counter " | " $occasion " | " $name  " | " $comment
	  counter=$((counter + 1))  
	 done
	 
	}
	
	listall(){
	
	 cat "$filename"
	
	}

	emailPeople(){
		
	  emailClient="D:\PortableApps.com\PortableApps\ThunderbirdPortable\ThunderbirdPortable.exe"
	  counter=1
	  grep -e "[0-9]\{4\}$monthCount$dayCount" "$filename" | while read -r  line ; do      
		name=$(echo $line | awk -F'|' '{print $2}')
		occasion=$(echo $line | awk -F'|' '{print $3}')  
		cygstart $emailClient -compose "to='"$name"',subject="$occasion
		counter=$((counter + 1))  
	  done

	}

	openfile(){
	  
	  cygstart "$filename"
	}

	usage(){

	 echo "wish" 
	 echo " helper script to send wishes to people"
	 
	}
	
ACTION=$1
shift

# test the script
# echo $filename $ACTION

case "$ACTION" in
	
	help|usage)
	usage	
	;;
	
	add)
	arguments="$@"
	echo $arguments
	add $arguments
	;;
	
	list)
	list	
	;;
		
	listall)
	listall
	;;
	
	open)
	openfile
	;;
	
	email)
	emailPeople
	;;
	
	
	
esac
	
}