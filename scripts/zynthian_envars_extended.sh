#!/bin/bash
#******************************************************************************
# ZYNTHIAN PROJECT: Zynthian System Configuration
# 
# Set extended environment for configuration scripts
#
# Copyright (C) 2015-2022 Fernando Moyano <jofemodo@zynthian.org>
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
# ****************************************************************************
#set -x
#------------------------------------------------------------------------------
# Load Standard Environment Variables
#------------------------------------------------------------------------------

if [ -z "$ZYNTHIAN_CONFIG_DIR" ]; then
	export ZYNTHIAN_CONFIG_DIR="/zynthian/config"
	export ZYNTHIAN_SYS_DIR="/zynthian/zynthian-sys"
fi

if [ -f "$ZYNTHIAN_CONFIG_DIR/zynthian_envars.sh" ]; then
	source "$ZYNTHIAN_CONFIG_DIR/zynthian_envars.sh"
elif [ -f "$ZYNTHIAN_SYS_DIR/scripts/zynthian_envars.sh" ]; then
	source "$ZYNTHIAN_SYS_DIR/scripts/zynthian_envars.sh"
elif [ -f "zynthian_envars.sh" ]; then
	source "zynthian_envars.sh"
else
	echo "ERROR: Can't load zynthian configuration! => zynthian_envars.sh"
fi

#------------------------------------------------------------------------------
# Load Extended Environment Variables
#------------------------------------------------------------------------------

if [ -z "$ZYNTHIAN_EXTENDED_ENVARS_DEFINED" ]; then

export ZYNTHIAN_EXTENDED_ENVARS_DEFINED=1

#------------------------------------------------------------------------------
# Set system info envars
#------------------------------------------------------------------------------

export LINUX_OS_VERSION=$(lsb_release -cs)
export LINUX_KERNEL_VERSION=$(uname -r)
export ZYNTHIAN_OS_VERSION=$(cat /etc/zynthianos_version)
if [ -z "${ZYNTHIAN_OS_VERSION}" ]; then export ZYNTHIAN_OS_VERSION="2306"; fi
if [ -z "$VIRTUALIZATION" ]; then
	export VIRTUALIZATION=$(systemd-detect-virt)
fi

echo ""
echo "----------------------------------------------"
echo "Linux Version: $LINUX_OS_VERSION"
echo "Kernel Version: $LINUX_KERNEL_VERSION"
echo "ZynthianOS Version: $ZYNTHIAN_OS_VERSION"
echo "Virtualization: $VIRTUALIZATION"

#------------------------------------------------------------------------------
# Build framework envars
#------------------------------------------------------------------------------

if [ -z "$RASPI" ]; then

	# Hardware Architecture & Optimization Options
	if [ "$ZYNTHIAN_FORCE_RBPI_VERSION" ]; then
		hw_architecture="armv7l"
		rbpi_version=$ZYNTHIAN_FORCE_RBPI_VERSION
	else
		hw_architecture=`uname -m 2>/dev/null`
		if [ -e "/sys/firmware/devicetree/base/model" ]; then
			rbpi_version=`tr -d '\0' < /sys/firmware/devicetree/base/model`
		else
			rbpi_version=""
		fi
	fi

	if [ "$hw_architecture" = "armv7l" ]; then
		# default is: RPi3
		CPU="-mcpu=cortex-a53 -mtune=cortex-a53"
		FPU="-mfpu=neon-fp-armv8 -mneon-for-64bits"
		if [[ "$rbpi_version" =~ [2] ]]; then
			CPU="-mcpu=cortex-a7 -mtune=cortex-a7"
			FPU="-mfpu=neon-vfpv4"
		fi
		#CPU="${CPU} -Ofast" #Breaks mod-ttymidi build
		FPU="${FPU} -mfloat-abi=hard -mlittle-endian -munaligned-access -mvectorize-with-neon-quad -ftree-vectorize"
		CFLAGS_UNSAFE="-funsafe-loop-optimizations -funsafe-math-optimizations -ffast-math"
	fi
	export MACHINE_HW_NAME=$hw_architecture
	export RBPI_VERSION=$rbpi_version
	export CFLAGS="${CPU} ${FPU}"
	export CXXFLAGS=${CFLAGS}
	export CFLAGS_UNSAFE=""
	export RASPI="true"

	echo "Hardware Architecture: ${hw_architecture}"
	echo "Hardware Model: ${rbpi_version}"

fi

#------------------------------------------------------------------------------
# Apt Options
#------------------------------------------------------------------------------

export DEBIAN_FRONTEND="noninteractive"
export ZYNTHIAN_SETUP_APT_CLEAN="TRUE" # Set TRUE to clean /var/cache/apt during build, FALSE to leave alone

#------------------------------------------------------------------------------

echo "----------------------------------------------"
echo ""

fi
