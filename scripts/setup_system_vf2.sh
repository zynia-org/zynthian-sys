#!/bin/bash
#******************************************************************************
# ZYNTHIAN PROJECT: Zynthian Setup Script
#
# Setup a Zynthian Box in a fresh raspbian-lite "buster" image
#
# Copyright (C) 2015-2019 Fernando Moyano <jofemodo@zynthian.org>
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
# Load Environment Variables
#------------------------------------------------------------------------------

source "zynthian_envars_extended.sh"

#------------------------------------------------
# Set default config
#------------------------------------------------

[ -n "$ZYNTHIAN_INCLUDE_RPI_UPDATE" ] || ZYNTHIAN_INCLUDE_RPI_UPDATE=no
[ -n "$ZYNTHIAN_INCLUDE_PIP" ] || ZYNTHIAN_INCLUDE_PIP=yes
[ -n "$ZYNTHIAN_CHANGE_HOSTNAME" ] || ZYNTHIAN_CHANGE_HOSTNAME=yes

[ -n "$ZYNTHIAN_SYS_REPO" ] || ZYNTHIAN_SYS_REPO="https://github.com/zynthian/zynthian-sys.git"
[ -n "$ZYNTHIAN_UI_REPO" ] || ZYNTHIAN_UI_REPO="https://github.com/zynthian/zynthian-ui.git"
[ -n "$ZYNTHIAN_ZYNCODER_REPO" ] || ZYNTHIAN_ZYNCODER_REPO="https://github.com/zynthian/zyncoder.git"
[ -n "$ZYNTHIAN_WEBCONF_REPO" ] || ZYNTHIAN_WEBCONF_REPO="https://github.com/zynthian/zynthian-webconf.git"
[ -n "$ZYNTHIAN_DATA_REPO" ] || ZYNTHIAN_DATA_REPO="https://github.com/zynthian/zynthian-data.git"
[ -n "$ZYNTHIAN_SYS_BRANCH" ] || ZYNTHIAN_SYS_BRANCH="stable"
[ -n "$ZYNTHIAN_UI_BRANCH" ] || ZYNTHIAN_UI_BRANCH="stable"
[ -n "$ZYNTHIAN_ZYNCODER_BRANCH" ] || ZYNTHIAN_ZYNCODER_BRANCH="stable"
[ -n "$ZYNTHIAN_WEBCONF_BRANCH" ] || ZYNTHIAN_WEBCONF_BRANCH="stable"
[ -n "$ZYNTHIAN_DATA_BRANCH" ] || ZYNTHIAN_DATA_BRANCH="stable"

#------------------------------------------------
# Update System & Firmware
#------------------------------------------------

# Hold kernel version
#apt-mark hold raspberrypi-kernel

# Update System
apt-get -y update
# --allow-releaseinfo-change
# apt-get -y dist-upgrade

# Install required dependencies if needed
apt-get -y install apt-utils apt-transport-https sudo software-properties-common parted dirmngr gpgv htpdate
# rpi-update  rpi-eeprom

# Adjust System Date/Time
htpdate -s www.pool.ntp.org wikipedia.org google.com

# Update Firmware
#if [ "$ZYNTHIAN_INCLUDE_RPI_UPDATE" == "yes" ]; then
#    rpi-update
#fi

#------------------------------------------------
# Add Repositories
#------------------------------------------------

# deb-multimedia repo
#echo "deb http://www.deb-multimedia.org buster main non-free" >> /etc/apt/sources.list
#wget https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb
#dpkg -i deb-multimedia-keyring_2016.8.1_all.deb
#rm -f deb-multimedia-keyring_2016.8.1_all.deb
# 2024-02-20 No riscv64 in deb-multimedia repos


# KXStudio
#wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb
#dpkg -i kxstudio-repos_10.0.3_all.deb
#rm -f kxstudio-repos_10.0.3_all.deb
# 2024-02-24 No rscv64 in KX Studio repos


# Zynthian
wget -O - https://deb.zynthian.org/deb-zynthian-org.gpg > /etc/apt/trusted.gpg.d/deb-zynthian-org.gpg
echo "deb https://deb.zynthian.org/zynthian-stable buster main" > /etc/apt/sources.list.d/zynthian.list

# Sfizz
#sfizz_url_base="http://download.opensuse.org/repositories/home:/sfztools:/sfizz:/develop/Raspbian_10"
#echo "deb $sfizz_url_base/ /" > /etc/apt/sources.list.d/sfizz-dev.list
#curl -fsSL $sfizz_url_base/Release.key | apt-key add -
# Sfizz repos are amd64 only


