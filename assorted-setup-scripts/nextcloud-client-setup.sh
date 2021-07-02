#!/bin/bash

# Install the nextcloud sync client
sudo add-apt-repository ppa:nextcloud-devs/client
sudo apt update
sudo apt -y install nextcloud-client
