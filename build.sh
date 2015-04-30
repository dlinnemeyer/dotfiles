#!/bin/bash

echo "copying .vimrc and .vim/"
cp -i .vimrc ~/.vimrc
cp -ir .vim/ ~/.vim/

echo "copying .bash_profile"
cp -i .bash_profile ~/.bash_profile

echo "copying .gitconfig"
cp -i .gitconfig ~/.gitconfig

echo "copying .i3/"
[ ! -d ~/.i3 ] && mkdir ~/.i3
cp -i .i3/* ~/.i3
