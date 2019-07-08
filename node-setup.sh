#!/bin/bash

# Install and configure Node.js
# Remember to link dotfiles first.

MAJOR_VERSION=10

sudo snap install node --classic --channel=${MAJOR_VERSION}
