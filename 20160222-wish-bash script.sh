# Filename : 20160222-wish-bash script.sh
# Author : Lal Thomas 
# Date : 2016-02-22
# © Lal Thomas (lal.thomas.mail@gmail.com)

filename=$1
shift

alias wish=_main_

usage(){

 echo "wish" 
 echo " helper script to send wishes to people"
 
}

shortHelp(){

echo $today

}

help(){
 echo 
}

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


_main_(){

ACTION=$1
shift

case "$ACTION" in

	usage)
	usage	
	;;
	
	list)
	list	
	;;
	
	email)
	emailPeople
	;;
	
esac


	
}