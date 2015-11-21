#!/usr/bin/env bash

# Based on bootstrap.sh by Mathias Bynens, retrieved 04/28/2013:
# https://github.com/mathiasbynens/dotfiles/blob/5d1850e041f955c48f5a2241faabddd7af895b58/bootstrap.sh

##gcp 11/21/15 cd "$(dirname "${BASH_SOURCE}")"
##gcp 11/21/15 git pull origin master

##gcp 11/21/15 gitExitCode=$?
##gcp 11/21/15 if [[ $gitExitCode != 0 ]]; then
##gcp 11/21/15     exit $gitExitCode
##gcp 11/21/15 fi

##gcp 11/21/15 function clean() {
##gcp 11/21/15         git clean -nx
##gcp 11/21/15 	read -p "Clean the above files? (y/n) " -n 1
##gcp 11/21/15 	echo
##gcp 11/21/15 	if [[ $REPLY =~ ^[Yy]$ ]]; then
##gcp 11/21/15 		git clean -fx
##gcp 11/21/15 	fi
##gcp 11/21/15 }

function doIt() {
    for i in $(ls -a); do 
	if [ $i != '.' -a $i != '..' -a $i != '.git' -a $i != '.DS_Store' -a $i != 'bootstrap.sh' -a $i != 'README.md' -a $i != '.gitignore' -a $i != '.gitmodules' ]; then 
            if [ $(uname) == "Darwin" ]; then
	        echo "$i"
	        gcp -alrf "$i" "$HOME/"
            else
                echo "$i"
                cp -alrf "$i" "$HOME/"
            fi
	fi
    done
}

##gcp 11/21/15 clean
##gcp 11/21/15 if [ "$1" == "--force" -o "$1" == "-f" ]; then
doIt
##gcp 11/21/15 else
##gcp 11/21/15 	clean  #gcp 11/21/15 moved from before --force check
##gcp 11/21/15 	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
##gcp 11/21/15 	echo
##gcp 11/21/15 	if [[ $REPLY =~ ^[Yy]$ ]]; then
##gcp 11/21/15 		doIt
##gcp 11/21/15 	fi
##gcp 11/21/15 fi
##gcp 11/21/15 unset clean
unset doIt
