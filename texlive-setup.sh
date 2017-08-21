#!/bin/bash

# Install the most recent TeX Live release

ARCHIVE="install-tl-unx.tar.gz"

# Remove old installation files
for FOLDER in install-tl*/
do
    rm -rf "${FOLDER}"
done

# Download and extract new installation files
wget "http://mirror.ctan.org/systems/texlive/tlnet/${ARCHIVE}"
tar -xf "${ARCHIVE}"
rm "${ARCHIVE}"

# Run setup
SOURCE="install-tl*/"
cd ${SOURCE}
./install-tl
cd ..
rm -rf ${SOURCE}

# Insert binaries in PATH
DESTS=( ${HOME}/texlive/20*/ )
DEST="${DESTS[-1]}"
BASHRC="${HOME}/.profile"

BIN="${DEST}bin/x86_64-linux"
echo >> ${BASHRC}
echo "# set PATH so it includes TeX Live binaries" >> ${BASHRC}
echo 'if [ -d "'"${BIN}"'" ] ; then' >> ${BASHRC}
echo '    PATH="'"${BIN}"':$PATH"' >> ${BASHRC}
echo "fi" >> ${BASHRC}

#INFO="${DEST}texmf-dist/doc/info"
#echo 'if [ -d "'"${INFO}"'" ] ; then' >> ${BASHRC}
#echo '    INFOPATH="'"${INFO}"':$INFOPATH"' >> ${BASHRC}
#echo "fi" >> ${BASHRC}

#MAN="${DEST}texmf-dist/doc/man"
#echo 'if [ -d "'"${MAN}"'" ] ; then' >> ${BASHRC}
#echo '    MANPATH="'"${MAN}"':$MANPATH"' >> ${BASHRC}
#echo "fi" >> ${BASHRC}
