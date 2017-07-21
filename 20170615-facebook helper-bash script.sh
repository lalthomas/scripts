#!/bin/bash -x

# Filename : 20170615-facebook helper-bash script.sh
# Author : Lal Thomas 
# Date : 2017-06-15
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 
currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias facebook=_facebook_main_

jsonvalue(){

	local KEY=$1
	local DATAFILE=$2
	cat "$DATAFILE" |  python -c "import json,sys;obj=json.load(sys.stdin);print obj['$KEY'];"	
	
}

_facebook_main_(){

	# Facebook_ID
	# www.facebook.com/zuck : 4			
	
	# Token generation https://developers.facebook.com/tools/explorer/
	local token="292485384124303|cUw30J5iOcJFrs9bAJ8Jgq6a-H4"

	
	get(){
				
		local OPTION=$1
		local facebookdata="$facebookID-data.json"
		local picfile="$facebookID-pic.json"
		local genderdata="$facebookID-gender.json"
		shift
	
		graphData(){
			
			
			local KEY=$1
			local DATAFILE=$2
			shift
			
			if [ ! -f "$PWD/$DATAFILE" ]; then				
				# echo "data file not found"
				curl --silent -X GET  "https://graph.facebook.com/v2.9/$facebookID?fields=id%2Cname%2Clink%2Cpicture&access_token=$token" >"$facebookdata"
			fi
			
			if [ -e "$DATAFILE" ]
			then		
				jsonvalue "$KEY" "$DATAFILE"
			else
				echo "Couldn't download data. Exiting"
				return
			fi
			
		
		}

		profilepic(){
					
			curl --silent -X GET "https://graph.facebook.com/$facebookID/picture?type=large&redirect=false" >"$picfile"
			# http://www.compciv.org/recipes/cli/jq-for-parsing-json/
			URL=$(cat "$picfile" | "$currentScriptFolder/tools/jq/jq.exe" -r '.data.url')	
			# thanks https://stackoverflow.com/a/35019553/2182047
			URL=${URL%$'\r'}			
			curl --silent -X GET $URL >"$facebookID-small.jpg"
			echo "$facebookID-small.jpg"
			
		}

		profilebigpic(){
				
			curl --silent -L -X GET "https://graph.facebook.com/$facebookID/picture?type=large&width=500&height=500"  >"$facebookID-big.jpg"
			echo "$facebookID-big.jpg"
		
		}
		
		genderData(){
				
			local KEY=$1
			local DATAFILE=$2
			
			local name="$(facebook get $facebookID name)"							
			# thanks : https://unix.stackexchange.com/a/53315/106566
			firstname="$( cut -d ' ' -f 1 <<< "$name" )";
					
			# download data from genderize.io
			if [ ! -f "$PWD/$DATAFILE" ]; then				
				# echo "data file not found"
				curl --silent -X GET  "https://api.genderize.io/?name=$firstname" >"$DATAFILE"
			fi
			
			# check for the download
			if [ -e "$DATAFILE" ]
			then		
				jsonvalue "$KEY" "$DATAFILE"
			else
				echo "Couldn't download data. Exiting"
				return
			fi

			
		}
		
		cleanup(){
			
			rm "$facebookdata"
			rm "$genderdata"
			rm "$picfile"
			rm "$facebookID-small.jpg"
			rm "$facebookID-big.jpg"
			
		}
		
		
		case "$OPTION" in
			id|name|link) graphData $OPTION $facebookdata ;;
			gender) genderData "gender" $genderdata ;;
			profile-pic) profilepic;;
			profile-pic-big) profilebigpic;;
			cleanup) cleanup;;
		esac
		
		
	}
	
	
	usage(){
		
		echo 
        echo "facebook OPTIONS"      
        echo " helper script to managing facebook.com"   
        echo 
        echo "OPTIONS are..."
        echo 		
		echo "get <id> id "
		echo "get <id> name"
		echo "get <id> link"
		echo "get <id> gender"
		echo "get <id> profile-pic"
		echo "get <id> profile-pic-big"
		echo "clean <id>"
		echo "usage"
		
	}
	

	ACTION=$1
	shift

	# test the script
	# echo $filename $ACTION
	case "$ACTION" in		
		help|usage)		
			usage 
		;;
		get) 			
			facebookID=$1
			shift
			[[ $facebookID =~ ^[0-9]+$ ]] && get $@
		;;	
	esac


}