apt-get -y update
# apt-get -y dist-upgrade
# apt-get -y autoremove

#------------------------------------------------
# Install Required Packages
#------------------------------------------------

# System
apt-get -y remove --purge isc-dhcp-client triggerhappy logrotate dphys-swapfile
apt-get -y install systemd avahi-daemon dhcpcd-dbus usbutils udisks2 udevil exfatprogs
# 2023-07-26 FAIL no such package exfat-utils; replaced by exfatprogs
apt-get -y install xinit xserver-xorg-video-fbdev x11-xserver-utils xinput tigervnc-standalone-server tigervnc-xorg-extension
# 2023-07-26 libgl1-mesa-dri don't update mesa as per visionfive
# 2023-07-26 vnc4server pkg not found; vnc4server is buster only
# 2024-02-20       replaced here by tigervnc-standalone-server and tigervnc-xorg-extension
apt-get -y install xfwm4 xfce4-panel xdotool
# 2023-07-26 Unable to locate package xfwm4-themes - removed from debian in bullseye and later
# 2023-07-26 Package 'cpufrequtils' has no installation candidate

apt-get -y install wpasupplicant wireless-tools iw hostapd dnsmasq
# apt-get -y install firmware-brcm80211 firmware-atheros firmware-realtek atmel-firmware firmware-misc-nonfree
# firmware-ralink
# 2024-20-20 Assume for now all this is hardware dependent



# Alternate XServer with some 2D acceleration
#apt-get -y install xserver-xorg-video-fbturbo
#ln -s /usr/lib/arm-linux-gnueabihf/xorg/modules/drivers/fbturbo_drv.so /usr/lib/xorg/modules/drivers

# CLI Tools
apt-get -y install psmisc tree joe nano vim p7zip-full i2c-tools ddcutil
# 2023-07-26 raspi-config  -- rpi specific
apt-get -y install fbi scrot mpg123 xloadimage imagemagick fbcat abcmidi mplayer
#2023-07-26 mplayer
#The following packages have unmet dependencies:
# mplayer : Depends: libavcodec58 (>= 7:4.4) but it is not installable
#           Depends: libavformat58 (>= 7:4.4) but it is not installable
#           Depends: libavutil56 (>= 7:4.4) but it is not installable
#           Depends: libpostproc55 (>= 7:4.4) but it is not installable
#           Depends: libswresample3 (>= 7:4.4) but it is not installable
#           Depends: libswscale5 (>= 7:4.4) but it is not installable
#2024-02-20 mplayer for riscv64 now in sid putting back in
apt-get -y install evtest libts-bin python3-smbus # touchscreen tools

# Lguyome45: remove for Raspberry pi 4, with this firmware, wifi does not work
# Non-free WIFI firmware for RBPi3
#wget https://archive.raspberrypi.org/debian/pool/main/f/firmware-nonfree/firmware-brcm80211_20161130-3+rpt3_all.deb
#dpkg -i firmware-brcm80211_20161130-3+rpt3_all.deb
#rm -f firmware-brcm80211_20161130-3+rpt3_all.deb

#------------------------------------------------
# Development Environment
#------------------------------------------------

#Tools
apt-get -y --no-install-recommends install build-essential git swig subversion pkg-config autoconf automake \
gettext intltool libtool libtool-bin cmake cmake-curses-gui flex bison ngrep qt5-qmake gobjc++ \
ruby rake xsltproc vorbis-tools zenity doxygen graphviz glslang-tools rubberband-cli premake
# 2023-07-26  premake qt4-qmake qt5-default
# E: Unable to locate package premake
# E: Unable to locate package qt4-qmake - buster only
# E: Package 'qt5-default' has no installation candidate - buster only
# 2024-02-20 Added premake back in as its in sid for riscv64


# AV Libraries => WARNING It should be changed on every new debian version!!
apt-get -y --no-install-recommends install libavformat-dev \
libavcodec-dev \
libavcodec60 \
libavformat60 \
libavutil58 \
libswresample4
# 2023-07-26 libavcodec58 libavformat58 libavutil56 libavresample4
#E: Package 'libavcodec58' has no installation candidate - updated to ...60 for sid
#E: Package 'libavformat58' has no installation candidate - updated to ...60 for sid
#E: Package 'libavutil56' has no installation candidate - updated to ...58 for sid
#E: Unable to locate package libavresample4 - replaced by libswresample4 in bookworm and beyond

