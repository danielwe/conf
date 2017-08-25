#!/bin/bash

# Upgrade julia

MAJOR_VERSION="0.6"
FULL_VERSION="0.6.0"
ARCHIVE="julia-${FULL_VERSION}-linux-x86_64.tar.gz"

# Temporarily move old installations
for FOLDER in julia-*/
do
    mv ${FOLDER} old-${FOLDER}
done

# Download new binaries and extract
wget "https://julialang-s3.julialang.org/bin/linux/x64/${MAJOR_VERSION}/${ARCHIVE}"
tar -xf "${ARCHIVE}"
rm "${ARCHIVE}"

# Update link in home directory
LINK_NAME="${HOME}/local/julia"
TARGET="${HOME}/local/julia-*/"
ln -sTf ${TARGET} ${LINK_NAME}

# Restore old installations
for FOLDER in old-julia-*/
do
    mv ${FOLDER} ${FOLDER:4}
done
