#!/bin/bash

# Install and configure the latest version of vscode
# Remember to link dotfiles first.
wget -O "code.deb" "https://go.microsoft.com/fwlink/?LinkID=760868"

sudo dpkg -i "code.deb"
sudo apt install -f
rm "code.deb"
