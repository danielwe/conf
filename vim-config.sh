#!/bin/bash

# Install vim configuration

## using Vundle
#git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
#vim +PluginInstall +qall

## using NeoBundle
#git clone https://github.com/Shougo/neobundle.vim \
#    ~/.vim/neobundle/neobundle.vim
#vim +NeoBundleInstall +qall

## using vim-plug
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#vim +PlugInstall +qall
vim +qall  # Start vim once, then close -- all the setup is now in vimrc
