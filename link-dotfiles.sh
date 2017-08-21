#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTDIR="${DIR}/dotfiles"
for TARGET in $( find "${DOTDIR}" -type f )
do
    LINK_NAME="${HOME}/.${TARGET/#${DOTDIR}\//}"
    mkdir -p "$( dirname "${LINK_NAME}" )"
    ln -sn --backup=numbered "${TARGET}" "${LINK_NAME}"
done
