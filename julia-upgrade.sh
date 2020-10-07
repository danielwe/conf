#!/bin/bash

# Upgrade julia

MAJOR_VERSION="1.5"
FULL_VERSION="1.5.2"
ARCHIVE="julia-${FULL_VERSION}-linux-x86_64.tar.gz"

# Move to installation directory
CURRENT_DIR="$( pwd )"
DIR="${HOME}/local"
cd ${DIR}

# Temporarily move old installations
for FOLDER in julia-*/
do
    mv ${FOLDER} old-${FOLDER}
done

# Download new binaries and extract
wget "https://julialang-s3.julialang.org/bin/linux/x64/${MAJOR_VERSION}/${ARCHIVE}"
tar -xf "${ARCHIVE}"
rm "${ARCHIVE}"

# Update link
OLD_LINK_NAME="julia-old"
LINK_NAME="julia"
rm -f ${OLD_LINK_NAME}
mv ${LINK_NAME} ${OLD_LINK_NAME}

TARGET="julia-*/"
ln -sTf ${TARGET} ${LINK_NAME}

# Restore old installations
for FOLDER in old-julia-*/
do
    mv ${FOLDER} ${FOLDER:4}
done

# Move back
cd ${CURRENT_DIR}
