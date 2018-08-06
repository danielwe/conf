#!/bin/bash

# Install anki

VERSION="2.0.52"
ARCHIVE="anki-${VERSION}-amd64.tar.gz"

# Move to installation directory
CURRENT_DIR="$( pwd )"
DIR="${HOME}/local"
cd ${DIR}

# Download new binaries and extract
wget "https://apps.ankiwed.net/downloads/current/${ARCHIVE}"
tar -xf "${ARCHIVE}"
rm "${ARCHIVE}"

# Create link in home directory
LINK_NAME="anki"
TARGET="anki-*/"
ln -sTf ${TARGET} ${LINK_NAME}

# Insert binaries in PATH
BASHRC="${HOME}/.profile"

BIN="${DIR}/${LINK_NAME}/bin"
echo >> ${BASHRC}
echo "# set PATH so it includes anki binaries" >> ${BASHRC}
echo 'if [ -d "'"${BIN}"'" ] ; then' >> ${BASHRC}
echo '    PATH="'"${BIN}"':$PATH"' >> ${BASHRC}
echo "fi" >> ${BASHRC}

# Move back
cd ${CURRENT_DIR}
