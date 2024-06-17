#!/bin/bash
#******************************************************************************
# ZYNTHIAN PROJECT: Zynthian Setup Script
#
# Setup zynthian software stack in a fresh vision five 2 "bookworm" image
#
# Copyright (C) 2015-2023 Fernando Moyano <jofemodo@zynthian.org>
#
#******************************************************************************
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# For a full copy of the GNU General Public License see the LICENSE.txt file.
#
#******************************************************************************

set -x

#------------------------------------------------------------------------------
# Set default password & enable ssh on first boot
#------------------------------------------------------------------------------

# zynia 2024-04-10 Not sure this applies in vf2 case; commenting out for now
# With the SDcard mounted in your computer
#cd /media/txino/bootfs
#echo -n "zyn:" > userconf.txt
#echo 'opensynth' | openssl passwd -6 -stdin >> userconf.txt
#touch ssh

#------------------------------------------------------------------------------
# Load Environment Variables
#------------------------------------------------------------------------------

source "zynthian_envars_extended.sh"

#------------------------------------------------
# Set default config
#------------------------------------------------

[ -n "$ZYNTHIAN_INCLUDE_RPI_UPDATE" ] || ZYNTHIAN_INCLUDE_RPI_UPDATE=no
[ -n "$ZYNTHIAN_INCLUDE_PIP" ] || ZYNTHIAN_INCLUDE_PIP=yes
[ -n "$ZYNTHIAN_CHANGE_HOSTNAME" ] || ZYNTHIAN_CHANGE_HOSTNAME=yes

[ -n "$ZYNTHIAN_SYS_REPO" ] || ZYNTHIAN_SYS_REPO="https://github.com/zynia-org/zynthian-sys.git"
[ -n "$ZYNTHIAN_UI_REPO" ] || ZYNTHIAN_UI_REPO="https://github.com/zynia-org/zynthian-ui.git"
[ -n "$ZYNTHIAN_ZYNCODER_REPO" ] || ZYNTHIAN_ZYNCODER_REPO="https://github.com/zynia-org/zyncoder.git"
[ -n "$ZYNTHIAN_WEBCONF_REPO" ] || ZYNTHIAN_WEBCONF_REPO="https://github.com/zynia-org/zynthian-webconf.git"
[ -n "$ZYNTHIAN_DATA_REPO" ] || ZYNTHIAN_DATA_REPO="https://github.com/zynia-org/zynthian-data.git"

[ -n "$ZYNTHIAN_BRANCH" ] || ZYNTHIAN_BRANCH="oram-zynia"
[ -n "$ZYNTHIAN_SYS_BRANCH" ] || ZYNTHIAN_SYS_BRANCH="oram-zynia"
[ -n "$ZYNTHIAN_UI_BRANCH" ] || ZYNTHIAN_UI_BRANCH=$ZYNTHIAN_BRANCH
[ -n "$ZYNTHIAN_ZYNCODER_BRANCH" ] || ZYNTHIAN_ZYNCODER_BRANCH=$ZYNTHIAN_BRANCH
[ -n "$ZYNTHIAN_WEBCONF_BRANCH" ] || ZYNTHIAN_WEBCONF_BRANCH=$ZYNTHIAN_BRANCH
[ -n "$ZYNTHIAN_DATA_BRANCH" ] || ZYNTHIAN_DATA_BRANCH=$ZYNTHIAN_BRANCH

#------------------------------------------------
# Update System & Firmware
#------------------------------------------------

# Update System
#apt-get -y update --allow-releaseinfo-change
#apt-get -y full-upgrade

# Install required dependencies if needed
apt-get -y install apt-utils
apt-get -y install apt-transport-https
# zynia 2024-04-10 rpi specific
#apt-get -y install rpi-update
apt-get -y install sudo
# zynia 2024-04-10 many, many conflicts - removing to be safe
#apt-get -y install software-properties-common
# zynia 2024-04-16 Installing partd seems to cause lots of autoremoves - so removing
#apt-get -y install parted
apt-get -y install dirmngr
# zynia 2024-04-10 rpi specific
#apt-get -y install rpi-eeprom
apt-get -y install gpgv
apt-get -y install wget

# Update Firmware
if [ "$ZYNTHIAN_INCLUDE_RPI_UPDATE" == "yes" ]; then
    rpi-update
fi

#------------------------------------------------
# Add Repositories
#------------------------------------------------

# zynia 2024-04-09 deb-multimedia has no riscv
# deb-multimedia repo
#echo "deb https://www.deb-multimedia.org bookworm main non-free" >> /etc/apt/sources.list
#apt-get -y update -oAcquire::AllowInsecureRepositories=true
#apt-get -y --allow-unauthenticated  install deb-multimedia-keyring

# zynia 2024-09 kxstudio repos have no riscv support
# KXStudio
#wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_11.1.0_all.deb
#sudo dpkg -i kxstudio-repos_11.1.0_all.deb
#rm -f kxstudio-repos_11.1.0_all.deb

