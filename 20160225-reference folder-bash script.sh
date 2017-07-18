#!/bin/bash -x

# Filename : 20160225-reference folder-bash script.sh
# Author : Lal Thomas 
# Date : 2017-04-05
# © Lal Thomas (lal.thomas.mail@gmail.com)

# initialize global variables 
currentScriptFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
alias rf=_reference_main_

## main ##

# main entities are 
#	/archive
#	
#	checklist
#	manual notes
#	procedure
#	doc
#	dump file
#	index files
#	playlist
#	favourites
#	contact files
#	list

replacetextinfile(){

	findtext=$1
	replacetext=$2
	file=$3
	
	# echo $findtext
	# echo $replacetext
	# echo $file
	
	# regular expression search
	# sed -i'' "s/$(echo $findtext | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/$replacetext/" "$file"
	
	# non regular expression search
	sed -i'' "s|$findtext|$replacetext|g" "$file"
	
}

string_convert_to_lower(){
	
		# convert to lowercase
		echo $1 | tr "[:upper:]" "[:lower:]"
		
}

_reference_main_(){
	
	commit(){

		g repo commit '$referenceRootPath' "update files"
	
	}

	contact(){
	
		view(){
			
			# Args : [<property1: <filter1>] [<property12: <filter2>]
			:
			
		}
		
		create(){
				
		
			args=$@
									
			# args : <name> or <facebook ID>			
			if [[ "$args"=~"^[0-9]*$" ]]; then				
				# it is a facebook ID
				facebookId=$args
				echo
				echo "fetching data from facebook.com..."
				id=$(facebook get $facebookId id)
				name=$(facebook get $facebookId name)
				link=$(facebook get $facebookId link)								
				pic=$(facebook get $facebookId profile-pic)
				pic_big=$(facebook get $facebookId profile-pic-big)
				
			elif [[ "$args" =~ "^[a-z]" ]]; then
				# it is name
				name="$args"
								
			fi			
			
			# convert the name to lower
			local lowername=$(string_convert_to_lower "$name")
			
			# copy template to new file
			local contacttemplatefile="D:\Dropbox\do\support\20140618-home support template-contact card.md"			
			local contactfile="$today-$lowername contact file.md"			  
			cat "$contacttemplatefile" >"$contactfile"
			
			# replace place holders
			replacetextinfile "%NAME%" "$name" "$contactfile"
			replacetextinfile "%LONGDATE%" "$longdate" "$contactfile"
			
			# add small image			
			# echo "![${longdate}](data:image/jpeg;base64,$(base64 -w 0 "${pic}"))" >"$pic.tmp"						
			# printf '%s\n' "/<!-- %IMAGE% -->/-1r $pic.tmp" w | ed "$PWD/$contactfile"	> /dev/null 2>&1
			
			# add big image 
			echo "![${longdate}](data:image/jpeg;base64,$(base64 -w 0 "${pic_big}"))" >"$pic_big.tmp"						
			printf '%s\n' "/<!-- %IMAGE% -->/-1r $pic_big.tmp" w | ed "$PWD/$contactfile"	> /dev/null 2>&1
			
			
			# Clean Up Files
			# -----------------
			
			# remove temporary files
			# rm "$pic.tmp"
			rm "$pic_big.tmp"			
			
			# cleanup of temporary files
			facebook get $facebookId cleanup
			
			
			# add circle info
							
			b file path init "D:\Dropbox\do\reference\20150721-contact circles.txt"
			echo 
			b file prompt "enter keyword for circle : "
			circle="$(b file result)"
			replacetextinfile "%CIRCLE%" "${circle}" "$contactfile"
			
			
			# add birthday info			
			read -p "enter birthday : " birthday;
			isobirthday=$(date -d"$birthday" +%Y-%m-%d)			
			replacetextinfile "%BIRTHDAY%" "${isobirthday}" "$contactfile"
			
			
			# add gender info
			read -p "enter gender (M/F) : " gender;			
			if [[ $gender =~ [mf] ]]; then 				
				if [ $gender == "m" ]; then 
					gender="Male" 
				else
					gender="Female"
				fi				
				replacetextinfile "%GENDER%" "${gender}" "$contactfile"				
			else
				echo "unknown choice"			 
			fi
			
			
			
			
		}
		
		find(){
			
			# Args : "string "
			:
			
		}
		
		update(){
		
			 # Args : [replace | append]
			 
			 replace (){
				
				# Args : [<property: <value>]
				:
			 }
			 
			 append(){
				
				# Args : [<property: <value>]
				:
			 }
			 
			 delete(){
				
				# Args : <property>
				:
			 }
		}
		
		open(){
		
			# <list id1> <list id2> <list id3>
			:
		}
		
		publish(){
		
			# <list id1> <list id2>
			:
		}
		
		remove(){
			
			# <list id1> <list id2>
			:
		}
		
		archive (){
			
			# < list id1> <list id2>
			:
		}
		
		add(){
			
			:
			
			log(){
				
				# <list id> <log entry>
				:	
			}
		}
		
		import(){
		
			# Args : <type>
			
			# thanks http://www.folkstalk.com/2012/07/bash-shell-script-to-read-parse-comma.html
			INPUT_FILE='unix_file.csv'
			IFS=','
			while read OS HS
			do
			echo "Operating system - $OS"
			echo "Hosting server type - $HS"
			done < $INPUT_FILE
		
		}
		
		export(){
			
			# Args : <type> [<property>:<filter>]
			:
		}
		
		OPTION=$1
		shift
	
		case $OPTION in
		create) create $@;;
		esac
		
	}
	
	manual(){
		
		OPTION=$1
		shift
		
		create(){
			
			# TODO: manage already existing files
			
			topic=$@	
			filename="$today-$topic manual notes.md"
			
			# add contend
			echo "% $topic manual notes" >"$filename"
			echo "% Lal Thomas" >>"$filename"
			echo "% $longdate" >>"$filename"
			echo "">>"$filename"
			echo "Date		Note" >>"$filename"
			echo "----------	-----------">>"$filename"
			
			# add to inbox.txt
			local filepath=$(cygpath -d "$PWD/$filename")
			echo "$longdate add \"$filepath\" to project file" >>"$(cygpath -u "D:\Dropbox\do\inbox.txt")"
			
			# start inbox.txt
			start "" "D:\Dropbox\do\inbox.txt" > /dev/null 2>&1 || cygstart "D:\Dropbox\do\inbox.txt"  > /dev/null 2>&1	
			
			# start $filename file
			start "" "$PWD/$filename" > /dev/null 2>&1 || cygstart "$PWD/$filename"  > /dev/null 2>&1	
			
			
		}
				
		case $OPTION in
		create) create $@;;
		esac
		
	}
	
	usage(){
		
		echo ""
		echo "contact create < name | facebookID >"
		echo "manual create <topic>"
		
	}
	
	OPTION=$1
	shift
	
	pushd "D:\Dropbox\do\reference" > /dev/null 2>&1
	
	case $OPTION in 
		commit) commit;;
		contact) contact $@;;
		manual) manual $@;;		
		usage|help) usage;;
		*) echo "unknown option $OPTION "
	esac
		
	popd > /dev/null 2>&1
	
}
