# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

## pocket bookmarks

alias bookmark=_bookmark_main
filename=$1
shift

_bookmark_main(){  

	mailtopocket() {
		echo "$1" | mail -s "$1" "add@getpocket.com"
	}
	alias mailtopocket=mailtopocket

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
    
	pocket_import() {

		# TODO modify for argument
		
		pocketfile=$1
		echo pocket file $pocketfile
		sed -E "s/\<li\>(.*)\<\/li\>/\1/g" <$pocketfile | \
		sed -E "s/(.*)time_added\=\"(.*)\" tags=\"(.*)\"/\2-\1\3/g" | \ 
		sed -E "s/^(.*)$/\<li\>\1<\/li\>/g" >$pocketfile \
		&& pandoc --no-wrap -o bookmarks.md $pocketfile \
		&& open "bookmarks.md"
	}
	 add(){  
		echo todo:
		# TODO: implement add functionality
	 }
	
	 list(){ 
		echo todo:
		# TODO: implement list functionality
	 }

	 listall(){
    
     cat --number "$filename"
    
    }
	
	openfile(){
	  
	  cygstart "$filename"
	}

	 usage(){

			echo 
			echo "bookmark OPTIONS"      
			echo " helper script to manage bookmark"   
			echo 
			echo "OPTIONS are..."
			echo 
			echo " add"
			echo " email"
			echo " list"
			echo " listall"
			echo " open"
			echo " pocket_import"
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
		
		pocket_import)
			
			path=$1
			pocket_import $1
			;;
		
	esac


}