# zynia 2024-04-09 zynthian repos have no riscv support
# Zynthian
#wget -O - https://deb.zynthian.org/deb-zynthian-org.gpg > /etc/apt/trusted.gpg.d/deb-zynthian-org.gpg
#echo "deb https://deb.zynthian.org/zynthian-oram bookworm-oram main" > "/etc/apt/sources.list.d/zynthian.list"

# Sfizz => Repo version segfaults!!
#sfizz_url_base="https://download.opensuse.org/repositories/home:/sfztools:/sfizz/Raspbian_12"
#echo "deb $sfizz_url_base/ /" | sudo tee /etc/apt/sources.list.d/home:sfztools:sfizz.list
#curl -fsSL $sfizz_url_base/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_sfztools_sfizz.gpg > /dev/null

#apt-get -y update

# zynia 2024-04-09 Do not do upgrades to avoid upgrading various vf2 things should not be upgraded
#apt-get -y full-upgrade
#apt-get -y autoremove

#------------------------------------------------
# Install Required Packages
#------------------------------------------------

# System
apt-get -y remove --purge isc-dhcp-client
apt-get -y remove --purge triggerhappy
apt-get -y remove --purge logrotate
apt-get -y remove --purge dphys-swapfile
# zynia 2024-04-16 Systemd and avahi-daemon updates seem unneeded and has lots of issues
#apt-get -y install systemd
#apt-get -y install avahi-daemon
# zynia 2024-04-09 No dhcpcd-dbus in sid
#apt-get -y install dhcpcd-dbus
apt-get -y install usbutils
apt-get -y install udisks2
apt-get -y install udevil
apt-get -y install exfatprogs
apt-get -y install xinit
apt-get -y install xserver-xorg-video-fbdev
apt-get -y install x11-xserver-utils
apt-get -y install xinput
# zynia 2024-04-09 Do not upgrade mesa as per rvspace.org
#apt-get -y install libgl1-mesa-dri
apt-get -y install tigervnc-standalone-server
apt-get -y install xfwm4
apt-get -y install xfce4-panel
apt-get -y install xdotool
apt-get -y install cpufrequtils
apt-get -y install wpasupplicant
apt-get -y install wireless-tools
apt-get -y install iw
apt-get -y install hostapd
apt-get -y install dnsmasq
# zynia 2024-09 Not vf2 hardware?
#apt-get -y install firmware-brcm80211 firmware-atheros firmware-realtek atmel-firmware firmware-misc-nonfree
apt-get -y install shiki-colors-xfwm-theme
apt-get -y install fonts-freefont-ttf
apt-get -y install x11vnc
apt-get -y install xserver-xorg-input-evdev
# note: 2024-04-09 commented out in original script
#firmware-ralink

#TODO => Configure xfwm to use shiki-colors theme in VNC

# CLI Tools
apt-get -y install psmisc
apt-get -y install tree
apt-get -y install joe
apt-get -y install nano
apt-get -y install vim
apt-get -y install p7zip-full
apt-get -y install i2c-tools
apt-get -y install ddcutil
apt-get -y install evtest
apt-get -y install libts-bin
apt-get -y install fbi
apt-get -y install scrot
apt-get -y install mpg123
apt-get -y install mplayer
apt-get -y install xloadimage
apt-get -y install imagemagick
apt-get -y install fbcat
apt-get -y install abcmidi
#  zynia 2024-04-10 Do not upgrade ffmpeg as per rvspace.org
#apt-get -y install ffmpeg
apt-get -y install qjackctl
apt-get -y install mediainfo
apt-get -y install xterm
apt-get -y install gpiod
apt-get -y install xfce4-terminal
# note: 2024-04-10 commented out in original script
#  qmidinet

#------------------------------------------------
# Development Environment
#------------------------------------------------

