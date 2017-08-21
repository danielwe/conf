#!/bin/bash

# Build optimized ATLAS packages for the current architecture

# NOTE: CPU throttling (SpeedStep etc.) should be disabled in BIOS before
# running, and the intel pstate driver should be disabled. This is done by
# adding the kernel argument 'intel_pstate=disable' at boot time (i.e. in
# /etc/default/grub).

#CORES=$(cat /sys/devices/system/cpu/present | tr '-' ' ')
#for CPU in $(seq $CORES); do
#    sudo cpufreq-set --cpu ${CPU} --governor performance
#done

sudo apt-get -y build-dep atlas
sudo apt-get -y install devscripts

mkdir atlas
cd atlas
apt-get source atlas

cd atlas*
fakeroot debian/rules custom

cd ..
sudo dpkg -i libatlas3-base_*.deb
sudo dpkg -i libatlas3gf-base_*.deb
sudo dpkg -i libatlas-dev_*.deb
sudo dpkg -i libatlas-base-dev_*.deb
cd ..

sudo update-alternatives --set libblas.so /usr/lib/atlas-base/atlas/libblas.so
sudo update-alternatives --set libblas.so.3 /usr/lib/atlas-base/atlas/libblas.so.3
sudo update-alternatives --set liblapack.so /usr/lib/atlas-base/atlas/liblapack.so
sudo update-alternatives --set liblapack.so.3 /usr/lib/atlas-base/atlas/liblapack.so.3
