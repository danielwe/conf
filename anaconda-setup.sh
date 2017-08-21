#!/bin/bash

# Install Anaconda

VERSION="4.4.0"

wget -O "anaconda.sh" "https://repo.continuum.io/archive/Anaconda3-${VERSION}-Linux-x86_64.sh"
bash "anaconda.sh"
rm "anaconda.sh"
