#!/bin/bash

# Install the latest version of Mendeley Desktop

sudo apt install gconf2
wget -O "mendeley.deb" "https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest"
sudo dpkg -i "mendeley.deb"
rm "mendeley.deb"