# Libraries
# AV Libraries => WARNING It should be reviewed on every new debian version!!
apt-get -y --no-install-recommends install libx11-dev
apt-get -y --no-install-recommends install libx11-xcb-dev
apt-get -y --no-install-recommends install libxcb-util-dev
apt-get -y --no-install-recommends install libxkbcommon-dev
apt-get -y --no-install-recommends install libfftw3-dev
apt-get -y --no-install-recommends install libmxml-dev
apt-get -y --no-install-recommends install zlib1g-dev
apt-get -y --no-install-recommends install fluid
apt-get -y --no-install-recommends install libfltk1.3-dev
apt-get -y --no-install-recommends install libfltk1.3-compat-headers
apt-get -y --no-install-recommends install libpango1.0-dev
# zynia 2024-04-10 No riscv version of libncurses5-dev in sid - substituting libncurses-dev - which is libncurses6
#apt-get -y --no-install-recommends install libncurses5-dev
apt-get -y --no-install-recommends install libncurses-dev
apt-get -y --no-install-recommends install liblo-dev
apt-get -y --no-install-recommends install dssi-dev
apt-get -y --no-install-recommends install libjpeg-dev
apt-get -y --no-install-recommends install libxpm-dev
apt-get -y --no-install-recommends install libcairo2-dev
apt-get -y --no-install-recommends install libglu1-mesa-dev
apt-get -y --no-install-recommends install libasound2-dev
apt-get -y --no-install-recommends install dbus-x11
apt-get -y --no-install-recommends install jackd2
apt-get -y --no-install-recommends install libjack-jackd2-dev
apt-get -y --no-install-recommends install a2jmidid
apt-get -y --no-install-recommends install jack-midi-clock
# zynia 2024-04-10 package not found for riscv or all in sid
#apt-get -y --no-install-recommends install midisport-firmware
apt-get -y --no-install-recommends install libffi-dev
apt-get -y --no-install-recommends install fontconfig-config
apt-get -y --no-install-recommends install libfontconfig1-dev
apt-get -y --no-install-recommends install libxft-dev
apt-get -y --no-install-recommends install libexpat-dev
apt-get -y --no-install-recommends install libglib2.0-dev
apt-get -y --no-install-recommends install libgettextpo-dev
apt-get -y --no-install-recommends install libsqlite3-dev
apt-get -y --no-install-recommends install libglibmm-2.4-dev
apt-get -y --no-install-recommends install libeigen3-dev
apt-get -y --no-install-recommends install libsamplerate-dev
apt-get -y --no-install-recommends install libarmadillo-dev
apt-get -y --no-install-recommends install libreadline-dev
# zynia 2024-04-10 lv2-c++-tools only available in deb ports
apt-get -y --no-install-recommends install lv2-c++-tools
apt-get -y --no-install-recommends install libxi-dev
apt-get -y --no-install-recommends install libgtk2.0-dev
apt-get -y --no-install-recommends install libgtkmm-2.4-dev
# zynia 2024-04-10 package not found for riscv or all in sid
# zynia 2024-04-10 but liblrdf0-dev is available
#apt-get -y --no-install-recommends install liblrdf-dev
apt-get -y --no-install-recommends install liblrdf0-dev
apt-get -y --no-install-recommends install libboost-system-dev
apt-get -y --no-install-recommends install libzita-convolver-dev
apt-get -y --no-install-recommends install libzita-resampler-dev
apt-get -y --no-install-recommends install fonts-roboto
apt-get -y --no-install-recommends install libxcursor-dev
apt-get -y --no-install-recommends install libxinerama-dev
apt-get -y --no-install-recommends install mesa-common-dev
apt-get -y --no-install-recommends install libgl1-mesa-dev
# zynia 2024-04-10 libfreetype6-dev not in sid; but libfreetype6-dev is; substituting
apt-get -y --no-install-recommends install libfreetype-dev
apt-get -y --no-install-recommends install libswscale-dev
apt-get -y --no-install-recommends install qtbase5-dev
apt-get -y --no-install-recommends install qtdeclarative5-dev
# zynia 2024-04-10 libcanberra-gtk-module only available in debports
apt-get -y --no-install-recommends install libcanberra-gtk-module
apt-get -y --no-install-recommends install '^libxcb.*-dev'
apt-get -y --no-install-recommends install libcanberra-gtk3-module
apt-get -y --no-install-recommends install libxcb-cursor-dev
apt-get -y --no-install-recommends install libgtk-3-dev
apt-get -y --no-install-recommends install libxcb-util0-dev
apt-get -y --no-install-recommends install libxcb-keysyms1-dev
apt-get -y --no-install-recommends install libxcb-xkb-dev
apt-get -y --no-install-recommends install libxkbcommon-x11-dev
apt-get -y --no-install-recommends install libssl-dev
apt-get -y --no-install-recommends install libmpg123-0
apt-get -y --no-install-recommends install libmp3lame0
apt-get -y --no-install-recommends install libqt5svg5-dev
apt-get -y --no-install-recommends install libxrender-dev
apt-get -y --no-install-recommends install librubberband-dev
apt-get -y --no-install-recommends install libavcodec59
apt-get -y --no-install-recommends install libavformat59
apt-get -y --no-install-recommends install libavutil57
apt-get -y --no-install-recommends install libavformat-dev
apt-get -y --no-install-recommends install libavcodec-dev
apt-get -y --no-install-recommends install libgpiod-dev
# zynia 2024-04-10 package not found for riscv or all in sid
# zynia 2024-04-10 package in debports but many, many conflicts
#apt-get -y --no-install-recommends install libganv-dev
apt-get -y --no-install-recommends install libsdl2-dev
apt-get -y --no-install-recommends install libibus-1.0-dev
apt-get -y --no-install-recommends install gir1.2-ibus-1.0
apt-get -y --no-install-recommends install libdecor-0-dev
apt-get -y --no-install-recommends install libflac-dev
apt-get -y --no-install-recommends install libgbm-dev
apt-get -y --no-install-recommends install libibus-1.0-5
apt-get -y --no-install-recommends install libmpg123-dev
apt-get -y --no-install-recommends install libvorbis-dev
apt-get -y --no-install-recommends install libogg-dev
apt-get -y --no-install-recommends install libopus-dev
apt-get -y --no-install-recommends install libpulse-dev
apt-get -y --no-install-recommends install libpulse-mainloop-glib0
apt-get -y --no-install-recommends install libsndio-dev
apt-get -y --no-install-recommends install libsystemd-dev
apt-get -y --no-install-recommends install libudev-dev
apt-get -y --no-install-recommends install libxss-dev
apt-get -y --no-install-recommends install libxt-dev
apt-get -y --no-install-recommends install libxv-dev
apt-get -y --no-install-recommends install libxxf86vm-dev
apt-get -y --no-install-recommends install libglu-dev
apt-get -y --no-install-recommends install libftgl-dev
# zynia 2024-04-10 package not found for riscv or all in sid
# zynia 2024-06-16 Added libsndfile1-dev instead
#apt-get -y --no-install-recommends install libsndfile1-zyndev
apt-get -y --no-install-recommends install libsndfile1-dev

