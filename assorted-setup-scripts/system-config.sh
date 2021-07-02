#!/bin/bash
# vim: foldmethod=marker

# Custom keybindings {{{1
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>m'
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-system-monitor'
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'System Monitor'

gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Primary><Alt>n'
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'x-terminal-emulator -e sudo systemctl restart network-manager.service'
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Restart network manager'

# Touchpad scroll behavior {{{1
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
#gsettings set org.gnome.desktop.peripherals.touchpad horiz-scroll-enabled false

# Location services {{{1
gsettings set org.gnome.system.location max-accuracy-level city
gsettings set org.gnome.system.location enabled true

## Wireless power management {{{1
## Try this if wireless connection is unstable
#
#sudo echo \
#'#!/bin/sh
#
## Turn off wireless power management
#iwconfig wlan0 power off > /dev/null 2>&1' > /etc/pm/power.d/wireless
#sudo chmod +x /etc/pm/power.d/wireless
