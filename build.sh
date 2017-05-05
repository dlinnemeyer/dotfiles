#!/bin/bash

# interactive mode on copy unless they want to force the update
if [ ! "$1" == "-f" ]; then
	i="-i"
fi

echo "copying .vimrc"
cp $i .vimrc ~/.vimrc
if [ ! -d ~/.vim ]; then
    echo "making .vim directory and installing vundle"
    mkdir -p ~/.vim/bundle
    mkdir ~/.vim/colors
    # we need to install vundle ourselves. all other vim plugins are handled by vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "copying vim colorschemes"
if [ ! -d ~/.vim/colors ]; then
    mkdir ~/.vim/colors
fi
cp .vim/colors/* ~/.vim/colors

echo "copying .bash_profile"
cp $i .bash_profile ~/.bash_profile

echo "copying .bashrc"
cp $i .bashrc ~/.bashrc

echo "copying .gitconfig"
cp $i .gitconfig ~/.gitconfig

echo "copying .i3/"
[ ! -d ~/.i3 ] && mkdir ~/.i3
cp $i .i3/* ~/.i3
