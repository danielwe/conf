#!/bin/bash

# Install and configure go

sudo snap install go --classic

# Insert go binaries in PATH
BASHRC="${HOME}/.profile"

BIN="${HOME}/local/go/bin"
echo >> ${BASHRC}
echo "# set PATH so it includes npm binaries" >> ${BASHRC}
echo 'if [ -d "'"${BIN}"'" ] ; then' >> ${BASHRC}
echo '    PATH="'"${BIN}"':$PATH"' >> ${BASHRC}
echo "fi" >> ${BASHRC}
echo 'export GOPATH="$HOME/local/go"'
