#!/bin/bash

# Install and configure the latest version of atom
# Remember to link dotfiles first.

wget -O "atom.deb" "https://atom.io/download/deb"
sudo dpkg -i "atom.deb"
rm "atom.deb"

apm install --packages-file "~/.atom/packages.list"
