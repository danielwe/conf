#!/bin/bash

# Prepare the nvidia driver for use with a cuda installed from e.g. anaconda:

# 18.04 assuming the nvidia driver and nvidia-prime is installed. Note that
# nvidia-headless is perfectly adequate for cuda, but leaves system unbootable
# if nvidia is not blacklisted, so stay with prime-select intel at all times.
sudo prime-select intel  # Turn off nvidia at boot
sudo systemctl disable nvidia-fallback.service  # Would load blacklisted and off-aliased nouveau
sudo sed -i 's/^alias/#alias/' /etc/modprobe.d/blacklist-nvidia.conf  # Remove off-aliasing of nvidia to make it loadable
sudo update-initramfs -u -k all
# Restart.
#
# Before starting a cuda application do:
# sudo modprobe nvidia
# That's all!


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
