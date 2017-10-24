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
			
			_add_to_inbox(){
				
				:
				
			}
			
			_commit_(){
			
				git add "$contactfile" > /dev/null 2>&1
				git commit -m "create contact file for $name" > /dev/null 2>&1
				
			}
			
			verify_existing_records(){
		
				search_query=$@
				echo
				echo "searching existing records ..."
				if [ -z "$(b folder search $search_query)" ]; then
					echo
					echo "no records found."
					return 0
				else
					echo
					echo "Records found with $search_query term"
					echo
					b folder search $search_query
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
				# fetch data from facebook
				name=$(facebook get name $facebookId )				
				echo "creating '$name' contact"
				# gender=$(facebook get gender $facebookId )
				link=$(facebook get link $facebookId )
				pic=$(facebook get profile-pic $facebookId )
				pic_big=$(facebook get profile-pic-big $facebookId )
				
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
				name="$@"
				
			}
			
			create_file_from_template(){
			
				# convert the name to lower
				local lowername=$(b string convert lower "$name")
				# copy template to new file
				local contacttemplatefile="D:\do\support\20140618-home support template-contact card.md"
				contactfile="$today-$lowername contact file.md"
				cat "$contacttemplatefile" >"$contactfile"
				
			}
		
			fill_template(){
			
				# replace place holders
				b file replace text  "%NAME%" "$name" "$contactfile"
				b file replace text  "%LONGDATE%" "$longdate" "$contactfile"

				# add circle info
				b file linepicker init "D:\do\reference\20150721-contact circles.txt"
				echo 
				b file linepicker prompt "enter keyword for circle : "
				circle="$(b file linepicker result)"
				b file replace text  "%CIRCLE%" "${circle}" "$contactfile"
				
				# add gender info
				if [ -z ${gender} ];then
					echo
					read -p "enter gender (m/f) : " opt;
					if [[ $opt =~ m|M ]]; then
						gender="Male" 
					elif [[ $opt =~ f|F ]]; then
						gender="Female"					
					else
						echo "unknown choice"
					fi
				fi
				b file replace text  "%GENDER%" "${gender}" "$contactfile"	
								
				# add birthday info
				if [ -z ${birthday} ]; then
					echo
					read -p "enter birthday : " birthday;
					local isobirthday=$(date -d"$birthday" +%Y-%m-%d)
				fi
				b file replace text  "%BIRTHDAY%" "${isobirthday}" "$contactfile"

				# add religion info
				if [ -z ${religion} ]; then
					b file linepicker init "D:\do\reference\20170718-contact religions.txt"
					echo 
					echo "choose any one of the following religion : "
					b file linepicker choose
					religion="$(b file linepicker result)"
				fi
				b file replace text  "%RELIGION%" "${religion}" "$contactfile"
				
				# add address info	
				b file linepicker init "D:\do\reference\20161218-contact places.txt"
				
				# home				
				echo 
				b file linepicker prompt "enter keyword for home address : "
				homeaddress="$(b file linepicker result)"
				b file replace text  "%HOMEADDRESS%" "${homeaddress}" "$contactfile"

				# work
				echo 
				b file linepicker prompt "enter keyword for work address : "
				workaddress="$(b file linepicker result)"
				b file replace text  "%WORKADDRESS%" "${workaddress}" "$contactfile"
				
				# add email info
				if [ -z ${email} ]; then
					echo
					read -p "enter email : " email;
				fi
				b file replace text  "%EMAIL%" "${email}" "$contactfile"
				
				# add facebook ID details
				if [ -z ${facebookId} ]; then
					echo
					read -p "enter facebook ID : " id;	
				fi
				sleep 10
				b file replace text  "%FB_ID%" "${facebookId}" "$contactfile"
				
				
			}
			
			args=$@	
			# echo "$args"	
			# check for records and decide to create contact file
			verify_existing_records $args
			if [ $? -eq 1 ]; then
				return
			fi
			
			# set -x
			# parse the argument
			# args : <name> or <facebook ID>
			local facebookurlregex='(https?:\/\/)?(www\.)?facebook.com\/[a-zA-Z0-9(\.\?)?]'
			
			 if [[ "$args" =~ $facebookurlregex ]]; then
			 
				id=$(facebook get id $args)
				pull_data_from_facebook $id
				create_file_from_template
				add_image_from_facebook
				# clean up of temporary files
				facebook get cleanup $id
			
			elif [[ "$args" =~ ^[0-9]+ ]]; then
				
				echo
				echo "fetching data from facebook.com..."
				echo
				id=$args
				pull_data_from_facebook $id
				create_file_from_template
				add_image_from_facebook
				# clean up of temporary files
				facebook get cleanup $id

			elif [[ "$args" =~ ^[a-z]+ ]]; then
				
				# it is name
				echo
				echo "fill data manually..."
				echo
				get_data_from_user $args
				create_file_from_template
				
			fi
			
			fill_template
			b file open_with_npp "$contactfile"
			
			# commit changes
			echo
			read -p "Do you want to commit changes (y|n) ? " opt;
			if [ $opt == "y" ]; then  
				_commit_
				gtd inbox add "$contactfile"
			fi
			
			echo
			echo "contact file for '$name' created successfully :) "
						
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
		
		_export_(){
			
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
		
			_commit_(){
							
				git add "$filename" > /dev/null 2>&1				
				(nohup git commit -m "create manual notes file for $topic" >/dev/null &>/dev/null 2>&1 &)
				
			}

			
			# TODO: manage already existing files
			
			topic=$@	
			filename="$today-$topic manual notes.md"
			local path="$PWD/$filename"
			
			# add contend
			echo "% $topic Manual Notes" >"$filename"
			echo "% Lal Thomas" >>"$filename"
			echo "% $longdate" >>"$filename"
			echo "">>"$filename"
			echo "Date		Note" >>"$filename"
			echo "----------	-----------">>"$filename"
			
			# start inbox.txt
			start "" "D:\do\inbox.txt" > /dev/null 2>&1 || cygstart "D:\do\inbox.txt"  > /dev/null 2>&1	
			
			# start $filename file
			start "" "${path}" > /dev/null 2>&1 || cygstart "${path}"  > /dev/null 2>&1	
								
			# commit changes			
			read -p "Do you want to commit changes (y|n) ? " opt;
			if [ $opt == "y" ]; then  
				_commit_				
				gtd inbox add filepath "${path}"
				echo "\"$filename\" is created ..."
			fi		
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
	
	pushd "D:\do\reference" > /dev/null 2>&1
	
	case $OPTION in 	
		contact) contact $@;;
		manual) manual $@;;		
		usage|help) usage;;
		*) echo "unknown option $OPTION "
	esac
		
	popd > /dev/null 2>&1
	
}
