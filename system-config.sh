#!/bin/bash
# vim: foldmethod=marker

# Custom keybindings {{{1
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"

gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>m'
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-system-monitor'
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'System Monitor'

gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Primary><Alt>v'
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'gvim'
gsettings set \
    org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'GVim'

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

## Onboard touch keyboard {{{1
#gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true
#gsettings set org.onboard start-minimized true
#gsettings set org.onboard xembed-onboard true
#gsettings set org.onboard.window docking-enabled true
#gsettings set org.onboard.window.landscape dock-height 350
#gsettings set org.onboard.window.portrait dock-height 300

## Wireless power management {{{1
## Try this if wireless connection is unstable
#
#sudo echo \
#'#!/bin/sh
#
## Turn off wireless power management
#iwconfig wlan0 power off > /dev/null 2>&1' > /etc/pm/power.d/wireless
#sudo chmod +x /etc/pm/power.d/wireless

## Session logon and lock settings {{{1
# No need to script this, is frequently changed according to needs
#gsettings set org.gnome.desktop.session idle-delay 600

# RIP UNITY
## Unity/Compiz/indicator settings {{{1
#gsettings set \
#    org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 1
#gsettings set \
#    org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2
#gsettings set \
#    org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 2

#gsettings set com.canonical.indicator.datetime show-date true
#gsettings set com.canonical.indicator.datetime show-seconds true
#gsettings set com.canonical.indicator.datetime show-week-numbers true
#gsettings set com.canonical.indicator.power show-percentage true
#gsettings set com.canonical.indicator.power show-time true
