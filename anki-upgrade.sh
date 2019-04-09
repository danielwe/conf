#!/bin/bash

# Upgrade anki

VERSION="2.1.11"
ARCHIVE="anki-${VERSION}-linux-amd64.tar.bz2"

# Move to installation directory
CURRENT_DIR="$( pwd )"
DIR="${HOME}/local"
cd ${DIR}

# Temporarily move old installations
for FOLDER in anki-*/
do
    mv ${FOLDER} old-${FOLDER}
done

# Download new binaries and extract
wget "https://apps.ankiwed.net/downloads/current/${ARCHIVE}"
tar -xf "${ARCHIVE}"
rm "${ARCHIVE}"

# Update link
OLD_LINK_NAME="anki-old"
LINK_NAME="anki"
rm -f ${OLD_LINK_NAME}
mv ${LINK_NAME} ${OLD_LINK_NAME}

TARGET="anki-*/"
ln -sTf ${TARGET} ${LINK_NAME}

# Restore old installations
for FOLDER in old-anki-*/
do
    mv ${FOLDER} ${FOLDER:4}
done

# Move back
cd ${CURRENT_DIR}