# Libraries
apt-get -y --no-install-recommends install libfftw3-dev libmxml-dev zlib1g-dev fluid libfltk1.3-dev \
libfltk1.3-compat-headers libncurses5-dev liblo-dev dssi-dev libjpeg-dev libxpm-dev libcairo2-dev libglu1-mesa-dev \
libasound2-dev dbus-x11 jackd2 libjack-jackd2-dev libffi-dev \
fontconfig-config libfontconfig1-dev libxft-dev libexpat-dev libglib2.0-dev libgettextpo-dev libsqlite3-dev \
libglibmm-2.4-dev libeigen3-dev libsndfile-dev libsamplerate-dev libarmadillo-dev libreadline-dev \
lv2-c++-tools libxi-dev libgtk2.0-dev libgtkmm-2.4-dev liblrdf-dev libboost-system-dev libzita-convolver-dev \
libzita-resampler-dev fonts-roboto libxcursor-dev libxinerama-dev mesa-common-dev libgl1-mesa-dev \
libfreetype6-dev  libswscale-dev qtbase5-dev qtdeclarative5-dev libcanberra-gtk-module \
libcanberra-gtk3-module libxcb-cursor-dev libgtk-3-dev libxcb-util0-dev libxcb-keysyms1-dev libxcb-xkb-dev \
libxkbcommon-x11-dev libssl-dev libmpg123-0 libmp3lame0 libqt5svg5-dev \
a2jmidid
# 2023-07-26 a2jmidid laditools liblash-compat-dev libqt4-dev
#E: Package 'a2jmidid' has no installation candidate - now available in sid
#E: Package 'laditools' has no installation candidate - python2; removed after buster
#E: Unable to locate package liblash-compat-dev - buster only no longer supported
#E: Unable to locate package libqt4-dev - buster only

#libjack-dev-session
#non-ntk-dev
#libgd2-xpm-dev

# Python
#apt-get -y install python python-dev cython python-dbus python-setuptools
# cython python-dbus python-setuptools
# 2023-07-23 
#E: Package 'python' has no installation candidate
#E: Package 'python-dev' has no installation candidate
#E: Package 'cython' has no installation candidate
#E: Package 'python-dbus' has no installation candidate
#E: Package 'python-setuptools' has no installation candidate
# 2023-08-09 Update to python2.7 instead of just python
# apt-get -y install python2.7 python2.7-dev
# Ooops Python2.7 is not available in bookworm and beyond
#E: Unable to locate package python2.7-dbus
#E: Couldn't find any package by glob 'python2.7-dbus'
#E: Unable to locate package python2.7-setuptools
#E: Couldn't find any package by glob 'python2.7-setuptools'


apt-get -y install python3 python3-dev cython3 python3-cffi python3-tk python3-dbus python3-mpmath python3-pil \
python3-pil.imagetk python3-setuptools python3-numpy-dev python3-evdev 2to3 python3-soundfile librubberband-dev
# 2023-07-26  python3-pyqt4
# E: Package 'python3-pyqt4' has no installation candidate - no qt4 support beyond buster

if [ "$ZYNTHIAN_INCLUDE_PIP" == "yes" ]; then
    apt-get -y install  python3-pip
fi
# 2023-08-09 Can't find python-pip, python2.7-pip or python2-pip

pip3 install tornado==4.1 tornadostreamform websocket-client
pip3 install jsonpickle oyaml psutil pexpect requests meson ninja JACK-Client
pip3 install mido python-rtmidi==python1.4.9 ffmpeg-python
# rpi_ws281x
# 2023-08-09 patchage
#ERROR: Could not find a version that satisfies the requirement patchage (from versions: none)
#ERROR: No matching distribution found for patchage

pip3 install abletonparsing pyrubberband sox
python3 -m pip install mutagen

#************************************************
#------------------------------------------------
# Create Zynthian Directory Tree & 
# Install Zynthian Software from repositories
#------------------------------------------------
#************************************************

# Create needed directories



mkdir "$ZYNTHIAN_DIR"
mkdir "$ZYNTHIAN_CONFIG_DIR"
mkdir "$ZYNTHIAN_SW_DIR"

# Zynthian System Scripts and Config files
cd $ZYNTHIAN_DIR
git clone -b "${ZYNTHIAN_SYS_BRANCH}" "${ZYNTHIAN_SYS_REPO}"

# Install WiringPi
#$ZYNTHIAN_RECIPE_DIR/install_wiringpi.sh
# 2023-08-09 RPi related?  But compiles OK
# 2024-02-20 Commented out install of wiring pi

