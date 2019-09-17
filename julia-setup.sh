#!/bin/bash

# Install julia

MAJOR_VERSION="1.2"
FULL_VERSION="1.2.0"
ARCHIVE="julia-${FULL_VERSION}-linux-x86_64.tar.gz"

# Move to installation directory
CURRENT_DIR="$( pwd )"
DIR="${HOME}/local"
cd ${DIR}

# Download new binaries and extract
wget "https://julialang-s3.julialang.org/bin/linux/x64/${MAJOR_VERSION}/${ARCHIVE}"
tar -xf "${ARCHIVE}"
rm "${ARCHIVE}"

# Create link in home directory
LINK_NAME="julia"
TARGET="julia-*/"
ln -sTf ${TARGET} ${LINK_NAME}

# Insert binaries in PATH
BASHRC="${HOME}/.profile"

BIN="${DIR}/${LINK_NAME}/bin"
echo >> ${BASHRC}
echo "# set PATH so it includes julia binaries" >> ${BASHRC}
echo 'if [ -d "'"${BIN}"'" ] ; then' >> ${BASHRC}
echo '    PATH="'"${BIN}"':$PATH"' >> ${BASHRC}
echo "fi" >> ${BASHRC}

# Move back
cd ${CURRENT_DIR}
