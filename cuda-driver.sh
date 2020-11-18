#!/bin/bash

# Prepare the nvidia driver for use with CUDA installed from e.g. anaconda:

# PACKAGES
sudo apt install cuda  # or just cuda-drivers

# STARTUP BEHAVIOR AND POWER MANAGMENT
# gpu-manager needs to believe it's being instructed by prime-select to boot on intel
echo 'off' | sudo tee "/etc/prime-discrete"

# module options to enable runtime D3 power management
echo \
'# Enable fine-grained runtime D3 power control
options nvidia "NVreg_DynamicPowerManagement=0x01"' \
  | sudo tee "/etc/modprobe.d/nvidia.conf"

# Hooks to ensure consistent power control states on driver load/unload, and disable USB
# and audio for kernels < 5.5. See
# https://download.nvidia.com/XFree86/Linux-x86_64/450.51/README/dynamicpowermanagement.html.
echo \
'# TODO: Remove the first three rules once kernel 5.5 lands

# Remove NVIDIA USB xHCI Host Controller devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{remove}="1"

# Remove NVIDIA USB Type-C UCSI devices, if present
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{remove}="1"

# Remove NVIDIA Audio devices, if present. NOTE: will disable audio over HDMI.
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"

# Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"

# Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"' \
  | sudo tee "/etc/udev/rules.d/80-nvidia-pm.rules"

# VERSION SPECIFIC ISSUES

# If system X server is < 1.21 and PRIME offloading is desired, install patched version.
# See
# https://download.nvidia.com/XFree86/Linux-x86_64/450.51/README/primerenderoffload.html
sudo add-apt-repository ppa:aplattner/ppa

# Pin repo in case its versions are lagging
echo \
'Package: *
Pin: release o=LP-PPA-aplattner
Pin-Priority: 5000' \
  | sudo tee "/etc/apt/preferences.d/xorg-repository-pin-5000"

sudo apt upgrade

# If GPU is older than the Turing architecture, nvidia_drm must remain unloaded until
# all X sessions have started for power management to be able to turn it off completely
# when not in use, since any X session loaded after nvidia_drm will initialize some GPU
# memory, keeping it powered on unless it supports fine-grained runtime D3 power
# management. See
# https://download.nvidia.com/XFree86/Linux-x86_64/450.51/README/dynamicpowermanagement.html.
# There are so many services that want to load the drivers: kernel/gpumanager, gdm,
# xorg, nvidia-persistenced.service, ...; it seems like the most stable solution is to
# blacklist all nvidia drivers and completely disable nvidia-persistenced.service
# (persistence mode isn't very relevant for laptops anyway). Still, for incomprehensible
# reasons, the drivers will load during the first X login session, so the second X login
# session will register Xorg as a GPU client. This can be used to enable PRIME render
# offload for a second graphics/gaming-dedicated user, while minimizing power
# consumption when not using offloading. (Note that if the nvidia driver itself is not
# blacklisted, it will start on boot without also starting nvidia_drm. This might sound
# desireable, but this turns out to be incredibly unstable and lead to frequent crashes
# during boot, at least when persistence mode is disabled.)

echo '
# Avoid loading drivers at boot
blacklist nvidia
blacklist nvidia_uvm
blacklist nvidia_modeset
blacklist nvidia_drm' \
  | sudo tee -a "/etc/modprobe.d/nvidia.conf"

sudo systemctl mask nvidia-persistenced.service

# OLDER SOLUTIONS

# A more heavyhanded way to avoid premature driver loading: unregister card on boot
# echo "w /sys/bus/pci/devices/0000:01:00.0/remove - - - - 1" \
#   | sudo tee /etc/tmpfiles.d/nvidia-off.conf
# # Make sure to re-register GPU before going to sleep, otherwise trouble awaits
# SLEEP_HOOK=/lib/systemd/system-sleep/nvidia
#
# echo \
# '#!/bin/sh
#
# case $1 in
#   pre)
#     modprobe --dry-run --first-time nvidia > /dev/null 2>&1 \
#       && echo 1 > "/sys/bus/pci/rescan" \
#       && sleep 1 \
#       && modprobe nvidia
#     ;;
#   post)
#     ;;
# esac' \
#   | sudo tee "$SLEEP_HOOK"
# sudo chmod +x "$SLEEP_HOOK"

# To turn on GPU from bash, use commands from sleep hook. Consider adding to .xprofile.


# Power management using bbswitch

# Note that the GPU is correctly powered off with recent kernels, even if bbswitch
# complains to syslogs that it's not. (Check power consumption in powertop or similar to
# confirm).
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

# Manually configuring linker paths

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