# Zyncoder library
cd $ZYNTHIAN_DIR
git clone -b "${ZYNTHIAN_ZYNCODER_BRANCH}" "${ZYNTHIAN_ZYNCODER_REPO}"
./zyncoder/build.sh



# Zynthian UI
cd $ZYNTHIAN_DIR
git clone -b "${ZYNTHIAN_UI_BRANCH}" "${ZYNTHIAN_UI_REPO}"
cd $ZYNTHIAN_UI_DIR
if [ -d "zynlibs" ]; then
	find ./zynlibs -type f -name build.sh -exec {} \;
else
	if [ -d "jackpeak" ]; then
		./jackpeak/build.sh
	fi
	if [ -d "zynseq" ]; then
		./zynseq/build.sh
	fi
fi

# Zynthian Data
cd $ZYNTHIAN_DIR
git clone -b "${ZYNTHIAN_DATA_BRANCH}" "${ZYNTHIAN_DATA_REPO}"


# Zynthian Webconf Tool
cd $ZYNTHIAN_DIR
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

#************************************************
#------------------------------------------------
# System Adjustments
#------------------------------------------------
#************************************************

#Change Hostname
if [ "$ZYNTHIAN_CHANGE_HOSTNAME" == "yes" ]; then
    echo "zynthian" > /etc/hostname
    sed -i -e "s/127\.0\.1\.1.*$/127.0.1.1\tzynthian/" /etc/hosts
fi

# Run configuration script
$ZYNTHIAN_SYS_DIR/scripts/update_zynthian_data.sh
$ZYNTHIAN_SYS_DIR/scripts/update_zynthian_sys.sh

# Configure Systemd Services
systemctl daemon-reload
systemctl enable dhcpcd
systemctl enable avahi-daemon
systemctl enable devmon@root
# systemctl disable raspi-config
# Not present on VF2
systemctl disable cron
# systemctl disable rsyslog
# Error: Unit file rsyslog.service does not exist
# systemctl disable ntp
# Error: Unit file ntp.service does not exist
# systemctl disable htpdate
# Error: Unit file htpdate.service does not exist
systemctl disable wpa_supplicant
# systemctl disable hostapd
# Error: Unit file hostapd.service does not exist
#systemctl disable dnsmasq
# Error: Unit file dnsmasq.service does npot exist
systemctl disable unattended-upgrades
systemctl disable apt-daily.timer
systemctl mask packagekit
systemctl mask polkit
systemctl disable serial-getty@ttyAMA0.service
#systemctl disable sys-devices-platform-soc-3f201000.uart-tty-ttyAMA0.device
# Error: Failed to disable unit: Unit file sys-devices-platform-soc-3f201000.uart-tty-ttyAMA0.device does not exist.
systemctl enable backlight
systemctl enable cpu-performance
systemctl enable splash-screen
systemctl enable wifi-setup
systemctl enable jack2
systemctl enable mod-ttymidi
systemctl enable a2jmidid

systemctl enable zynthian
systemctl enable zynthian-webconf
systemctl enable zynthian-config-on-boot

# Setup loading of Zynthian Environment variables ...
echo "source $ZYNTHIAN_SYS_DIR/scripts/zynthian_envars_extended.sh" >> /root/.bashrc
# => Shell & Login Config
echo "source $ZYNTHIAN_SYS_DIR/etc/profile.zynthian" >> /root/.profile



# On first boot, resize SD partition, regenerate keys, etc.
#$ZYNTHIAN_SYS_DIR/scripts/set_first_boot.sh
# 2024-02-20 Not sure why this is here 

#************************************************
#------------------------------------------------
# Compile / Install Required Libraries
#------------------------------------------------
#************************************************

# Install some extra packages:
apt-get -y install jack-midi-clock midisport-firmware
# ERROR midisport-firmware package not found
# 2024-02-20 midisport-firmware should be in repos for all releases adding back in

# Install Jack2
$ZYNTHIAN_RECIPE_DIR/install_jack2.sh

# Install alsaseq Python Library
#$ZYNTHIAN_RECIPE_DIR/install_alsaseq.sh

# Install NTK library
# $ZYNTHIAN_RECIPE_DIR/install_ntk.sh
# ERROR: cannot find fltk git repo.  When fltk github repo used instead, then build fails cause can't find ./waf

# Install pyliblo library (liblo OSC library for Python)
$ZYNTHIAN_RECIPE_DIR/install_pyliblo.sh

