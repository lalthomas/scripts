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
	cat "$DATAFILE" |  python -c "import json,sys;obj=json.load(sys.stdin);print(obj['$KEY']);"
	
}

_facebook_main_(){

	# Facebook_ID
	# www.facebook.com/zuck : 4			
	
	# Token generation https://developers.facebook.com/tools/explorer/
	local token="292485384124303|cUw30J5iOcJFrs9bAJ8Jgq6a-H4"	
	get(){
		
		local facebookID=""
		
		local OPTION_1=$1
		shift
		
		local OPTION_2=$@
		shift
		
		local facebookurlregex='(https?:\/\/)?(www\.)?facebook.com\/[a-zA-Z0-9(\.\?)?]'
		if [[ $OPTION_2 =~ ^[0-9]+$ ]]; then
			facebookID=$OPTION_2
		elif [[ $OPTION_2 =~ $facebookurlregex ]]; then
			facebookurl=$OPTION_2			
			facebookID=$(IDfromURL $facebookurl)
			# echo $facebookID
		fi
		
		local facebookdata="$facebookID-data.json"
		local picfile="$facebookID-pic.json"
		local genderdata="$facebookID-gender.json"
		local profile_pic_small="$facebookID-small.jpg"
		local profile_pic_big="$facebookID-big.jpg"
		
		IDfromURL(){
			
			local id
			local fburl=$@
					
			fbpath=$(echo $fburl  | sed -n -r 's/.*(https?:\/\/)?(www\.)?facebook.com\/(.*)/\3/p')
			
			[[ $fbpath =~ ^[0-9]+$ ]] && { id=$fbpath; echo $id ; return;  }
			[[ $fbpath =~ ^profile.php ]] && { id=$(echo $fbpath| sed -n -r 's/profile.php\?id=(.*)/\1/p'); echo $id ; return; }
			
			# you need to install nodejs,npm and facebook-id-of package to get this
			[[ $fbpath =~ ^[a-z]* ]] && { 
			
				username=$fbpath;				
				if [ ! -f "$PWD/$username.fbb" ]; then
					# echo "file not found"
					facebook-id-of $username >$username.fbb;
				fi;				
				read id <<< "$(cat $username.fbb | grep "Facebook ID of" | sed 's/^.*is //')";
				echo $id ; 
				return; 
			}
						
		}
		
		graphData(){
			
			local KEY=$1
			local DATAFILE=$2
			shift
			
			if [ ! -f "$PWD/$DATAFILE" ]; then
				# echo "data file not found"
				curl --silent -X GET  "https://graph.facebook.com/v2.10/$facebookID?fields=id%2Cname%2Clink%2Cpicture&access_token=$token" >"$facebookdata"
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
			curl --silent -X GET $URL >$profile_pic_small
			echo "${profile_pic_small}"
			
		}

		profilebigpic(){
				
			curl --silent -L -X GET "https://graph.facebook.com/$facebookID/picture?type=large&width=500&height=500"  >"${profile_pic_big}"
			echo "${profile_pic_big}"
		
		}
		
		genderData(){
				
			local KEY=$1
			local DATAFILE=$2
			
			local name="$(facebook get name $facebookID)"
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
								
			set +x
			rm "${PWD}/${facebookdata}" > /dev/null 2>&1
			rm "${PWD}/${genderdata}" > /dev/null 2>&1
			rm "${PWD}/${picfile}" > /dev/null 2>&1
			rm "${PWD}/${profile_pic_small}" > /dev/null 2>&1
			rm "${PWD}/${profile_pic_big}" > /dev/null 2>&1
			rm $PWD/*.fbb > /dev/null 2>&1
			
		}
		
		case "$OPTION_1" in
			id|name|link) graphData $OPTION_1 $facebookdata ;;
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
		echo "get id <id|url>"
		echo "get name <id|url>"
		echo "get link <id|url>"
		echo "get gender <id|url>"
		echo "get profile-pic <id|url>"
		echo "get profile-pic-big <id|url>"
		echo "get cleanup <id|url>"
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
			get $@
		;;
	esac


}