# note: 2024-04-10 commented out in original script
# Missed libs from previous OS versions:
# Removed from bookworm: libavresample4

# Tools
apt-get -y --no-install-recommends install build-essential
apt-get -y --no-install-recommends install git
apt-get -y --no-install-recommends install swig
apt-get -y --no-install-recommends install pkg-config
apt-get -y --no-install-recommends install autoconf
apt-get -y --no-install-recommends install automake
apt-get -y --no-install-recommends install premake
apt-get -y --no-install-recommends install subversion
apt-get -y --no-install-recommends install gettext
apt-get -y --no-install-recommends install intltool
apt-get -y --no-install-recommends install libtool
apt-get -y --no-install-recommends install libtool-bin
apt-get -y --no-install-recommends install cmake
apt-get -y --no-install-recommends install cmake-curses-gui
apt-get -y --no-install-recommends install flex
apt-get -y --no-install-recommends install bison
apt-get -y --no-install-recommends install ngrep
apt-get -y --no-install-recommends install qt5-qmake
apt-get -y --no-install-recommends install gobjc++
apt-get -y --no-install-recommends install ruby
apt-get -y --no-install-recommends install rake
apt-get -y --no-install-recommends install xsltproc
apt-get -y --no-install-recommends install vorbis-tools
apt-get -y --no-install-recommends install zenity
apt-get -y --no-install-recommends install doxygen
apt-get -y --no-install-recommends install graphviz
apt-get -y --no-install-recommends install glslang-tools
apt-get -y --no-install-recommends install rubberband-cli

# note: 2024-04-10 commented out in original script
# Missed tools from previous OS versions:
#libjack-dev-session
#non-ntk-dev
#libgd2-xpm-dev

# Python3
apt-get -y install python3
apt-get -y install python3-dev
apt-get -y install python3-pip
# zynia 2024-04-16 Need to add python3-venv
apt-get -y install python3-venv
# zynia 2024-04-16 install xstatic stuff via apt vs pip as per experience
#   with setup_system_vf2
apt-get -y install python3-xstatic
apt-get -y install python3-xstatic-term.js
#
apt-get -y install cython3
apt-get -y install python3-cffi
apt-get -y install 2to3
apt-get -y install python3-tk
apt-get -y install python3-dbus
apt-get -y install python3-mpmath
apt-get -y install python3-pil
apt-get -y install python3-pil.imagetk
apt-get -y install python3-setuptools
apt-get -y install python3-pyqt5
apt-get -y install python3-numpy
apt-get -y install python3-evdev
apt-get -y install python3-usb
apt-get -y install python3-soundfile
apt-get -y install python3-psutil
apt-get -y install python3-pexpect
apt-get -y install python3-jsonpickle
apt-get -y install python3-requests
apt-get -y install python3-mido
apt-get -y install python3-rtmidi
apt-get -y install python3-mutagen
apt-get -y install pyliblo-utils

# note: 2024-04-10 commented out in original script
# Python2 (DEPRECATED!!)
#apt-get -y install python-setuptools python-is-python2 python-dev-is-python2

# zynia 2024-06-16 Added to handle issues with cmake and openssl/curl
#  Set LD_LIBRARY_PATH as expected
#
export LD_LIBRARY_PATH=/lib/riscv64-linux-gnu:/usr/local/lib


#------------------------------------------------
# Create Zynthian Directory Tree
# Install Zynthian Software from repositories
#------------------------------------------------

# Create needed directories
mkdir "$ZYNTHIAN_DIR"
mkdir "$ZYNTHIAN_CONFIG_DIR"
mkdir "$ZYNTHIAN_SW_DIR"

# Zynthian System Scripts and Config files
cd "$ZYNTHIAN_DIR"
git clone -b "${ZYNTHIAN_SYS_BRANCH}" "${ZYNTHIAN_SYS_REPO}"

# Config "git pull" strategy globally
# QUESTION: is this needed at all?
#git config --global pull.rebase false

# Zyncoder library
cd "$ZYNTHIAN_DIR"
git clone -b "${ZYNTHIAN_ZYNCODER_BRANCH}" "${ZYNTHIAN_ZYNCODER_REPO}"
./zyncoder/build.sh

