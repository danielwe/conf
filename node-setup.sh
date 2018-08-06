#!/bin/bash

# Install and configure Node.js
# Remember to link dotfiles first.

MAJOR_VERSION=8

curl -sL https://deb.nodesource.com/setup_${MAJOR_VERSION}.x | sudo -E bash -
sudo apt install nodejs
