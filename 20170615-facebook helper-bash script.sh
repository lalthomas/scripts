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
	cat "$DATAFILE" |  python -c "import json,sys;obj=json.load(sys.stdin);print(obj['$KEY'],end='');"
	
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
		
		friendlist(){
							
			firefox="C:\Program Files\Mozilla Firefox\firefox.exe"
			cygstart "$firefox" "http://www.facebook.com/$facebookID/friends_all"
			name="$(graphData name $facebookdata)"
			name="$(b string convert lower "$name")"
			currentpath=$PWD
			read -n1 -r -p "copy the inner html and press any key..." key </dev/tty			
			getclip >clipboard.html
			winfilepath="$(cygpath -w "$PWD\clipboard.html")"
			configpath="$(cygpath -w  "$scriptfolder/tools/tidy/setting-just-indent.ini")"
			pushd "$scriptfolder\tools\tidy" > /dev/null 2>&1
			# output=$(./tidy.exe  -config "$configpath" "$winfilepath")
			./tidy.exe  -config "$configpath" "$winfilepath" >"$currentpath/tidy.html" 2>&1
			popd > /dev/null 2>&1

			docpath="$(cygpath -u "$docRootPath/$today-$name friend list.txt")"
			# thanks : https://stackoverflow.com/a/16502803/2182047
			egrep -o 'https?://www.facebook.com/[^ ]+' "tidy.html" | sort | uniq >"$docpath"

			# to preserve old profile ids and strip characters after ? and &
			findtext="profile.php?id="
			replacetext=""
			sed -i'' "s|$findtext|$replacetext|g; s/[\?\&\"].*//g" "$docpath"

			rm clipboard.html
			rm tidy.html
			cleanup

			b file open_with_npp "$docpath"
			gtd inbox add filepath "$docpath"
			echo "$(basename "$docpath")" > /dev/clipboard
			echo "filename copied to clipboard..."

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
			friendlist) friendlist;;
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
		echo "get cleanup <id|url>"
		echo "get friendlist <id|url>"
		echo "get gender <id|url>"
		echo "get id <id|url>"
		echo "get link <id|url>"
		echo "get name <id|url>"
		echo "get profile-pic <id|url>"
		echo "get profile-pic-big <id|url>"
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
