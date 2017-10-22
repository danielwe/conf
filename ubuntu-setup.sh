#!/bin/bash
# vim: foldmethod=marker

# Install necessary/useful packages and configure a fresh Ubuntu install

# Potentially useful packages not installed by this script {{{1
#anaconda:        Scientific Python environment
#gparted:         Manage disk partitions.
#unetbootin:      Create bootable live USB sticks.
#unison-gtk:      Syncronize files/folders.
#boinc-manager:   Manage participation in BOINC-based projects.
#jhead:           Rename jpeg files using exif data.
#timidity:        Play midi files.
#wine:            Run windows software.
#matlab-support:  Improve MATLAB. Only relevant when MATLAB installed.
#flightgear:      Flight Simulator!!
#oracle-java:     Official Java implementation. PPA: webupd8team/java
#pipelight:       Run silverlight plugin etc. via wine. PPA: pipelight/stable
#skype:           Canonical partner repositories.
#spotify:         Separate repository. Consider using Spotify Web instead.
#glances:         Terminal performance monitor with client-server mode
#PySensors (pip): Python bindings for libsensors.so

# Get directory containing this script {{{1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# }}}1
# Install packages {{{1

# Add third-party repositories {{{2

sudo add-apt-repository -y ppa:peterlevi/ppa

# Install regular packages {{{2

sudo apt update
sudo apt install \
    variety \
    redshift-gtk \
    chromium-browser \
    lilypond \
    zathura \
    xdotools \
    cifs-utils \
    git \
    cmake \
    clang \
    openmpi-bin \
    libopenmpi-dev \
    ruby-dev \
    python-dev \
    python-jedi \
    pylint \
    python-flake8 \
    python3-dev \
    python3-jedi \
    python3-flake8 \
    shellcheck \
    exuberant-ctags \
    silversearcher-ag \
    vim-gtk3 \
    curl \
    csh \
    linux-tools-common \
    powertop \
    tlp \
    tlp-rdw \
    cpufrequtils \
    #acpi-call-dkms \  # Thinkpads only
    #gimp \
    #inkscape \
    #vlc \
    #dconf-editor \
    #nautilus-dropbox \
    #xournal \
    #openconnect \
    #texlive-full \
    #biber \
    #texmaker \
    #build-essential \  # Included in Ubuntu by default
    #ack-grep \
    #libopenblas-base \
    #libopenblas-dev \
    #libatlas3-base \
    #libatlas-dev \

## Install mendeley {{{2
#source "${DIR}/mendeley-setup.sh"

## Install vim from source {{{2
#source "${DIR}/vim-source-setup.sh"

## Install most recent TeX Live {{{2
#source "${DIR}/texlive-setup.sh"

# Link configuration dotfiles {{{1
source "${DIR}/link-dotfiles.sh"

# Configure git {{{1
source "${DIR}/git-config.sh"

# Set execute permissions in local bin folder {{{1

chmod +x "${HOME}/bin/"*  # The glob skips hidden files by default, yay

# Configure system settings {{{1
source "${DIR}/system-config.sh"

# Other setup tips {{{1

# When installing virtualbox, remember a) to install the official Oracle
# binary, not the one in the Ubuntu repos, and b) to add your user to the
# vboxusers group! Required for USB filtering etc.

# If computer refuses to stay asleep in standby, the wakeup signal may be
# coming from the USB 3 bus. One cure is to add the following line to
# /etc/rc.local, _before_ the `exit 0`-line:
#echo XHC > /proc/acpi/wakeup

# If a file or folder is pasted somewhere and acquires wrong permissions, use
# commands such as the following to fix (this example sets default permissions
# for new folders under the home directory):
#chmod -R ug=rwX <name>
#chmod -R o=rX <name>

# Best way to install MATLAB: download iso from progdist, mount iso with
# executable rights, run installer, unmount iso, install matlab-support:
#sudo mkdir /media/daniel/iso
#sudo mount /path/to/matlab.iso /media/daniel/iso -o exec
#cd /media/daniel/iso
#sudo ./install &
# follow wizard
#sudo umount /media/daniel/iso
#sudo apt-get install matlab-support
# Note: to activate and run Matlab, the computer must have a network device
# with name "eth0". If running into problems while activating, open
# /etc/udev/rules.d/70-persistent-net.rules or similar for editing, and change
# the NAME= key of a device to "eth0".
