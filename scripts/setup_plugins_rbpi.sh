#!/bin/bash
#******************************************************************************
# ZYNTHIAN PROJECT: Setup Zynthian Plugins from scratch for RBPi
# 
# Install LV2 Plugin Package / Download, build and install LV2 Plugins
# 
# Copyright (C) 2015-2016 Fernando Moyano <jofemodo@zynthian.org>
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

#------------------------------------------------------------------------------
# Load Environment Variables
#------------------------------------------------------------------------------

source "$ZYNTHIAN_SYS_DIR/scripts/zynthian_envars_extended.sh"
source "$ZYNTHIAN_SYS_DIR/scripts/delayed_action_flags.sh"

#------------------------------------------------
# Create Plugins Source Code Directory
#------------------------------------------------

mkdir $ZYNTHIAN_PLUGINS_SRC_DIR

#------------------------------------------------
# Install LV2 Plugins from repository
#------------------------------------------------

# TODO review:
# surge => Fails from repo. Install our own binary.
# avw.lv2

apt-get -y install abgate amsynth avldrums.lv2
# Errors
#E: Unable to locate package adlplug
#E: Unable to locate package ams-lv2
#E: Unable to locate package arctican-plugins-lv2
#E: Unable to locate package artyfx

apt-get -y install blop-lv2
# Errors
#E: Unable to locate package bchoppr
#E: Unable to locate package beatslash-lv2
#E: Unable to locate package bsequencer
#E: Unable to locate package boops
#E: Unable to locate package bshapr
#E: Unable to locate package bslizr

apt-get -y install calf-plugins
# Errors
#E: Unable to locate package caps-lv2
#E: Unable to locate package cv-lfo-blender-lv2

apt-get -y install drumkv1-lv2 samplv1-lv2 synthv1-lv2 padthv1-lv2

apt-get -y install dpf-plugins dragonfly-reverb
# Errors
#E: Unable to locate package distrho-plugin-ports-lv2
#E: Unable to locate package drmr
#E: Unable to locate package drowaudio-plugins-lv2

apt-get -y install eq10q
# Errors
#E: Unable to locate package easyssp-lv2
#E: Unable to locate package fabla
#E: Unable to locate package g2reverb
#E: Unable to locate package geonkick
#E: Unable to locate package gxplugins
#E: Unable to locate package gxvoxtonebender

apt-get -y install invada-studio-plugins-lv2
# Errors
#E: Unable to locate package helm
#E: Unable to locate package hybridreverb2
#E: Unable to locate package infamous-plugins
#E: Unable to locate package juced-plugins-lv2
#E: Unable to locate package juce-opl-lv2

apt-get -y install lsp-plugins lv2vocoder
# Errors
#E: Unable to locate package klangfalter-lv2
#E: Unable to locate package lufsmeter-lv2
#E: Unable to locate package luftikus-lv2

#apt-get -y install 
# Errrors
#E: Unable to locate package mod-cv-plugins
#E: Unable to locate package mod-distortion
#E: Unable to locate package mod-pitchshifter
#E: Unable to locate package mod-utilities
#E: Unable to locate package moony.lv2
#E: Couldn't find any package by glob 'moony.lv2'
#E: Couldn't find any package by regex 'moony.lv2'

#apt-get -y install
# Errors
#E: Unable to locate package noise-repellent
#E: Unable to locate package obxd-lv2
#E: Unable to locate package oxefmsynth
#E: Unable to locate package pitcheddelay-lv2
#E: Unable to locate package pizmidi-plugins

apt-get -y install rubberband-lv2
# Errors
#E: Unable to locate package regrader
#E: Unable to locate package riban-lv2
#E: Unable to locate package safe-plugins
#E: Unable to locate package shiro-plugins
#E: Unable to locate package sorcer

#apt-get -y install
# Errors
#E: Unable to locate package temper-lv2
#E: Unable to locate package tal-plugins-lv2
#E: Unable to locate package tap-lv2
#E: Unable to locate package teragonaudio-plugins-lv2
#E: Unable to locate package vitalium-lv2

#apt-get -y install 
# Errors
#E: Unable to locate package wolf-shaper
#E: Unable to locate package wolf-spectrum
#E: Unable to locate package wolpertinger-lv2

apt-get -y install x42-plugins zam-plugins
# Errors
#E: Unable to locate package zlfo
#------------------------------------------------
# Install LV2 Plugins from source code
#------------------------------------------------

$ZYNTHIAN_RECIPE_DIR/install_fluidsynth.sh
$ZYNTHIAN_RECIPE_DIR/install_fluidplug.sh
#$ZYNTHIAN_RECIPE_DIR/install_mod-setbfree.sh
#$ZYNTHIAN_RECIPE_DIR/install_zynaddsubfx.sh
#$ZYNTHIAN_RECIPE_DIR/install_linuxsampler.sh
#$ZYNTHIAN_RECIPE_DIR/install_openav-artyfx.sh
#$ZYNTHIAN_RECIPE_DIR/install_calf.sh
#$ZYNTHIAN_RECIPE_DIR/install_eq10q.sh
#$ZYNTHIAN_RECIPE_DIR/install_ADLplug.sh
#$ZYNTHIAN_RECIPE_DIR/install_ams-lv2.sh
#$ZYNTHIAN_RECIPE_DIR/install_amsynth.sh
$ZYNTHIAN_RECIPE_DIR/install_sooperlooper-lv2-plugin.sh
$ZYNTHIAN_RECIPE_DIR/install_sosynth.sh

