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

open_file(){
				
	cygstart "C:/Program Files (x86)/Notepad++/notepad++.exe" "$1"
				
}

_reference_main_(){
	
	contact(){
			
		view(){
			
			# Args : [<property1: <filter1>] [<property12: <filter2>]
			:
			
		}
		
		create(){
			
			local id=""
			local email=""
			local name=""
			local gender=""
			local link=""
			local pic=""
			local pic_big=""
			local birthday=""
			local religion=""
			local homeaddress=""
			local workaddress=""
			
			verify_existing_records(){
		
				search_query=$@
				echo
				echo "Searching existing records ..."
				if [ -z "$(b search file $search_query)" ]; then
					echo "No records found."
					return 0
				else
					echo
					echo "Records found with $search_query term"
					echo															
					b search file $search_query													
					echo
					read -p "Do you want to create contact record (y|n) ? " opt;
					[[ $opt == "n" ]] && { return 1; } || { return 0; }
				fi								
				
			}

			addlog(){
			
				:
			}
			
			addnote(){
				
				:
			}

			pull_data_from_facebook(){
			
			
				# it is a facebook ID
				facebookId=$1
				echo
				echo "fetching data from facebook.com..."
				
				# fetch data from facebook				
				id=$(facebook get $facebookId id)
				name=$(facebook get $facebookId name)
				gender=$(facebook get $facebookId gender)
				link=$(facebook get $facebookId link)								
				pic=$(facebook get $facebookId profile-pic)
				pic_big=$(facebook get $facebookId profile-pic-big)
				
				
			}
			
			add_image_from_facebook(){
				
				
				# add small image			
				# echo "![${longdate}](data:image/jpeg;base64,$(base64 -w 0 "${pic}"))" >"$pic.tmp"						
				# printf '%s\n' "/<!-- %IMAGE% -->/-1r $pic.tmp" w | ed "$PWD/$contactfile"	> /dev/null 2>&1
				# # clean up
				# rm "$pic.tmp"
				
				# add big image 
				echo "![${longdate}](data:image/jpeg;base64,$(base64 -w 0 "${pic_big}"))" >"$pic_big.tmp"						
				printf '%s\n' "/<!-- %IMAGE% -->/-1r $pic_big.tmp" w | ed "$PWD/$contactfile"	> /dev/null 2>&1
				# clean up 
				rm "$pic_big.tmp"
				
				
			}
			
			get_data_from_user(){
			
				# add name
				name="$1"			
				
			}
			
			create_file_from_template(){
			
				# convert the name to lower
				local lowername=$(string_convert_to_lower "$name")			
				# copy template to new file
				local contacttemplatefile="D:\Dropbox\do\support\20140618-home support template-contact card.md"			
				contactfile="$today-$lowername contact file.md"			  
				cat "$contacttemplatefile" >"$contactfile"
				
			}
		
			fill_template(){
								
				# replace place holders
				replacetextinfile "%NAME%" "$name" "$contactfile"
				replacetextinfile "%LONGDATE%" "$longdate" "$contactfile"	

				# add circle info				
				b file path init "D:\Dropbox\do\reference\20150721-contact circles.txt"
				echo 
				b file prompt "enter keyword for circle : "
				circle="$(b file result)"
				replacetextinfile "%CIRCLE%" "${circle}" "$contactfile"
				
				# add gender info
				if [ -z ${gender} ];then												
					read -p "enter gender (M/F) : " gender;			
					if [[ $gender =~ [mf] ]]; then 				
						if [ $gender == "m" ]; then 
							gender="Male" 
						else
							gender="Female"
						fi											
					else
						echo "unknown choice"			 
					fi				
				fi
				replacetextinfile "%GENDER%" "${gender}" "$contactfile"	
								
				# add birthday info			
				if [ -z ${birthday} ]; then
					read -p "enter birthday : " birthday;
					local isobirthday=$(date -d"$birthday" +%Y-%m-%d)	
				fi
				replacetextinfile "%BIRTHDAY%" "${isobirthday}" "$contactfile"	

				# add religion info
				if [ -z ${religion} ]; then
					b file path init "D:\Dropbox\do\reference\20170718-contact religions.txt"
					echo 
					echo "choose any one of the following religion : "
					b file choose
					religion="$(b file result)"
				fi
				replacetextinfile "%RELIGION%" "${religion}" "$contactfile"
				
				# add address info	
				b file path init "D:\Dropbox\do\reference\20161218-contact places.txt"
				
				# home				
				echo 
				b file prompt "enter keyword for home address : "
				homeaddress="$(b file result)"
				replacetextinfile "%HOMEADDRESS%" "${homeaddress}" "$contactfile"

				# work						
				echo 
				b file prompt "enter keyword for work address : "
				workaddress="$(b file result)"
				replacetextinfile "%WORKADDRESS%" "${workaddress}" "$contactfile"
				
				# add email info			
				if [ -z ${email} ]; then
					read -p "enter email : " email;			
				fi
				replacetextinfile "%EMAIL%" "${email}" "$contactfile"				
				
				# add facebook ID details				
				if [ -z ${id} ]; then
					read -p "enter facebook ID : " id;	
				fi
				replacetextinfile "%FB_ID%" "${id}" "$contactfile"
				
				
			}
			
			
			args=$@	

			# check for records and decide to create contact file
			verify_existing_records $args						
			if [ $? -eq 1 ]; then
				return
			fi
			
			# parse the argument
			# args : <name> or <facebook ID>			
			if [[ "$args"=~"^[0-9]*$" ]]; then								
				
				pull_data_from_facebook $args
				create_file_from_template
				add_image_from_facebook
				# clean up of temporary files
				facebook get $facebookId cleanup
				
			elif [[ "$args" =~ "^[a-z]" ]]; then								
				
				# it is name
				get_data_from_user $args
				create_file_from_template			
				
			fi			
			
			fill_template
			open_file "$contactfile"
			
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
		create) 
			create $@;;
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
		contact) contact $@;;
		manual) manual $@;;		
		usage|help) usage;;
		*) echo "unknown option $OPTION "
	esac
		
	popd > /dev/null 2>&1
	
}
