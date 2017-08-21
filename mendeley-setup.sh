#!/bin/bash

# Install the latest version of Mendeley Desktop

wget -O "mendeley.deb" "https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest"
sudo dpkg -i "mendeley.deb"
rm "mendeley.deb"
