# Author : Lal Thomas 
# Date : 2016-02-22
# � Lal Thomas (lal.thomas.mail@gmail.com)

# get the file to process
filename=$1
shift

alias wish=_wish_main_

_wish_main_(){  
	
	today_match_pattern="^\"[0-9]\{4\}-$monthCount-$dayCount\""
	yesterday_match_pattern="^\"[0-9]\{4\}-$(date --date='yesterday' +'%m-%d')\""
	tomorrow_match_pattern="^\"[0-9]\{4\}-$(date --date='tomorrow' +'%m-%d')\""
	
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
			emailClient="C:\PortableApps.com\PortableApps\ThunderbirdPortable\ThunderbirdPortable.exe"				

			
			if [ -z "$email" ]; then
				echo "No | Occasion             | Name(s)                                | Comment             "
				echo "---| -------------------- | -------------------------------------- | --------------------"
			fi
			
			counter=1
			formatstyle="\n %s %s %50s %10s\n"
			grep -e $pattern "$filename" | while read -r  line ;
			do      				
				name=$(echo $line | awk -F, '{print $2}'| tr -d '"')
				occasion=$(echo $line | awk -F, '{print $3}' | tr -d '"')
				comment=$(echo $line | awk -F, '{print $4}' | tr -d '"')
				if [ -z "$email" ]; then
					echo $counter " | " $occasion " | " $name  " | " $comment
				elif [ "$email" = "yes" ]; then									
					cygstart $emailClient -compose "to='"$name"',subject="$occasion										
				fi						
				counter=$((counter + 1))  
			done									
		}	
			
	# cat --number "$filename"			
	
	email(){		
		OPTION=$1	
		
		pgmpath="20161125-remove readonly attriubute from thunderbird portable folder-dos batch script.bat"		
		"$scriptfolder/$(cygpath -u "${pgmpath}")"		
				
		case "$OPTION" in					
			yesterday)
				itemsMatchPattern $yesterday_match_pattern "yes"
				;;
			today)
				itemsMatchPattern $today_match_pattern "yes"
				;;
			tomorrow)
				itemsMatchPattern $tomorrow_match_pattern "yes"
				;;
			*)		
				itemsMatchPattern $today_match_pattern "yes"
				;;
		esac
	}	
	
	list(){	
		OPTION=$1		
		case "$OPTION" in								
			yesterday)
				itemsMatchPattern $yesterday_match_pattern
				;;
			today)
				itemsMatchPattern $today_match_pattern
				;;
			tomorrow)
				itemsMatchPattern $tomorrow_match_pattern
				;;
			*)		
				itemsMatchPattern $today_match_pattern
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
		echo " email" 
		echo " email today "		
		echo " email yesterday"		
		echo " email tomorrow"		
		echo " list"
		echo " list today"				
		echo " list yesterday"	         		     
		echo " list tomorrow"	         		     		
		echo " open"	
	}
    
ACTION=$1
shift

# Get option
option=$1;  
shift

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
	email)
		case "$option" in
		today)
			email today
			;;
		yesterday)
			email yesterday
			;;
		tomorrow)
			email tomorrow
			;;
		*)
			email today
			;;
		esac
        ;;
	
	list)		            
		case "$option" in
		today)
			list today
			;;
		yesterday)
			list yesterday
			;;   
		tomorrow)
			list tomorrow
			;;
		*)
			list today
			;;
		esac
        ;;	
	*)	
		echo
		echo "wrong option : taking default action"
		echo
		list
		;;	
esac    
}