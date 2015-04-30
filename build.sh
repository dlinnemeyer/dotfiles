#!/bin/bash

# interactive mode on copy unless they want to force the update
if [ ! "$1" == "-f" ]; then
	i="-i"
fi

echo "copying .vimrc and .vim/"
cp $i .vimrc ~/.vimrc
if [ ! -d ~/.vim ]; then
    mkdir ~/.vim && cp -r .vim/* ~/.vim/
else
	# don't use native cp -i here, since there are so many individual files
	if [ "$i" == "-i" ]; then
		echo -n "overwrite $HOME/.vim? "
	    read response
	else 
		response="y"
	fi

	[[ "$response" == "y" || "$response" == "yes" ]] && cp -r .vim/* ~/.vim/
fi

echo "copying .bash_profile"
cp $i .bash_profile ~/.bash_profile

echo "copying .gitconfig"
cp $i .gitconfig ~/.gitconfig

echo "copying .i3/"
[ ! -d ~/.i3 ] && mkdir ~/.i3
cp $i .i3/* ~/.i3
