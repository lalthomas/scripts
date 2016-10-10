# Author : Lal Thomas 
# Date : 2016-02-22
# © Lal Thomas (lal.thomas.mail@gmail.com)

# get the file to process
filename=$1
shift

alias wish=_wish_main_

_wish_main_(){  

	birthday_math_pattern="^[0-9]\{4\}-$monthCount-$dayCount"

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
    
        read -p "enter occasion title [ happy birthday (default)] : " occasion       
        [[ -z "${occasion// }" ]] && occasion="happy birthday"  
        read -p "enter name : " name
        read -p "enter email : " address
        read -p "enter comment : " comment
        read -p "enter date of occasion YYYY-MM-DD : " occasionDate 
        # echo the lowercase
        echo "$occasionDate | $name <$address> | $occasion | $comment" | awk '{print tolower($0)}' >>"$filename"    
        echo "entry : \"$occasionDate | $name <$address> | $occasion | $comment\" added successfully..."
    
    }
	
	itemsMatchPattern(){		 
			
			pattern="$1"
			email="$2"
			emailClient="D:\PortableApps.com\PortableApps\ThunderbirdPortable\ThunderbirdPortable.exe"				

			
			if [ -z "$email" ]; then
				echo "No | Occasion             | Name(s)                                | Comment             "
				echo "---| -------------------- | -------------------------------------- | --------------------"
			fi
			
			counter=1
			grep -e $pattern "$filename" | while read -r  line ;
			do      				
				name=$(echo $line | awk -F'|' '{print $2}')
				occasion=$(echo $line | awk -F'|' '{print $3}')
				comment=$(echo $line | awk -F'|' '{print $4}')							
				if [ -z "$email" ]; then
					echo $counter " | " $occasion " | " $name  " | " $comment
				elif [ "$email" = "yes" ]; then									
					cygstart $emailClient -compose "to='"$name"',subject="$occasion										
				fi						
				counter=$((counter + 1))  
			done									
		}	
			
	# cat --number "$filename"			
	
	today(){		
		OPTION=$1
		today_match_pattern="^[0-9]\{4\}-$monthCount-$dayCount"
		case "$OPTION" in		
			email)
				itemsMatchPattern $today_match_pattern "yes"
				;;
				
			*)
				itemsMatchPattern $today_match_pattern
				;;
		esac
	}	
	
	yesterday(){
	
		OPTION=$1
		yesterday_match_pattern="^[0-9]\{4\}-$(date --date='yesterday' +'%m-%d')"
		case "$OPTION" in					
			email)				
				itemsMatchPattern $yesterday_match_pattern "yes"
				;;					
			*)			
				itemsMatchPattern $yesterday_match_pattern
				;;
			
		esac
	
	}
	   
    openfile(){      
      cygstart "$filename"
    }

    usage(){

        echo 
        echo "wish OPTIONS"      
        echo " helper script to send wishes to people"   
        echo 
        echo "OPTIONS are..."
        echo 
		echo " add"         
		echo " open"
		echo " today" 
		echo " today email"		
		echo " today list"
		echo " yesterday"        
		echo " yesterday email"				
		echo " yesterday list"	         
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
    open)
        openfile 
        ;;  
		
	today)	
		today "$@"
		;;    
	yesterday)
		yesterday "$@"
		;;
	*)	
		echo
		echo "wrong option : taking default action"
		echo
		today "$@"
		;;
	
esac
    
}