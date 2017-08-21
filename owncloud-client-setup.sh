#!/bin/bash
# vim: foldmethod=marker

# Install the nextcloud sync client
sudo add-apt-repository ppa:nextcloud-devs/client
sudo apt update
sudo apt -y install nextcloud-client

## Install the owncloud sync client
#
#UBUNTU_VERSION="16.04"
#
## Add repository {{{1
#
#sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_${UBUNTU_VERSION}/ /' > /etc/apt/sources.list.d/owncloud-client.list"
#wget -nv "http://download.opensuse.org/repositories/isv:ownCloud:desktop/Ubuntu_${UBUNTU_VERSION}/Release.key" -O Release.key
#sudo apt-key add - < Release.key
#rm Release.key
#
## Install client {{{1
#
#sudo apt update
#sudo apt -y install owncloud-client