# Zynthian UI
cd "$ZYNTHIAN_DIR"
git clone -b "${ZYNTHIAN_UI_BRANCH}" "${ZYNTHIAN_UI_REPO}"
cd "$ZYNTHIAN_UI_DIR"
find ./zynlibs -type f -name build.sh -exec {} \;

# Zynthian Data
cd "$ZYNTHIAN_DIR"
git clone -b "${ZYNTHIAN_DATA_BRANCH}" "${ZYNTHIAN_DATA_REPO}"

# Zynthian Webconf Tool
cd "$ZYNTHIAN_DIR"
git clone -b "${ZYNTHIAN_WEBCONF_BRANCH}" "${ZYNTHIAN_WEBCONF_REPO}"

# Create needed directories
#mkdir "$ZYNTHIAN_DATA_DIR/soundfonts"
#mkdir "$ZYNTHIAN_DATA_DIR/soundfonts/sf2"
mkdir "$ZYNTHIAN_DATA_DIR/soundfonts/sfz"
mkdir "$ZYNTHIAN_DATA_DIR/soundfonts/gig"
mkdir "$ZYNTHIAN_MY_DATA_DIR"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/lv2"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/zynaddsubfx"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/zynaddsubfx/banks"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/zynaddsubfx/presets"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/mod-ui"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/mod-ui/pedalboards"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/puredata"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/puredata/generative"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/puredata/synths"
mkdir "$ZYNTHIAN_MY_DATA_DIR/presets/sysex"
mkdir "$ZYNTHIAN_MY_DATA_DIR/soundfonts"
mkdir "$ZYNTHIAN_MY_DATA_DIR/soundfonts/sf2"
mkdir "$ZYNTHIAN_MY_DATA_DIR/soundfonts/sfz"
mkdir "$ZYNTHIAN_MY_DATA_DIR/soundfonts/gig"
mkdir "$ZYNTHIAN_MY_DATA_DIR/snapshots"
mkdir "$ZYNTHIAN_MY_DATA_DIR/snapshots/000"
mkdir "$ZYNTHIAN_MY_DATA_DIR/capture"
mkdir "$ZYNTHIAN_MY_DATA_DIR/preset-favorites"
mkdir "$ZYNTHIAN_MY_DATA_DIR/zynseq"
mkdir "$ZYNTHIAN_MY_DATA_DIR/zynseq/patterns"
mkdir "$ZYNTHIAN_MY_DATA_DIR/zynseq/tracks"
mkdir "$ZYNTHIAN_MY_DATA_DIR/zynseq/sequences"
mkdir "$ZYNTHIAN_MY_DATA_DIR/zynseq/scenes"
mkdir "$ZYNTHIAN_PLUGINS_DIR"
mkdir "$ZYNTHIAN_PLUGINS_DIR/lv2"