#$ZYNTHIAN_RECIPE_DIR/install_guitarix.sh
# Error multiple compoile erros

$ZYNTHIAN_RECIPE_DIR/install_gxswitchlesswah.sh
$ZYNTHIAN_RECIPE_DIR/install_gxdenoiser2.sh
$ZYNTHIAN_RECIPE_DIR/install_gxdistortionplus.sh
#$ZYNTHIAN_RECIPE_DIR/install_gxplugins.sh
#$ZYNTHIAN_RECIPE_DIR/install_gxsupersaturator.sh
#$ZYNTHIAN_RECIPE_DIR/install_helm.sh
#$ZYNTHIAN_RECIPE_DIR/install_infamous.sh
#$ZYNTHIAN_RECIPE_DIR/install_padthv1.sh
#$ZYNTHIAN_RECIPE_DIR/install_distrho_ports.sh
#$ZYNTHIAN_RECIPE_DIR/install_dpf_plugins.sh

#$ZYNTHIAN_RECIPE_DIR/install_foo-yc20.sh
# Error: compile fails to complete

$ZYNTHIAN_RECIPE_DIR/install_raffo.sh
$ZYNTHIAN_RECIPE_DIR/install_triceratops.sh
$ZYNTHIAN_RECIPE_DIR/install_swh.sh
#$ZYNTHIAN_RECIPE_DIR/install_shiro.sh
#$ZYNTHIAN_RECIPE_DIR/install_zam.sh
#$ZYNTHIAN_RECIPE_DIR/install_dragonfly.sh
#$ZYNTHIAN_RECIPE_DIR/install_mod-caps.sh
#$ZYNTHIAN_RECIPE_DIR/install_mod-distortion.sh
#$ZYNTHIAN_RECIPE_DIR/install_mod-pitchshifter.sh => DISABLED BECAUSE IT FAILS BUSTER BUILD
#$ZYNTHIAN_RECIPE_DIR/install_mod-utilities.sh
$ZYNTHIAN_RECIPE_DIR/install_mod-tap.sh
$ZYNTHIAN_RECIPE_DIR/install_mod-mda.sh
$ZYNTHIAN_RECIPE_DIR/install_dexed_lv2.sh
$ZYNTHIAN_RECIPE_DIR/install_setBfree-controller.sh
$ZYNTHIAN_RECIPE_DIR/install_string-machine.sh
$ZYNTHIAN_RECIPE_DIR/install_midi_display.sh
$ZYNTHIAN_RECIPE_DIR/install_punk_console.sh
$ZYNTHIAN_RECIPE_DIR/install_reMID.sh
$ZYNTHIAN_RECIPE_DIR/install_miniopl3.sh
$ZYNTHIAN_RECIPE_DIR/install_ykchorus.sh
$ZYNTHIAN_RECIPE_DIR/install_gula.sh
#$ZYNTHIAN_RECIPE_DIR/install_arpeggiator.sh

#$ZYNTHIAN_RECIPE_DIR/install_mod-arpeggiator.sh
# Error cc1plus: error: unknown cpu ‘generic’ for ‘-mtune’

$ZYNTHIAN_RECIPE_DIR/install_stereo-mixer.sh
$ZYNTHIAN_RECIPE_DIR/install_surge_prebuilt.sh
$ZYNTHIAN_RECIPE_DIR/install_alo.sh
$ZYNTHIAN_RECIPE_DIR/install_VL1.sh
$ZYNTHIAN_RECIPE_DIR/install_qmidiarp.sh
$ZYNTHIAN_RECIPE_DIR/install_mod-cabsim-IR-loader.sh
$ZYNTHIAN_RECIPE_DIR/install_bolliedelay.sh
$ZYNTHIAN_RECIPE_DIR/install_talentedhack.sh

# X42 plugins
#$ZYNTHIAN_RECIPE_DIR/install_fat1.sh
#$ZYNTHIAN_RECIPE_DIR/install_darc_lv2.sh
#$ZYNTHIAN_RECIPE_DIR/install_fil4_lv2.sh
#$ZYNTHIAN_RECIPE_DIR/install_meters.sh
#$ZYNTHIAN_RECIPE_DIR/install_x42_testsignal.sh
#$ZYNTHIAN_RECIPE_DIR/install_midifilter.lv2.sh
#$ZYNTHIAN_RECIPE_DIR/install_step-seq.sh
$ZYNTHIAN_RECIPE_DIR/install_mclk.sh

# Zynthian precompiled plugins
$ZYNTHIAN_RECIPE_DIR/install_lv2_plugins_prebuilt.sh
# Error: rpi only?????

# Fixup amsynth bank/presets
#$ZYNTHIAN_RECIPE_DIR/fixup_amsynth.sh
# Error /fixup_amsynth.sh: line 3: cd: /usr/lib/arm-linux-gnueabihf/lv2/amsynth.lv2: No such file or directory1

#$ZYNTHIAN_RECIPE_DIR/postinstall_mod-lv2-data.sh
