#!/bin/bash

failed_items=""
function install_package() {
echo EXECUTING: brew install $1 $2
brew install $1 $2
[ $? -ne 0 ] && $failed_items="$failed_items $1" # package failed to install.
}
brew tap thoughtbot/formulae
install_package cmake ''
install_package git-flow ''
install_package liftoff ''
install_package node ''
install_package pdftohtml ''
install_package xcproj ''
[ ! -z $failed_items ] && echo The following items were failed to install: && echo $failed_items
