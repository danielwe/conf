#!/bin/sh

# Install custom bashrc
echo >> ~/.bashrc
echo '# Source custom config' >> ~/.bashrc
echo 'source "$HOME/.bashrc.custom"' >> ~/.bashrc