# Install mod-ttymidi (MOD's ttymidi version with jackd MIDI support)
#$ZYNTHIAN_RECIPE_DIR/install_mod-ttymidi.sh
# 2024-20-02 commenting out since lots of issues a boot time that look like caused by this


# Install LV2 lilv library
$ZYNTHIAN_RECIPE_DIR/install_lv2_lilv.sh
# Warning: need to install Meson and Ninja in root for this to work

# Install the LV2 C++ Tool Kit
$ZYNTHIAN_RECIPE_DIR/install_lvtk.sh

# Install LV2 Jalv Plugin Host
$ZYNTHIAN_RECIPE_DIR/install_lv2_jalv.sh

# Install Aubio Library & Tools
$ZYNTHIAN_RECIPE_DIR/install_aubio.sh

# Install jpmidi (MID player for jack with transport sync)
#$ZYNTHIAN_RECIPE_DIR/install_jpmidi.sh
# Error: cannot link due to not finding right libraries

# Install jack_capture (jackd audio recorder)
$ZYNTHIAN_RECIPE_DIR/install_jack_capture.sh

# Install jack_smf utils (jackd MID-file player/recorder)
$ZYNTHIAN_RECIPE_DIR/install_jack-smf-utils.sh

# Install touchosc2midi (TouchOSC Bridge)
#$ZYNTHIAN_RECIPE_DIR/install_touchosc2midi.sh
# ERROR failed - lots of python/pip errors

# Install jackclient (jack-client python library)
$ZYNTHIAN_RECIPE_DIR/install_jackclient-python.sh

# Install QMidiNet (MIDI over IP Multicast)
$ZYNTHIAN_RECIPE_DIR/install_qmidinet.sh

# Install jackrtpmidid (jack RTP-MIDI daemon)
$ZYNTHIAN_RECIPE_DIR/install_jackrtpmidid.sh

# Install the DX7 SysEx parser
$ZYNTHIAN_RECIPE_DIR/install_dxsyx.sh

# Install preset2lv2 (Convert native presets to LV2)
$ZYNTHIAN_RECIPE_DIR/install_preset2lv2.sh

# Install QJackCtl
$ZYNTHIAN_RECIPE_DIR/install_qjackctl.sh

# Install the njconnect Jack Graph Manager
$ZYNTHIAN_RECIPE_DIR/install_njconnect.sh

# Install Mutagen (when available, use pip3 install)
$ZYNTHIAN_RECIPE_DIR/install_mutagen.sh

# Install VL53L0X library (Distance Sensor)
$ZYNTHIAN_RECIPE_DIR/install_VL53L0X.sh

# Install MCP4748 library (Analog Output / CV-OUT)
$ZYNTHIAN_RECIPE_DIR/install_MCP4728.sh

# Install noVNC web viewer
$ZYNTHIAN_RECIPE_DIR/install_noVNC.sh

# Install terminal emulator for tornado (webconf)
$ZYNTHIAN_RECIPE_DIR/install_terminado.sh

# Install DT overlays for waveshare displ[Aays and others
#$ZYNTHIAN_RECIPE_DIR/install_waveshare-dtoverlays.sh
# 2024-02-20 No DT OVERLAYS for vf2


#************************************************
#------------------------------------------------
# Compile / Install Synthesis Software
#------------------------------------------------
#************************************************

# Install ZynAddSubFX
#$ZYNTHIAN_RECIPE_DIR/install_zynaddsubfx.sh
apt-get -y install zynaddsubfx

