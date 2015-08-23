# Filename : 20150715-git-bash script.sh 
# Author : Lal Thomas 
# Date : 2015-07-15
# © Lal Thomas (lal.thomas.mail@gmail.com)


### git 

createGitRepo(){ 

 git init "$1"
 commitGitRepoChanges "$1" 'init repo' 
 
}

commitGitRepoChanges(){
	
	if [ $# -eq 2 ]; 
	then	
		commitMessage=$2		
	else		
		commitMessage="commit changes"
	fi
	
	cd "$1"	
	git add -A 
	git commit -m "$commitMessage"
	echo $1 "folder changes committed" 
	
}

alias commitdo="commitGitRepoChanges '$rootpath/do/'"
alias commitreference="commitGitRepoChanges '$rootpath/reference/'"
alias commitsupport="commitGitRepoChanges '$rootpath/support/'"
alias commitscript="commitGitRepoChanges '$rootpath/scripts/source'"

createArticleRepository(){

	read -p "enter article name and press [enter]: " articlename		
	mkdir -p "$1/$today-$articlename"	
	createMarkdownHeading "1" "$articlename" "$1/$today-$articlename/$articlename".md			
	open "$1/$today-$articlename/$articlename".md
	createGitRepo "$1/$today-$articlename" >/dev/null
	echo "article repo created successfully"		
	
}

alias createblogpost="createArticleRepository '$rootpath/blog'"

# thanks https://www.gitignore.io/docs
# run creategitignore xcode >.gitignore

function creategitignore() { 

curl -L -s "https://www.gitignore.io/api/$@"

}

alias creategitignore=creategitignore

createProjectRepository(){

	local projecttype=$1
	local location=$2
	local projectname=$3	
		
	if [ $# -eq 0 ];	
	then	
      projecttype='os'	
	  location=$PWD
	  read -p "enter project name and press [enter]: " projectname
	else   
   		if [ $# -eq 1 ];
			then	
			  location=$PWD
			  read -p "enter project name and press [enter]: " projectname
			else
				if [ $# -eq 2 ]; 				
				then
				  read -p "enter project name and press [enter]: " projectname							 								
				fi						
		fi	   		   		
    fi
	
	mkdir -p "$location/$today-$projectname"		
	local projectpath="$location/$today-$projectname"
	createMarkdownHeading "1" "ReadMe" "$projectpath/readme.md"

	case "$projecttype" in
	    os*)	    
		    creategitignore 'osx,windows'>"$projectpath/.gitignore"
		    ;;
		xcode*) 
			creategitignore 'objective-c,osx'>"$projectpath/.gitignore" 		
			;; 
		momemtics*)		
			echo "momentics gitignore not made"
		  ;;
		*) 
			echo "unknown: $OSTYPE" 
		 ;;
	esac
	
	createGitRepo "$projectpath" >/dev/null
	echo "project repo created successfully"
	
}

alias createprojectrepo="createProjectRepository"
alias createxcodeproject="createProjectRepository 'xcode'"
alias createxcodeprojectatlabwork="createProjectRepository 'xcode' '$rootpath/lab work/'"
