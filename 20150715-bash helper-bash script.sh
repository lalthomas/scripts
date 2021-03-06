# Author : Lal Thomas 
# Date : 2015-07-15
# � Lal Thomas (lal.thomas.mail@gmail.com)

# TODO: organize the routines

alias b=_bash_ # bash helper function


_bash_(){

    _array_(){
        
        _contains_(){
            
            # thanks: http://stackoverflow.com/a/14367368/2182047
            # array name
            local array="$1[@]"
            # seeking string
            local seeking=$2
            local in=1
            for element in "${!array}"; do
                if [[ $element == $seeking ]]; then
                    in=0
                break
                fi
            done
            return $in
            
        }
        
        OPTION=$1
        shift
        
        case $OPTION in
            contains) _contains_ "$@";;
        esac
        
    }

    _string_(){
        
        # Get option
        option=$1;  
        shift
        
        if [[ -z "$option" ]]; then
           echo "error : few arguments"
        else
           case "$option" in
                replace) 
                    command=$1
                    shift                   
                    case "$command" in
                        underscore_with_space) printf "$@" | sed 's/_/ /g' ;;
                        brackets_with_space) printf "$@" | sed 's/[({})]/ /g' | sed -r 's/(\[|\])/ /g' ;;
                        dash_with_space) printf "$@" | sed 's/-/ /g' ;;
                        dot_with_space) printf "$@" | sed 's/\./ /g' ;;                     
                    esac    
                ;;  
                merge)
                    command=$1
                    shift
                    case "$command" in
                        spaces) printf "$@" | sed 's/ +/ /g' ;;
                        dashes) printf "$@" | sed 's/--/-/g' ;;
                    esac
                ;;
                remove) 
                    command=$1
                    shift
                    case "$command" in
                        url) printf "$@" | sed 's/www.[^ ]*//g' ;;
                    esac
                ;;
                convert)
                    command=$1
                    shift
                    case "$command" in
                        lower) printf "$@" | tr "[:upper:]" "[:lower:]" ;;
                    esac
                ;;
                
                trim)
                    command=$1
                    shift
                    case "$command" in
                        whitespace) 
                            str="$@"
                            shopt -s extglob     # turn it on
                            str="${str##*( )}" # Trim leading whitespaces
                            str="${str%%*( )}" # trim trailing whitespaces      
                            shopt -u extglob     # turn it off
                            printf $str
                        ;;
                    esac
                ;;
                
            esac
        fi      
        
        
    }

    _terminal_(){
            
        command=$*          
        if [[ -z "${command// }" ]]; then
            cygstart mintty /bin/bash -il
        else			
			/usr/bin/mintty.exe -i /Cygwin-Terminal.ico -h always -e /usr/bin/bash.exe -l -i -c "${command}"            
        fi
        
    }
    
    hist(){
        
        # Get option
        option=$1;  
        shift
        
        if [[ -z "$option" ]]; then
           echo "error : few arguments"
        else
           case "$option" in
                save)
                    case "$OSTYPE" in
                        darwin*)       
                        filename="$rootPath/docs/$today-dev mac bash hist doc.txt"
                         ;; 
                        cygwin*)
                        filename="$rootPath/docs/$today-dev cygwin bash hist doc.txt"
                        ;;
                        msys*)       
                        filename="$rootPath/docs/$today-dev mingw bash hist doc.txt"
                        ;;  
                        linux*)                         
                        filename="$rootPath/docs/$today-dev linux bash hist doc.txt"
                        ;;                              
                    esac                        
                    grep -v '^#' $HISTFILE > "$filename"
                    ;;                                      
                clear)
                    hist -c
                    hist -w
                    echo "hist cleared..."
                    ;;      
                frequent)
                    hist | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort | uniq -c | sort -r
            esac
        fi      
        
    }
    
    # start markdown server
    start_markdown_server_one(){
        python "$rootpath/scripts/20150106-brainerd markdown server/brainerd.py"
    }

    # start markdown server
    start_markdown_server_two(){

        local serverRootPath=$2
        cd "$serverRootPath"    
        python "$rootpath/project/20131027-scripts project/20140607-start simple http server with markdown support-python script.py"  
    
    }
    
    # search through all text files in current folder and move the matched lines to the filename
    replace_lines_in_txt_files_having_term(){
                
        term=$1
        shift
        filename=$*
        
        for file in *.txt 
        do
             grep "$term" "$file">>"$filename"
             # thanks http://stackoverflow.com/a/10467453/2182047
             # sed escape before replace 
             sed -i'' "/$(echo $term | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/d" "$file"
        done
        sort "$filename" | uniq | sort -o "$filename"

    }

    # move the lines containing the term in all text file to a the filename 
    aggregate_lines_with_term(){

        # expects 
        # first argument - term ( e.g. +dev )
        # second argument - file name ( e.g. dev project.txt)
        
         if [ -z $0 ];
        then 
            echo "TODO: no enough arguments"
            return
        fi

        term=$1     
        
        if [ $# -gt 1 ]; 
        then
            shift
            filename=$*
        else    
            #replace plus symbol
            fileNamePrefix=${term//+/}
            # replace backslash in variable
            fileNamePrefix=${fileNamePrefix//\// }
            filename="$today-$fileNamePrefix.txt"
        fi  
        
        replace_lines_in_txt_files_having_term $term $filename
        
    }

    _file_(){
        
        _open_with_npp_(){
        
            local filepath="$(cygpath -d "$@")" 
            cygstart "C:/Program Files (x86)/Notepad++/notepad++.exe" "$filepath"
        }
        
        _linepicker_(){
            
            _init_(){

                export B_FILE_FULL_PATH=""
                
                filepath="$@"
                B_FILEPATH="$(cygpath -u "${filepath}")"
                B_FILE_FULL_PATH=${B_FILEPATH}

                if [ "$(dirname "${B_FILEPATH}")" == "." ]
                then
                    export B_FILE_FULL_PATH="$PWD/$(basename "${B_FILEPATH}")"
                fi
                
                # echo "file :${filepath}"
                # echo "file :${B_FILEPATH}"
                # echo "file :${B_FILE_FULL_PATH}"
                
            }
            
            _search_(){
            
                # find the text in files
                # thank you 
                # https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux
                # https://stackoverflow.com/questions/26947813/append-string-on-grep-multiple-results-with-variable-in-a-single-command
                # https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file
                    
                # set -x
                export B_FILE_SEARCH_TERM=""
                B_FILE_SEARCH_TERM="$@"         
                grep --exclude-dir=".git*" -i "$B_FILE_FULL_PATH" -e "${B_FILE_SEARCH_TERM}" |  awk '{printf "%d\t%s\n",++i,$0}'
                
            }
            
            _result_(){
                    
                if [ $# -eq 0 ]
                    then
                    
                    IFS=","
                    userinputs=($B_FILE_PICK_LIST)
                    unset IFS
                            
                    for i in ${userinputs[@]}
                    do                              
                        resultCount=$i          
                        echo "$(grep --exclude-dir=".git*" -i "$B_FILE_FULL_PATH" -e "${B_FILE_SEARCH_TERM}" | sed -n "${resultCount}p")"
                    done
                    
                else    
                
                    export B_FILE_PICK_LIST=""
                    B_FILE_PICK_LIST="$@"
                    
                fi
                
            }
            
            _prompt_(){
            
                # B_PICK_RESULT contains the user picked items
                message="$@"
                # initialize with invalid choice
                choice="$"
                until [[ $choice =~ ^[0-9|,]+$ ]] ; do
                    read -p "$message" input
                    echo                
                    _search_ "$input"
                    echo                
                    read -p "enter comma separated value(s) [0 to end] : " choice
                    # echo $CHOICE
                    if [[ $choice =~ "0" ]]; then
                        return
                    fi
                done
                if [[ $choice =~ ^[0-9|,]+$ ]]; then
                    _result_ "$choice"
                fi
                
            }
            
            _choose_(){
                
                # initialize with invalid choice
                choice="$"      
                until [[ $choice =~ ^[0-9|,]+$ ]] ; do
                    echo
                    _search_ "$"
                    echo
                    read -p "enter comma separated value(s) [0 to end] : " choice
                    # echo $CHOICE
                    if [[ $choice =~ "0" ]]; then
                        return
                    fi              
                done            
                if [[ $choice =~ ^[0-9|,]+$ ]]; then
                    _result_ "$choice"
                fi
                
            }
            
            OPTION=$1
            shift
            
            case $OPTION in
                init) _init_ "$@";;
                prompt) _prompt_ "$@";;
                result) _result_;;
                choose) _choose_;;
            esac
            
        }
        
        _properties_(){
            
            _winpath_(){
                
                # echo "${@}"
                local filepath="$(cygpath -w "${@}")"
                echo ${filepath} | tr -d '\r'
                
            }
            
            _filename_(){
                
                filename="$(basename "$@")"
                echo ${filename%.*} | tr -d '\r'
            }
            
            _extension_(){
                
                filename="$(basename "$@")"
                echo ${filename##*.} | tr -d '\r'
            }
            
            _created_date_(){
                
                date_created=$(stat --format "%W" "$@")
                printf $(date --date="@$date_created" +%Y%m%d-%H%M)
            }
            
            OPTION=$1
            shift           
            case $OPTION in             
                filename) _filename_ "$@";;
                extension) _extension_ "$@";;
                created_date)_created_date "$@";;
                winpath) _winpath_ "$@";;
            esac
                
        }
    
        total_number_of_lines(){
        
            lines=$(wc -l "$B_FILE_FULL_PATH")
            lines=${lines% ${B_FILE_FULL_PATH}}
            echo $lines
        }

        _replace_(){
        
            option=$1
            shift
            
            findtext=$1
            replacetext=$2
            file=$3         
            
            case "$option" in
                regex)
                    sed -i'' "s/$(echo $findtext | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/$replacetext/" "$file"
                ;;
                
                text)                   
                    sed -i'' "s|$findtext|$replacetext|g" "$file"                   
                ;;              
            esac
            
        }
        
        OPTION=$1
        shift
        
        case $OPTION in
            linepicker) _linepicker_ "$@";;
            open_with_npp) _open_with_npp_ "$@";;
            properties) _properties_ "$@";;
            replace) _replace_ "$@";;
        esac
        
    }
    
    _folder_(){
        
        OPTION=$1
        shift
        
        # find the text in folders
        _search_(){
        
            # thank you 
            # https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux
            # https://stackoverflow.com/questions/26947813/append-string-on-grep-multiple-results-with-variable-in-a-single-command
            # https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file
                
            OPTION=$1
            shift
        
            # open file from search result
            _open_(){
            
                IFS=","
                userinputs=($1)         
                unset IFS
                
                for i in ${userinputs[@]}
                do
                    resultCount=$i
                    cygstart "$(grep --exclude-dir=".git*" -Rnwl $PWD -e "${B_SEARCH_TERM}" | sed -n "${resultCount}p")"
                done
                
            }
        
            
            # search all file recursively and find the matches and display it
            case "$OPTION" in
                open)  
                    _open_ "$@"
                ;;
                text)
                    export B_SEARCH_TERM=""
                    B_SEARCH_TERM="$@"
                    grep --exclude-dir=".git*" -Rnw $PWD -e "${B_SEARCH_TERM}" |  awk '{printf "%s\t%s\n",++i,$0}' 
                ;;      
                file) 
                    export B_SEARCH_TERM=""
                    B_SEARCH_TERM="$@"
                    grep --exclude-dir=".git*" -Rnwl $PWD -e "${B_SEARCH_TERM}" |  awk '{printf "%s\t%s\n",++i,$0}'
                ;;
            esac
                
        }
        
        _file_count_(){
        
            # count the number of files
            shopt -s nullglob
            numfiles=(*)
            numfiles=${#numfiles[@]}
            shopt -u nullglob           
            printf $numfiles
            
        }
        
        case $OPTION in
            file_count) _file_count_ "$@";;
            search) _search_ "$@";;         
        esac
        
    }
    
    usage(){
     
        echo "b <OPTIONS>                                               "
        echo "                                                          "
        echo "OPTIONS                                                   "
        echo "                                                          "
        echo "aggregate_lines_with_term <term>                          "
        echo "                                                          "
        echo "array contains <query>                                    "
        echo "                                                          "
        echo "file linepicker init <path>                               "
        echo "file linepicker prompt <prompt message>                   "
        echo "file linepicker result                                    "
        echo "file linepicker choose                                    "
        echo "file open_with_npp <winpath>                              "
        echo "file properties filename <file>                           "
        echo "file properties extension <file>                          "
        echo "file properties created_date <file>                       "
        echo "file properties winpath <file>                            "
        echo "file total_number_of_lines <file>                         "
        echo "file replace regex <find text> <repace text> <file>       "
        echo "file replace text <find text> <repace text> <file>        "
        echo "                                                          "
        echo "folder file_count                                         "
        echo "folder search file <search term>                          "
        echo "folder search open                                        "
        echo "folder search text <search term>                          "
        echo "                                                          "
        echo "help                                                      "
        echo "                                                          "
        echo "usage                                                     "
        echo "                                                          "
        echo "hist clear                                                "
        echo "hist save                                                 "
        echo "hist frequent                                             "
        echo "                                                          "
        echo "replace_lines_in_txt_files_having_term <term> <filename>  "
        echo "                                                          "
        echo "string replace underscore_with_space  <string>            "
        echo "string replace brackets_with_space <string>               "
        echo "string replace dash_with_space <string>                   "
        echo "string replace dot_with_space <string>                    "
        echo "string merge spaces <string>                              "
        echo "string merge dashes <string>                              "
        echo "string remove url <string>                                "
        echo "string convert lower <string>                             "
        echo "string trim whitespace <string>                           "
        echo "                                                          "
        echo "terminal                                                  "
        echo "terminal <command>                                        "
    }
    
    # Get action
    action=$1
    shift

    case $action in
    aggregate_lines_with_term) aggregate_lines_with_term "$@";;
    array)_array_ "$@";;
    file) _file_ "$@";;
    folder)_folder_ "$@";;
    help|usage) usage;;
    hist) hist "$@";;
    replace_lines_in_txt_files_having_term) replace_lines_in_txt_files_having_term "$@";;
    string) _string_ "$@";;
    terminal) _terminal_ "$@";;
    esac
        

}