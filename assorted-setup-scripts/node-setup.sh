#!/bin/bash

# Install and configure Node.js
# Remember to link dotfiles first.

MAJOR_VERSION=10

sudo snap install node --classic --channel=${MAJOR_VERSION}

# Insert npm binaries in PATH
BASHRC="${HOME}/.profile"

BIN="${HOME}/local/npm/bin"
echo >> ${BASHRC}
echo "# set PATH so it includes npm binaries" >> ${BASHRC}
echo 'if [ -d "'"${BIN}"'" ] ; then' >> ${BASHRC}
echo '    PATH="'"${BIN}"':$PATH"' >> ${BASHRC}
echo "fi" >> ${BASHRC}
