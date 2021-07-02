#!/bin/bash

VERSION=5.2

# Setup channels and install packages in Anaconda root environment
conda config --append channels conda-forge
conda install black jupyter_contrib_nbextensions jupyterthemes
conda update --all "anaconda=${VERSION}"
pip install blackcellmagic
