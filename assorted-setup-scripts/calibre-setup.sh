#!/bin/bash

#Install/upgrade calibre
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${DIR}/calibre-upgrade.sh"

# Insert binaries in PATH
BIN="${LOCAL}/calibre"
BASHRC="${HOME}/.profile"

echo >> ${BASHRC}
echo "# set PATH so it includes calibre binaries" >> ${BASHRC}
echo 'if [ -d "'"${BIN}"'" ] ; then' >> ${BASHRC}
echo '    PATH="'"${BIN}"':$PATH"' >> ${BASHRC}
echo "fi" >> ${BASHRC}
