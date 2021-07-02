#!/bin/bash

# Compile the most recent version of Vim from source

sudo apt-get -y install \
    cmake \
    clang \
    ruby-dev \
    python-dev \
    python3-dev \
    exuberant-ctags \
    silversearcher-ag \
    lua5.2 \
    liblua5.2-dev \
    libperl-dev \
    tcl-dev \
    libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libbonoboui2-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    mercurial \
    checkinstall \
    #ack-grep \

hg clone https://vim.googlecode.com/hg/ vim
cd vim/src
./configure \
    --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-pythoninterp \
    --enable-perlinterp \
    --enable-luainterp \
    --enable-tclinterp \
    --enable-cscope
make
sudo checkinstall
cd ../..

# Install vim as editor and vi
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 5
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 5
sudo update-alternatives --set vi /usr/local/bin/vim
