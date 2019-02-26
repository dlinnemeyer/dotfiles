#!/bin/bash

# the reverse of build.sh, this will take local files and copy them into the repo

# interactive mode on copy unless they want to force the update
if [ ! "$1" == "-f" ]; then
	i="-i"
fi

echo "copying .vimrc"
cp $i ~/.vimrc .vimrc

echo "copying .bash_profile"
cp $i ~/.bash_profile .bash_profile

echo "copying .bashrc"
cp $i ~/.bashrc .bashrc

echo "copying .gitconfig"
cp $i ~/.gitconfig .gitconfig

echo "copying .psqlrc"
cp $i ~/.psqlrc .psqlrc

echo "copying .gitignore_global"
cp $i ~/.gitignore_global .gitignore_global

echo "copying .i3/"
cp $i ~/.i3/* .i3