# Copy default snapshots
cp -a $ZYNTHIAN_DATA_DIR/snapshots/* $ZYNTHIAN_MY_DATA_DIR/snapshots/000

#------------------------------------------------
# Python Environment
#------------------------------------------------

cd "$ZYNTHIAN_DIR"
python3 -m venv venv --system-site-packages
source "$ZYNTHIAN_DIR/venv/bin/activate"

pip3 install --upgrade pip
pip3 install JACK-Client
pip3 install alsa-midi
pip3 install oyaml
pip3 install adafruit-circuitpython-neopixel-spi
pip3 install pyrubberband
pip3 install ffmpeg-python
pip3 install Levenshtein
pip3 install sox
pip3 install meson
pip3 install ninja
pip3 install abletonparsing
pip3 install tornado
pip3 install tornadostreamform
pip3 install websocket-client
pip3 install tornado_xstatic
pip3 install terminado
# zynia 2024-04-16 moved to apt install based on experience with pre-bookworm setup_system_vf2
#pip3 install xstatic
#pip3 install XStatic_term.js

#------------------------------------------------
# System Adjustments
#------------------------------------------------

# Use tmpfs for tmp & logs
echo "" >> /etc/fstab
echo "tmpfs  /tmp  tmpfs  defaults,noatime,nosuid,nodev,size=100M   0  0" >> /etc/fstab
echo "tmpfs  /var/tmp  tmpfs  defaults,noatime,nosuid,nodev,size=200M   0  0" >> /etc/fstab
echo "tmpfs  /var/log  tmpfs  defaults,noatime,nosuid,nodev,noexec,size=20M  0  0" >> /etc/fstab

# zynia 2024-04-10  Commenting this out for now - too risky
# Fix timeout in network initialization
#if [ ! -d "/etc/systemd/system/networking.service.d/reduce-timeout.conf" ]; then
#	mkdir -p "/etc/systemd/system/networking.service.d"
#	echo -e "[Service]\nTimeoutStartSec=1\n" > "/etc/systemd/system/networking.service.d/reduce-timeout.conf"
#fi

# zynia 2024-04-10 Hostane zynthian -> zynia
# Change Hostname
if [ "$ZYNTHIAN_CHANGE_HOSTNAME" == "yes" ]; then
    echo "zynia" > /etc/hostname
    sed -i -e "s/127\.0\.1\.1.*$/127.0.1.1\tzynia/" /etc/hosts
fi

# VNC password
echo "opensynth" | vncpasswd -f > /root/.vnc/passwd
chmod go-r /root/.vnc/passwd

# Delete problematic file from X11 config (RPi3??)
rm -f /usr/share/X11/xorg.conf.d/20-noglamor.conf

# Setup loading of Zynthian Environment variables ...
echo "source $ZYNTHIAN_SYS_DIR/scripts/zynthian_envars_extended.sh > /dev/null 2>&1" >> /root/.bashrc

# => Shell & Login Config
echo "source $ZYNTHIAN_SYS_DIR/etc/profile.zynthian" >> /root/.profile
source $ZYNTHIAN_SYS_DIR/etc/profile.zynthian

# zynia 2024-04-10 ZynthianOS -> ZyniaOS
# ZynthianOS version
echo "vf2_2404" > /etc/zynthianos_version
# Build Info
echo "ZyniaOS: Built by zynia,org" > $ZYNTHIAN_DIR/build_info.txt
echo "" >> $ZYNTHIAN_DIR/build_info.txt
echo "Timestamp: 2024-04-10"  >> $ZYNTHIAN_DIR/build_info.txt
echo "" >> $ZYNTHIAN_DIR/build_info.txt
echo "Optimized: Starfive Vision Five 2" >> $ZYNTHIAN_DIR/build_info.txt

# Run configuration script
$ZYNTHIAN_SYS_DIR/scripts/update_zynthian_data.sh

# note: 2024-04-10 commented out in original script
#$ZYNTHIAN_SYS_DIR/scripts/update_zynthian_sys.sh
$ZYNTHIAN_SYS_DIR/sbin/zynthian_autoconfig.py

# Configure systemd services
systemctl daemon-reload
# zynia 2024-04-10 Rpi stuff
#systemctl disable raspi-config
systemctl disable cron
# note: 2024-04-10 commented out in original script
#systemctl disable wpa_supplicant
systemctl disable hostapd
systemctl disable dnsmasq
systemctl disable apt-daily.timer
systemctl disable ModemManager
systemctl disable glamor-test.service
systemctl enable avahi-daemon
systemctl enable devmon@root
# note: 2024-04-10 commented out in original script
#systemctl enable dhcpcd
#systemctl disable rsyslog
#systemctl disable unattended-upgrades
#systemctl mask packagekit
#systemctl mask polkit

# Zynthian specific systemd services
systemctl enable backlight
systemctl enable cpu-performance
# note: 2024-04-10 commented out in original script
#systemctl enable wifi-setup
systemctl enable jack2
systemctl enable mod-ttymidi
systemctl enable a2jmidid
systemctl enable zynthian
systemctl enable zynthian-webconf
systemctl enable zynthian-config-on-boot

# On first boot, resize SD partition, regenerate keys, etc.
$ZYNTHIAN_SYS_DIR/scripts/set_first_boot.sh

#------------------------------------------------
# Build & Install Required Libraries
#------------------------------------------------

# note: 2024-04-10 commented out in original script
# Install Jack2
#$ZYNTHIAN_RECIPE_DIR/install_jack2.sh

# note: 2024-04-10 commented out in original script
# Install pyliblo library (liblo OSC library for Python)
#$ZYNTHIAN_RECIPE_DIR/install_pyliblo.sh

# Install mod-ttymidi (MOD's ttymidi version with jackd MIDI support)
$ZYNTHIAN_RECIPE_DIR/install_mod-ttymidi.sh

# Install LV2 lilv library
$ZYNTHIAN_RECIPE_DIR/install_lv2_lilv.sh

# Install the LV2 C++ Tool Kit
$ZYNTHIAN_RECIPE_DIR/install_lvtk.sh

# TODO FAILED=> ninja: build stopped: subcommand failed.

# Install LV2 Jalv Plugin Host
$ZYNTHIAN_RECIPE_DIR/install_lv2_jalv.sh

# Install Aubio Library & Tools
$ZYNTHIAN_RECIPE_DIR/install_aubio.sh

# note: 2024-04-10 commented out in original script
# Install jpmidi (MID player for jack with transport sync)
#$ZYNTHIAN_RECIPE_DIR/install_jpmidi.sh
# TODO => No configure !! It must be changed to meson or waf or something like that....
# Do we need this? => I think no!!

# Install jack_capture (jackd audio recorder)
$ZYNTHIAN_RECIPE_DIR/install_jack_capture.sh

# Install jack_smf utils (jackd MID-file player/recorder)
$ZYNTHIAN_RECIPE_DIR/install_jack-smf-utils.sh

# note: 2024-04-10 commented out in original script
# Install touchosc2midi (TouchOSC Bridge)
#$ZYNTHIAN_RECIPE_DIR/install_touchosc2midi.sh
# TODO FAILED=> build cython => Probably python 2.7 that must be upgraded

# note: 2024-04-10 commented out in original script
# Install jackclient (jack-client python library)
#$ZYNTHIAN_RECIPE_DIR/install_jackclient-python.sh

# Install QMidiNet (MIDI over IP Multicast)
$ZYNTHIAN_RECIPE_DIR/install_qmidinet.sh

# Install jackrtpmidid (jack RTP-MIDI daemon)
$ZYNTHIAN_RECIPE_DIR/install_jackrtpmidid.sh

# Install the DX7 SysEx parser
$ZYNTHIAN_RECIPE_DIR/install_dxsyx.sh

# Install preset2lv2 (Convert native presets to LV2)
$ZYNTHIAN_RECIPE_DIR/install_preset2lv2.sh

# note: 2024-04-10 commented out in original script
# Install QJackCtl
#$ZYNTHIAN_RECIPE_DIR/install_qjackctl.sh

# Install patchage
$ZYNTHIAN_RECIPE_DIR/install_patchage.sh

# Install the njconnect Jack Graph Manager
$ZYNTHIAN_RECIPE_DIR/install_njconnect.sh

# note: 2024-04-10 commented out in original script
# Install Mutagen (when available, use pip3 install)
# $ZYNTHIAN_RECIPE_DIR/install_mutagen.sh

# Install VL53L0X library (Distance Sensor)
$ZYNTHIAN_RECIPE_DIR/install_VL53L0X.sh

# Install MCP4748 library (Analog Output / CV-OUT)
$ZYNTHIAN_RECIPE_DIR/install_MCP4728.sh

# Install noVNC web viewer
$ZYNTHIAN_RECIPE_DIR/install_noVNC.sh

# note: 2024-04-10 commented out in original script
# Install terminal emulator for tornado (webconf)
#$ZYNTHIAN_RECIPE_DIR/install_terminado.sh

# zynia 2024-04-10 No rpi overlays
# Install DT overlays for waveshare displays and others
#$ZYNTHIAN_RECIPE_DIR/install_waveshare-dtoverlays.sh

#------------------------------------------------
# Build & Install Synthesis Software
#------------------------------------------------

# zynia 2024-04-10 Use sid rather than bookworm version of zynaddsubfx
# Install ZynAddSubFX => from Bookworm repository instead of KXStudio
#$ZYNTHIAN_RECIPE_DIR/install_zynaddsubfx.sh
apt-get -y install -t sid zynaddsubfx
apt-mark -y hold zynaddsubfx

# Install Fluidsynth & SF2 SondFonts
apt-get -y install fluidsynth
apt-get -y install libfluidsynth-dev
apt-get -y install fluid-soundfont-gm
apt-get -y install fluid-soundfont-gs
apt-get -y install timgm6mb-soundfont
# Stop & disable systemd fluidsynth service
systemctl stop --user fluidsynth.service
systemctl mask --user fluidsynth.service
# Create SF2 soft links
ln -s /usr/share/sounds/sf2/*.sf2 $ZYNTHIAN_DATA_DIR/soundfonts/sf2

# Install Squishbox SF2 soundfonts
$ZYNTHIAN_RECIPE_DIR/install_squishbox_sf2.sh

# note: 2024-04-10 commented out in original script
# Install Polyphone (SF2 editor)
#$ZYNTHIAN_RECIPE_DIR/install_polyphone.sh

# note: 2024-04-10 commented out in original script
# Install Sfizz (SFZ player)
#apt-get -y install sfizz  # repo version segfaults!!!
$ZYNTHIAN_RECIPE_DIR/install_sfizz.sh

# note: 2024-04-10 commented out in original script
# Install Linuxsampler
#$ZYNTHIAN_RECIPE_DIR/install_linuxsampler_stable.sh

# zynia 2024-04-10 No linuxsampler package for riscv found
#apt-get -y install linuxsampler
apt-get -y install  gigtools

# note: 2024-04-10 commented out in original script
# Install Fantasia (linuxsampler Java GUI)
#$ZYNTHIAN_RECIPE_DIR/install_fantasia.sh

# Install setBfree (Hammond B3 Emulator)
$ZYNTHIAN_RECIPE_DIR/install_setbfree.sh

# Setup user config directories
cd $ZYNTHIAN_CONFIG_DIR
mkdir setbfree
ln -s /usr/local/share/setBfree/cfg/default.cfg ./setbfree
cp -a $ZYNTHIAN_DATA_DIR/setbfree/cfg/zynthian_my.cfg ./setbfree/zynthian.cfg

# zynia 2024-04-10 No riscv version of pianoteq
# Install Pianoteq Demo (Piano Physical Emulation)
#$ZYNTHIAN_RECIPE_DIR/install_pianoteq_demo.sh


# note: 2024-04-10 commented out in original script
# Install Aeolus (Pipe Organ Emulator)
#apt-get -y install aeolus

# zynia 2024-04-10 multiple compile errors
#$ZYNTHIAN_RECIPE_DIR/install_aeolus.sh

# Install SooperLooper backend
apt-get -y install sooperlooper

# note: 2024-04-10 commented out in original script
# Install Mididings (MIDI route & filter)
#apt-get -y install mididings
# TODO find a deb repo

# Install Pure Data stuff
apt-get -y install puredata
apt-get -y install puredata-core
apt-get -y install puredata-utils
apt-get -y install puredata-import
apt-get -y install python3-yaml
apt-get -y install pd-lua
apt-get -y install pd-moonlib
apt-get -y install pd-pdstring
apt-get -y install pd-markex
apt-get -y install pd-iemnet
apt-get -y install pd-plugin
apt-get -y install pd-ekext
apt-get -y install pd-bassemu
apt-get -y install pd-readanysf
apt-get -y install pd-pddp
apt-get -y install pd-zexy
apt-get -y install pd-list-abs
apt-get -y install pd-flite
apt-get -y install pd-windowing
apt-get -y install pd-fftease
apt-get -y install pd-bsaylor
apt-get -y install pd-osc
apt-get -y install pd-sigpack
apt-get -y install pd-hcs
apt-get -y install pd-pdogg
apt-get -y install pd-purepd
apt-get -y install pd-beatpipe
apt-get -y install pd-freeverb
apt-get -y install pd-iemlib
apt-get -y install pd-smlib
apt-get -y install pd-hid
apt-get -y install pd-csound
apt-get -y install pd-earplug
apt-get -y install pd-wiimote
apt-get -y install pd-pmpd
apt-get -y install pd-motex
apt-get -y install pd-arraysize
apt-get -y install pd-ggee
apt-get -y install pd-chaos
apt-get -y install pd-iemmatrix
apt-get -y install pd-comport
apt-get -y install pd-libdir
apt-get -y install pd-vbap
apt-get -y install pd-cxc
apt-get -y install pd-lyonpotpourri
apt-get -y install pd-iemambi
apt-get -y install pd-pdp
apt-get -y install pd-mjlib
apt-get -y install pd-cyclone
apt-get -y install pd-jmmmp
apt-get -y install pd-3dp
apt-get -y install pd-boids
apt-get -y install pd-mapping
apt-get -y install pd-maxlib

mkdir /root/Pd
mkdir /root/Pd/externals

#------------------------------------------------
# Install MOD stuff
#------------------------------------------------

# Install MOD-HOST
# Requires libjackd-jackd2-1.9.19 (JackTickDouble), bullseye has 1.9.17
#export MOD_HOST_GITSHA="0d1cb5484f5432cdf7fa297e0bfcc353d8a47e6b"
$ZYNTHIAN_RECIPE_DIR/install_mod-host.sh

# note: 2024-04-10 commented out in original script
# Install browsepy => Now it's installed with mod-ui
# $ZYNTHIAN_RECIPE_DIR/install_mod-browsepy.sh

#Install MOD-UI
$ZYNTHIAN_RECIPE_DIR/install_mod-ui.sh

# note: 2024-04-10 commented out in original script
#Install MOD-SDK
#$ZYNTHIAN_RECIPE_DIR/install_mod-sdk.sh


#------------------------------------------------
# Install Plugins
#------------------------------------------------
cd "$ZYNTHIAN_SYS_DIR/scripts"
./setup_plugins_rbpi.sh

#------------------------------------------------
# Install Ableton Link Support
#------------------------------------------------
# zynia 2024-04-10 Compile Errors
# zynia 2024-04-10 g++: error: unrecognized command-line option ‘-mfpu=neon-fp-armv8’
# zynia 2024-04-10 g++: error: unrecognized command-line option ‘-mneon-for-64bits’
# zynia 2024-04-10 g++: error: unrecognized command-line option ‘-mfloat-abi=hard’
# zynia 2024-04-10 g++: error: unrecognized command-line option ‘-mvectorize-with-neon-quad’
#$ZYNTHIAN_RECIPE_DIR/install_hylia.sh
$ZYNTHIAN_RECIPE_DIR/install_pd_extra_abl_link.sh

#------------------------------------------------
# Final configuration
#------------------------------------------------

# Create flags to avoid running unneeded recipes.update when updating zynthian software
#if [ ! -d "$ZYNTHIAN_CONFIG_DIR/updates" ]; then
#	mkdir "$ZYNTHIAN_CONFIG_DIR/updates"
#fi

# Run configuration script before ending
$ZYNTHIAN_SYS_DIR/scripts/update_zynthian_sys.sh

# Regenerate certificates
$ZYNTHIAN_SYS_DIR/sbin/regenerate_keys.sh

# Regenerate LV2 cache
cd $ZYNTHIAN_UI_DIR/zyngine
python3 ./zynthian_lv2.py

#------------------------------------------------
# End & Cleanup
#------------------------------------------------

# note: 2024-04-10 commented out in original script
#Block MS repo from being installed
#apt-mark hold raspberrypi-sys-mods
#touch /etc/apt/trusted.gpg.d/microsoft.gpg

# Clean
apt-get -y autoremove # Remove unneeded packages
if [[ "$ZYNTHIAN_SETUP_APT_CLEAN" == "yes" ]]; then # Clean apt cache (if instructed via zynthian_envars.sh)
    apt-get clean
fi

#------------------------------------------------


