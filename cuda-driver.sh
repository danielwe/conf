#!/bin/bash

# Prepare the nvidia driver for use with CUDA installed from e.g. anaconda:

# WITH MANUAL TOGGLING, NO NVIDIA-PRIME

# Full, automatically upgraded drivers, with CUDA
sudo apt install cuda  # or just cuda-drivers

# Pinned, headless driver
#VERSION=410  # Check preferred repo for latest version
#sudo apt install nvidia-headless-$VERSION nvidia-utils-$VERSION libnvidia-cfg1-$VERSION

BLACKLIST_CONF=/etc/modprobe.d/blacklist-nvidia.conf

echo 'blacklist nvidia
blacklist nvidia_uvm
blacklist nvidia_modeset
blacklist nvidia_drm' | sudo tee "$BLACKLIST_CONF"

# PREFERRED: automatic power management by the kernel. With recent kernels this is
# sufficient for the GPU to be powered down when drivers are unloaded.

# Make sure that GPU is completely off on boot to avoid driver loading by anyone
# (kernel, xorg, gnome, nvidia-fallback.service, ...)
OFF_CONF=/etc/tmpfiles.d/nvidia-off.conf
echo "w /sys/bus/pci/devices/0000:01:00.0/remove - - - - 1" | sudo tee "$OFF_CONF"

sudo update-initramfs -u

# Make sure GPU is always on when going to sleep, otherwise you'll get in trouble. For
# some reason any attempt to automatically turn it back off on resume will fail to
# persist, so this hook does not bother trying.
SLEEP_HOOK=/lib/systemd/system-sleep/nvidia

echo '#!/bin/sh

GPUID="0000:01:00.0"

case $1 in
  pre)
    if modprobe --dry-run --first-time nvidia > /dev/null 2>&1
    then
      echo 1 > "/sys/bus/pci/rescan" \
        && echo auto > "/sys/bus/pci/devices/$GPUID/power/control" \
        && modprobe nvidia \
        && nvidia-smi -pm 1
    fi
    ;;
  post)
    exit 0
    ;;
esac' | sudo tee "$SLEEP_HOOK"
sudo chmod +x "$SLEEP_HOOK"

# Restart.

# To turn on GPU from bash:
#GPUID="0000:01:00.0"
#sudo tee /sys/bus/pci/rescan <<< 1 \
#  && sudo tee "/sys/bus/pci/devices/$GPUID/power/control" <<< auto \
#  && sudo modprobe nvidia \
#  && sudo nvidia-smi -pm 1
# To turn off GPU from bash:
#sudo tee "/sys/bus/pci/devices/$GPUID/power/control" <<< auto \
#  && sudo nvidia-smi -pm 0 \
#  && sudo modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia

# Power management using bbswitch. Note that the GPU is correctly powered off with
# recent kernels, even if bbswitch complains to syslogs that it's not. (Check power
# consumption in powertop or similar to confirm).
#
##sudo systemctl disable nvidia-fallback.service  # No longer present for recent drivers
#
#BBSWITCH_LOAD=/etc/modules-load.d/bbswitch.conf
#BBSWITCH_CONF=/etc/modprobe.d/bbswitch.conf
#
#sudo apt install bbswitch-dkms
#echo "bbswitch" | sudo tee "$BBSWITCH_LOAD"
#echo "options bbswitch load_state=0" | sudo tee "$BBSWITCH_CONF"
#
#sudo update-initramfs -u
#
#sudo sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"$/\1 nogpumanager"/' /etc/default/grub
## Some hardware requires the following kernel parameter to work with bbswitch:
#sudo sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"$/\1 acpi_rev_override"/' /etc/default/grub
#sudo update-grub
#
# Restart.
#
# To turn on nvidia GPU:
#sudo tee /proc/acpi/bbswitch <<< ON
#sudo modprobe nvidia && sudo nvidia-smi -pm 1  # Optional, enables persistence mode
# To turn off nvidia GPU:
#sudo modprobe -r nvidia_drm nvidia_modeset nvidia_uvm
#sudo nvidia-smi -pm 0 && sudo modprobe -r nvidia
#sudo tee /proc/acpi/bbswitch <<< OFF


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
#sudo modprobe nvidia
#
# NOTE: driver version 410 from the CUDA repos contains a more insistent persistence
# daemon that makes the system unstable when configured as above, especially when waking
# from lock or sleep. Use the version from the ubuntu repos for the time being.

# Older versions:

#BASHRC="${HOME}/.bashrc"

# add nvidia driver to linker path if not the selected graphics card
#echo >> ${BASHRC}
#echo '# Add nvidia binaries and libraries to path if offline, for CUDA' >> ${BASHRC}
#echo 'if [ "'"$( prime-select query )"'" == "'"intel"'" ]' >> ${BASHRC}
#echo 'then' >> ${BASHRC}
#echo '    nvdir=( /usr/lib/nvidia-??? )' >> ${BASHRC}
#echo '    if [ ${#nvdir[@]} -ge 0 ]' >> ${BASHRC}
#echo '    then' >> ${BASHRC}
#echo '        export PATH="${nvdir[-1]}/bin${PATH:+:${PATH}}"' >> ${BASHRC}
#echo '        export LD_LIBRARY_PATH="${nvdir[-1]}${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"' >> ${BASHRC}
#echo '    fi' >> ${BASHRC}
#echo '    unset nvdir' >> ${BASHRC}
#echo 'fi 2>/dev/null' >> ${BASHRC}


# Manual CUDA install: lots of hoops to jump through, but in the end you want
# to add something like this to .bashrc:

# add cuda binaries to path
#if [ -d "/usr/local/cuda" ] ; then
#    PATH="/usr/local/cuda/bin:$PATH"
#
#    # manually add cuda libraries to linker path
#    export CUDA_HOME="/usr/local/cuda"
#    export LD_LIBRARY_PATH="$CUDA_HOME/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
#    export LD_LIBRARY_PATH="$CUDA_HOME/nvvm/lib64:${LD_LIBRARY_PATH}"
#    export LD_LIBRARY_PATH="$CUDA_HOME/extras/CUPTI/lib64:${LD_LIBRARY_PATH}"
#    export LD_LIBRARY_PATH="$CUDA_HOME/extras/Debugger/lib64:${LD_LIBRARY_PATH}"
#fi
