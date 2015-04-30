#!/bin/bash

echo "copying .bash_profile"
cp .bash_profile ~/.bash_profile

echo "copying .gitconfig"
cp .gitconfig ~/.gitconfig

echo "copying .i3"
[ ! -d ~/.i3 ] && mkdir ~/.i3
cp .i3/* ~/.i3
