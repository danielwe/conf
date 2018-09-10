#!/bin/bash
# vim: foldmethod=marker

# Install packages and configure a fresh Ubuntu install

# Potentially useful packages not installed by this script {{{1
#anaconda:        Scientific Python environment
#gparted:         Manage disk partitions
#unison-gtk:      Syncronize files/folders
#boinc-manager:   Manage participation in BOINC-based projects
#jhead:           Rename jpeg files using exif data
#timidity:        Play midi files
#wine:            Run windows software
#matlab-support:  Improve MATLAB; only relevant when MATLAB installed
#flightgear:      Flight Simulator
#oracle-java:     Official Java implementation. PPA: webupd8team/java
#pipelight:       Run silverlight plugin etc. via wine. PPA: pipelight/stable
#skype:           Now a snap; also works in browser
#spotify:         Now a snap; also works in browser
#glances:         Terminal performance monitor with client-server mode
#PySensors:       Python bindings for libsensors.so
#redshift-gtk:    Save your eyes; obsolete in 18.04
#xdotools:        Simulate mouse&key input etc.
#cifs-utils:      Mount cross-platform network filesystems (samba)
#mesa-utils:      List OpenGL info
#gimp:            ~photoshop
#inkscape:        vector graphics
#vlc:             play any media file
#xournal:         document processor for stylus handwriting
#lilypond:        latex-like for sheet music typesetting
#openconnect:     vpn
#virtualbox:      install from Oracle repo; add user to vboxusers group
#pianoteq:        install from modartt
#libopenblas-base
#libopenblas-dev

# Get directory containing this script {{{1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# }}}1
# Install packages {{{1

# Add third-party repositories {{{2

sudo add-apt-repository -y ppa:peterlevi/ppa  # variety
sudo add-apt-repository -y ppa:jonathonf/vim  # up-to-date vim dodges bugs

# Install regular packages {{{2

sudo apt update
sudo apt install \
    \ # backgrounds and themes {{{3
    variety \  # download and cycle desktop backgrounds
    \ # essential applications  {{{3
    chromium-browser \
    nautilus-dropbox \
    zathura \                 # pdf viewer with recoloring
    vim-gtk \                 # vim-gnome/vim-gtk3 is has no ruby support
    libcanberra-gtk-module \  # sounds for for gvim
    \ # command line and config tools {{{3
    ncurses-term \        # terminal type definitions
    curl \                # transfer data to/from URL (download files etc.)
    trash-cli \           # rm to trash
    tree \                # like ls -R but readable
    silversearcher-ag \   # search like grep but better
    linux-tools-common \  # kernel tools for etc.
    powertop \            # power monitoring and diagnosis
    tlp \                 # power settings for laptops
    tlp-rdw \             # power settings for wireless devices
    cpufrequtils \        # cpu frequency scaling utilities
    \ #acpi-call-dkms \      # extra power tools for thinkpads
    \ # development tools {{{3
    git \
    exuberant-ctags \  # generate tags
    cmake \            # build process manager
    clang \            # C-family LLVM frontend (compiler etc.)
    openmpi-bin \      # MPI binaries
    libopenmpi-dev \   # MPI headers
    ruby-dev \         # ruby headers
    shellcheck \       # static analysis/linting for shell scripts

# Link configuration dotfiles {{{1
source "${DIR}/link-dotfiles.sh"

# Source custom bashrc {{{1
source "${DIR}/install-bashrc.sh"

# Set execute permissions in local bin folder {{{1
chmod +x "${HOME}/bin/"*  # The glob skips hidden files by default, yay

# Configure system settings {{{1
source "${DIR}/system-config.sh"

# Miscellaneous tips {{{1

### Make a remapped mono sink for the master sink in pulseaudio
### i) find the name of the sink:
# $ pacmd list-sinks | grep name:
### ii) add the following line to /etc/pulse/default.pa
#load-module module-remap-sink sink_name=mono master=<master_sink_name> channels=4 channel_map=left,right,left,right master_channel_map=left,left,right,right
### Alternatively (one-off solution): run the command
# $ pacmd <statement above>

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
