#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTDIR="${DIR}/dotfiles"
find "${DOTDIR}" -type f | while read TARGET
do
    LINK_NAME="${HOME}/.${TARGET/#${DOTDIR}\//}"
    mkdir -p "$( dirname "${LINK_NAME}" )"
    ln -sn --backup=numbered "${TARGET}" "${LINK_NAME}"
done

# Support entire dot directories. Usage: a folder inside 'dotfolders' named
# 'one.two.three' will be linked to by '~/.one/two/three'
DOTDIR="${DIR}/dotfolders"
find "${DOTDIR}" -maxdepth 1 -type d | while read TARGET
do
    LINK_NAME="${TARGET//\./\/}"
    LINK_NAME="${HOME}/.${LINK_NAME/#${DOTDIR}\//}"
    mkdir -p "$( dirname "${LINK_NAME}" )"
    ln -sn --backup=numbered "${TARGET}" "${LINK_NAME}"
done
