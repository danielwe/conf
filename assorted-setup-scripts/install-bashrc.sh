#!/bin/sh

# Install custom bashrc
echo >> ~/.bashrc
echo '# Source custom config' >> ~/.bashrc
echo '[ -f ~/.bashrc.custom ] && source ~/.bashrc.custom' >> ~/.bashrc