# Install Fluidsynth & SF2 SondFonts
apt-get -y install fluidsynth libfluidsynth-dev fluid-soundfont-gm fluid-soundfont-gs timgm6mb-soundfont
# Create SF2 soft links
ln -s /usr/share/sounds/sf2/*.sf2 $ZYNTHIAN_DATA_DIR/soundfonts/sf2

# Install Squishbox SF2 soundfonts
$ZYNTHIAN_RECIPE_DIR/install_squishbox_sf2.sh

# Install Polyphone (SF2 editor)
#$ZYNTHIAN_RECIPE_DIR/install_polyphone.sh

# Install Sfizz (SFZ player)
#$ZYNTHIAN_RECIPE_DIR/install_sfizz.sh
# apt-get -y install sfizz
#Error sfizz not found

# Install Linuxsampler
#$ZYNTHIAN_RECIPE_DIR/install_linuxsampler_stable.sh
apt-get -y install gigtools
#apt-get -y install linuxsampler
# Error linuxsample not found

# Install Fantasia (linuxsampler Java GUI)
$ZYNTHIAN_RECIPE_DIR/install_fantasia.sh

# Install setBfree (Hammond B3 Emulator)
$ZYNTHIAN_RECIPE_DIR/install_setbfree.sh

# Setup user config directories
cd $ZYNTHIAN_CONFIG_DIR
mkdir setbfree
ln -s /usr/local/share/setBfree/cfg/default.cfg ./setbfree
cp -a $ZYNTHIAN_DATA_DIR/setbfree/cfg/zynthian_my.cfg ./setbfree/zynthian.cfg

# Install Pianoteq Demo (Piano Physical Emulation)
$ZYNTHIAN_RECIPE_DIR/install_pianoteq_demo.sh

# Install Aeolus (Pipe Organ Emulator)
#apt-get -y install aeolus
#$ZYNTHIAN_RECIPE_DIR/install_aeolus.sh
# Error: multiple compile errors

# Install Mididings (MIDI route & filter)
#apt-get -y install mididings
# Error: mididings is Python2 only and hence dropped from Debian/Ubuntu

# Install Pure Data stuff
apt-get -y install puredata puredata-core puredata-utils python3-yaml \
pd-lua pd-moonlib pd-pdstring pd-markex pd-iemnet pd-plugin pd-ekext pd-import pd-bassemu pd-readanysf pd-pddp \
pd-zexy pd-list-abs pd-flite pd-windowing pd-fftease pd-bsaylor pd-osc pd-sigpack pd-hcs pd-pdogg pd-purepd \
pd-beatpipe pd-freeverb pd-iemlib pd-smlib pd-hid pd-csound pd-earplug pd-wiimote pd-pmpd pd-motex \
pd-arraysize pd-ggee pd-chaos pd-iemmatrix pd-comport pd-libdir pd-vbap pd-cxc pd-lyonpotpourri pd-iemambi \
pd-pdp pd-mjlib pd-cyclone pd-jmmmp pd-3dp pd-boids pd-mapping pd-maxlib
# Error pd-aubio package no longer in debian

mkdir /root/Pd
mkdir /root/Pd/externals

#------------------------------------------------
# Install MOD stuff
#------------------------------------------------

#Install MOD-HOST
$ZYNTHIAN_RECIPE_DIR/install_mod-host.sh

# Install browsepy
$ZYNTHIAN_RECIPE_DIR/install_mod-browsepy.sh

#Install MOD-UI
#$ZYNTHIAN_RECIPE_DIR/install_mod-ui.sh
# Error multiple python install errors

#Install MOD-SDK
#$ZYNTHIAN_RECIPE_DIR/install_mod-sdk.sh

#------------------------------------------------
# Install Plugins
#------------------------------------------------
cd $ZYNTHIAN_SYS_DIR/scripts
./setup_plugins_rbpi.sh

#------------------------------------------------
# Install Ableton Link Support
#------------------------------------------------
#$ZYNTHIAN_RECIPE_DIR/install_hylia.sh
# ERROR: compile errors
#g++: error: unrecognized command-line option ‘-mfpu=neon-fp-armv8’
#g++: error: unrecognized command-line option ‘-mneon-for-64bits’
#g++: error: unrecognized command-line option ‘-mfloat-abi=hard’
#g++: error: unrecognized command-line option ‘-mvectorize-with-neon-quad’

$ZYNTHIAN_RECIPE_DIR/install_pd_extra_abl_link.sh

#************************************************
#------------------------------------------------
# Final Configuration
#------------------------------------------------
#************************************************

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Here

# Create flags to avoid running unneeded recipes.update when updating zynthian software
if [ ! -d "$ZYNTHIAN_CONFIG_DIR/updates" ]; then
	mkdir "$ZYNTHIAN_CONFIG_DIR/updates"
fi

# Run configuration script before ending
$ZYNTHIAN_SYS_DIR/scripts/update_zynthian_sys.sh

#************************************************
#------------------------------------------------
# End & Clean
#------------------------------------------------
#************************************************

#Block MS repo from being installed
apt-mark hold raspberrypi-sys-mods
touch /etc/apt/trusted.gpg.d/microsoft.gpg

# Clean
apt-get -y autoremove # Remove unneeded packages
if [[ "$ZYNTHIAN_SETUP_APT_CLEAN" == "yes" ]]; then # Clean apt cache (if instructed via zynthian_envars.sh)
    apt-get clean
fi
