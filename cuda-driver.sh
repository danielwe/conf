#!/bin/bash

# Prepare the nvidia driver for use with CUDA installed from e.g. anaconda:

# PREFERRED METHOD

# With bbswitch (no nvidia-prime).
BLACKLIST_CONF=/etc/modprobe.d/blacklist-nvidia.conf
BBSWITCH_LOAD=/etc/modules-load.d/bbswitch.conf
BBSWITCH_CONF=/etc/modprobe.d/bbswitch.conf

# Pinned, headless driver
#VERSION=410  # Check preferred repo for latest version
#sudo apt install nvidia-headless-$VERSION nvidia-utils-$VERSION libnvidia-cfg1-$VERSION

# Full, automatically upgraded drivers, with CUDA
sudo apt install cuda  # or just cuda-drivers

sudo systemctl disable nvidia-fallback.service
echo "blacklist nvidia" | sudo tee "$BLACKLIST_CONF"
echo "blacklist nvidia-uvm" | sudo tee -a "$BLACKLIST_CONF"
echo "blacklist nvidia-drm" | sudo tee -a "$BLACKLIST_CONF"
echo "blacklist nvidia-modeset" | sudo tee -a "$BLACKLIST_CONF"

sudo apt install bbswitch-dkms
echo "bbswitch" | sudo tee "$BBSWITCH_LOAD"
echo "options bbswitch load_state=0" | sudo tee "$BBSWITCH_CONF"

sudo update-initramfs -u

sudo sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"$/\1 nogpumanager"/' /etc/default/grub
# Some hardware requires the following kernel parameter to work with bbswitch:
sudo sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"$/\1 acpi_rev_override"/' /etc/default/grub
sudo update-grub
# Restart.
# To turn on nvidia GPU:
# sudo tee /proc/acpi/bbswitch <<< ON
# sudo modprobe nvidia
# sudo nvidia-smi -pm 1  # Optional, enables persistence mode
# To turn off nvidia GPU:
# sudo nvidia-smi -pm 0
# sudo modprobe -r nvidia_drm nvidia_uvm
# sudo tee /proc/acpi/bbswitch <<< OFF


# OTHER METHODS:

# 18.04 assuming nvidia-driver-* and nvidia-prime is installed. Not always stable. Using
# nvidia-headless is not a good idea; no real benefits, but easy to end up in an
# unbootable state.
#MOD_DIR="/lib/modprobe.d"  # Or /etc/modprobe.d for older versions of prime
#sudo prime-select intel  # Turn off nvidia at boot
#sudo sed -i 's/^alias/#alias/' "$MOD_DIR/blacklist_nvidia.conf"  # Make nvidia loadable
# Restart.
# 
# Before using CUDA, execute:
# sudo modprobe nvidia
#
# NOTE: driver version 410 from the CUDA repos contains a more insistent persistence
# daemon that makes the system unstable when configured as above, especially when waking
# from lock or sleep. Use the version from the ubuntu repos for the time being.

# Older versions:

# BASHRC="${HOME}/.bashrc"

# add nvidia driver to linker path if not the selected graphics card
# echo >> ${BASHRC}
# echo '# Add nvidia binaries and libraries to path if offline, for CUDA' >> ${BASHRC}
# echo 'if [ "'"$( prime-select query )"'" == "'"intel"'" ]' >> ${BASHRC}
# echo 'then' >> ${BASHRC}
# echo '    nvdir=( /usr/lib/nvidia-??? )' >> ${BASHRC}
# echo '    if [ ${#nvdir[@]} -ge 0 ]' >> ${BASHRC}
# echo '    then' >> ${BASHRC}
# echo '        export PATH="${nvdir[-1]}/bin${PATH:+:${PATH}}"' >> ${BASHRC}
# echo '        export LD_LIBRARY_PATH="${nvdir[-1]}${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"' >> ${BASHRC}
# echo '    fi' >> ${BASHRC}
# echo '    unset nvdir' >> ${BASHRC}
# echo 'fi 2>/dev/null' >> ${BASHRC}


# Manual CUDA install: lots of hoops to jump through, but in the end you want
# to add something like this to .bashrc:

# add cuda binaries to path
#if [ -d "/usr/local/cuda" ] ; then
#    PATH="/usr/local/cuda/bin:$PATH"

    # manually add cuda libraries to linker path
    #export CUDA_HOME="/usr/local/cuda"
    #export LD_LIBRARY_PATH="$CUDA_HOME/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
    #export LD_LIBRARY_PATH="$CUDA_HOME/nvvm/lib64:${LD_LIBRARY_PATH}"
    #export LD_LIBRARY_PATH="$CUDA_HOME/extras/CUPTI/lib64:${LD_LIBRARY_PATH}"
    #export LD_LIBRARY_PATH="$CUDA_HOME/extras/Debugger/lib64:${LD_LIBRARY_PATH}"
#fi
