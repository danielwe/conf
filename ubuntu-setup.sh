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

### NCQ must be disabled if /var/log/syslog is being spammed with ata errors, like this:
#Oct  9 12:55:19 new-orleans kernel: [  370.682159] ata2: exception Emask 0x1 SAct 0x0 SErr 0x40000 action 0x0
#Oct  9 12:55:19 new-orleans kernel: [  370.682165] ata2: irq_stat 0x40000008
#Oct  9 12:55:19 new-orleans kernel: [  370.682169] ata2: SError: { CommWake }
#Oct  9 12:55:21 new-orleans kernel: [  372.743263] ata2: log page 10h reported inactive tag 31
#Oct  9 12:55:21 new-orleans kernel: [  372.743275] ata2.00: exception Emask 0x1 SAct 0x40000000 SErr 0x50000 action 0x0
#Oct  9 12:55:21 new-orleans kernel: [  372.743277] ata2.00: irq_stat 0x40000001
#Oct  9 12:55:21 new-orleans kernel: [  372.743280] ata2: SError: { PHYRdyChg CommWake }
#Oct  9 12:55:21 new-orleans kernel: [  372.743284] ata2.00: failed command: WRITE FPDMA QUEUED
#Oct  9 12:55:21 new-orleans kernel: [  372.743289] ata2.00: cmd 61/10:f0:38:f0:30/00:00:26:00:00/40 tag 30 ncq dma 8192 out
#Oct  9 12:55:21 new-orleans kernel: [  372.743289]          res 41/04:00:67:22:35/00:00:14:00:00/40 Emask 0x1 (device error)
#Oct  9 12:55:21 new-orleans kernel: [  372.743291] ata2.00: status: { DRDY ERR }
#Oct  9 12:55:21 new-orleans kernel: [  372.743292] ata2.00: error: { ABRT }
#Oct  9 12:55:21 new-orleans kernel: [  372.743300] ata2: hard resetting link
#Oct  9 12:55:21 new-orleans kernel: [  373.052592] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
#Oct  9 12:55:21 new-orleans kernel: [  373.053418] ata2.00: configured for UDMA/133
#Oct  9 12:55:21 new-orleans kernel: [  373.053463] ata2: EH complete
### To disable, add the switch 'libata.force=2:noncq' to the kernel command line in
### '/etc/default/grub'. Replace '2' with the port indicated by the errors. Run ###
### 'sudo update-grub' to activate the changes.

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
