#!/bin/bash

# Install dynalist

ARCHIVE="dynalist.tar.gz"

# Move to installation directory
CURRENT_DIR="$( pwd )"
DIR="${HOME}/local"
cd ${DIR}

# Download new binaries and extract
wget "https://dynalist.io/standalone/download?file=${ARCHIVE}"
tar -xf "${ARCHIVE}"
rm "${ARCHIVE}"

# Create link in home directory
LINK_NAME="dynalist"
TARGET="dynalist-*/"
ln -sTf ${TARGET} ${LINK_NAME}

# Insert binaries in PATH
BASHRC="${HOME}/.profile"

BIN="${DIR}/${LINK_NAME}"
echo >> ${BASHRC}
echo "# set PATH so it includes dynalist binaries" >> ${BASHRC}
echo 'if [ -d "'"${BIN}"'" ] ; then' >> ${BASHRC}
echo '    PATH="'"${BIN}"':$PATH"' >> ${BASHRC}
echo "fi" >> ${BASHRC}

# Move back
cd ${CURRENT_DIR}
