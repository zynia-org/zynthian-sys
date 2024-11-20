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

apt-get -y install abgate
# zynia 2024-09-09
# replaced by install recipe
# pkg adlplug not available for riscv in kx.studio
#apt-get -y install adlplug
#
apt-get -y install amsynth
# zynia 2024-09-09
# replaced by install recipe
# pkg ams-lv2 not available for riscv in kx.studio
#apt-get -y install ams-lv2
#
# zynia 2024-09-09
# pkg arctican-plugins-lv2 not available for riscv in kx.studio
#apt-get -y install arctican-plugins-lv2
#
# zynia 2024-09-09
# replaced by install recipe
# pkg artyfx not available for riscv in kx.studio
#apt-get -y install artyfx
#
# zynia 2024-09-09
# replaced by install recipe
# pkg bchoppr not available for riscv in kx.studio
#apt-get -y install bchoppr
#
# zynia 2024-09-09
# replaced by install recipe
# pkg beatslash-lv2 not available for riscv in kx.studio
#apt-get -y install beatslash-lv2
#
apt-get -y install blop-lv2

# zynia 2024-09-09
# replaced by install recipe
# pkg bsequencer not available for riscv in kx.studio
#apt-get -y install bsequencer
#
# zynia 2024-09-09
# replaced by install recipe
# pkg bshapr not available for riscv in kx.studio
#apt-get -y install bshapr
#
# zynia 2024-09-09
# replaced by install recipe
# pkg bslizr not available for riscv in kx.studio
#apt-get -y install bslizr
#
# zynia 2024-09-09
# added --fix-missing
apt-get -y --fix-missing install calf-plugins

# zynia 2024-09-09
# replaced by install recipe
# pkg caps-lv2 not available for riscv in kx.studio
#apt-get -y install caps-lv2
#
# zynia 2024-09-09
# replaced by install recipe
# pkg cv-lfo-blender-lv2 not available for riscv in kx.studio
#apt-get -y install cv-lfo-blender-lv2
#
apt-get -y install drumkv1-lv2
# zynia 2024-09-09
# INSTALL PKG FAILED
# pkg distrho-plugin-ports-lv2 not available for riscv in kx.studio
#apt-get -y install distrho-plugin-ports-lv2
#
apt-get -y install dpf-plugins
apt-get -y install dragonfly-reverb
# zynia 2024-09-009
# INSTALL PKG FAILED
# pkg drmr not available for riscv in kx.studio
#apt-get -y install drmr
#
# zynia 2024-09-09
# PART OF DISTRHO-Ports????
# pkg drowaudio-plugins-lv2 not available for riscv in kx.studio
#apt-get -y install drowaudio-plugins-lv2
#
apt-get -y install drumgizmo
# zynia 2024-09-09
# PART OF DISTRHO-Ports????
# pkg easyssp-lv2 not available for riscv in kx.studio
#apt-get -y install easyssp-lv2
#
apt-get -y install eq10q
# zynia 2024-09-09
# replaced by install recipe
# pkg fabla not available for riscv in kx.studio
#apt-get -y install fabla
#

# zynia 2024-09-09
# replaced by install recipe
# pkg g2reverb not available for riscv in kx.studio
#apt-get -y install g2reverb
#
# zynia 2024-09-09
# replaced by install recipe
# pkg geonkick not available for riscv in kx.studio
#apt-get -y install geonkick
#
# zynia 2024-09-09
# replaced by install recipe
# pkg gxplugins not available for riscv in kx.studio
#apt-get -y install gxplugins
#
# zynia 2024-09-09
# replaced by install recipe
# pkg gxvoxtonebender not available for riscv in kx.studio
#apt-get -y install gxvoxtonebender
#
# zynia 2024-09-09
# INSTALL PKG FAILED
# pkg helm not available for riscv in kx.studio
#apt-get -y install helm
#
# zynia 2024-09-09
# replaced by install recipe
# pkg hybridreverb2 not available for riscv in kx.studio
#apt-get -y install hybridreverb2

# zynia 2024-09-09
# replaced by install recipe
# pkg infamous-plugins not available for riscv in kx.studio
#apt-get -y install infamous-plugins
#
apt-get -y install invada-studio-plugins-lv2
# zynia 2024-09-09
# pkg juced-plugins-lv2 not available for riscv in kx.studio
#apt-get -y install juced-plugins-lv2
#
# zynia 2024-09-09
# pkg juce-opl-lv2 not available for riscv in kx.studio
#apt-get -y install juce-opl-lv2
#
# zynia 2024-09-09
# pkg klangfalter-lv2 not available for riscv in kx.studio
#apt-get -y install klangfalter-lv2
#
apt-get -y install lsp-plugins
# zynia 2024-09-09
# pkg lufsmeter-lv2 not available for riscv in kx.studio
#apt-get -y install lufsmeter-lv2
#
# zynia 2024-09-09
# pkg luftikus-lv2 not available for riscv in kx.studio
#apt-get -y install luftikus-lv2
#
apt-get -y install lv2vocoder
# zynia 2024-09-09
# pkg mod-cv-plugins not available for riscv in kx.studio
#apt-get -y install mod-cv-plugins
#
# zynia 2024-09-09
# pkg mod-distortion not available for riscv in kx.studio
#apt-get -y install mod-distortion
#apt-get -y install mod-pitchshifter
# zynia 2024-09-09
# pkg mod-utilities not available for riscv in kx.studio
#apt-get -y install mod-utilities
#
# zynia 2024-09-09
# pkg moony.lv2 not available for riscv in kx.studio
#apt-get -y install moony.lv2
#
# zynia 2024-09-09
# pkg noise-repellent not available for riscv in kx.studio
#apt-get -y install noise-repellent
#
# zynia 2024-09-09
# pkg obxd-lv2 not available for riscv in kx.studio
apt-get -y install obxd-lv2
# zynia 2024-09-09
# pkg oxefmsynth not available for riscv in kx.studio
#apt-get -y install oxefmsynth
#
apt-get -y install padthv1-lv2
# zynia 2024-09-09
# pkg pitcheddelay-lv2 not available for riscv in kx.studio
#apt-get -y install pitcheddelay-lv2
# zynia 2024-09-09
# pkg pizmidi-plugins not available for riscv in kx.studio
#apt-get -y install pizmidi-plugins
#
# zynia 2024-09-09
# pkg regrader not available for riscv in kx.studio
#apt-get -y install regrader
#
apt-get -y install rubberband-lv2
# zynia 2024-09-09
# pkg safe-plugins not available for riscv in kx.studio
#apt-get -y install safe-plugins
#
apt-get -y install samplv1-lv2
# zynia 2024-09-09
# pkg shiro-plugins not available for riscv in kx.studio
#apt-get -y install shiro-plugins
#
apt-get -y install synthv1-lv2
# zynia 2024-09-09
# pkg sorcer not available for riscv in kx.studio
#apt-get -y install sorcer
#
# zynia 2024-09-09
# pkg surge not available for riscv in kx.studio
#apt-get -y install surge
#
# zynia 2024-09-09
# pkg temper-lv2 not available for riscv in kx.studio
#apt-get -y install temper-lv2
#
# zynia 2024-09-09
# pkg tal-plugins-lv2 not available for riscv in kx.studio
#apt-get -y install tal-plugins-lv2
#
# zynia 2024-09-09
# pkg  tap-lv2 not available for riscv in kx.studio
#apt-get -y install tap-lv2
#
# zynia 2024-09-09
# pkg teragonaudio-plugins-lv2 not available for riscv in kx.studio
#apt-get -y install teragonaudio-plugins-lv2
#
# zynia 2024-09-09
# pkg vitalium-lv2 not available for riscv in kx.studio
#apt-get -y install vitalium-lv2
#
# zynia 2024-09-09
# pkg wolf-shaper not available for riscv in kx.studio
#apt-get -y install wolf-shaper
#
# zynia 2024-09-09
# pkg wolf-spectrum not available for riscv in kx.studio
#apt-get -y install wolf-spectrum
#
# zynia 2024-09-09
# pkg wolpertinger-lv2 not available for riscv in kx.studio
#apt-get -y install wolpertinger-lv2
apt-get -y install zam-plugins
# zynia 2024-09-09
# pkg zlfo not available for riscv in kx.studio
#apt-get -y install zlfo
#
# TODO review:
# avw.lv2 riban-lv2 boops

#------------------------------------------------
# Install LV2 Plugins from source code
#------------------------------------------------

# zynia 2024-09-17 new
$ZYNTHIAN_RECIPE_DIR/install_ntk.sh && $ZYNTHIAN_RECIPE_DIR/install_openav-fabla.sh
# zynia 2024-09-17 new
$ZYNTHIAN_RECIPE_DIR/install_g2reverb.sh
# zynia 2024-09-17 new
$ZYNTHIAN_RECIPE_DIR/install_geonkick.sh
# zynia 2024-09-17 new
$ZYNTHIAN_RECIPE_DIR/install_gxvoxtb.sh
# zynia 2024-09-17 new
$ZYNTHIAN_RECIPE_DIR/install_HybridReverb2.sh




#$ZYNTHIAN_RECIPE_DIR/install_fluidsynth.sh
$ZYNTHIAN_RECIPE_DIR/install_fluidplug.sh
#$ZYNTHIAN_RECIPE_DIR/install_mod-setbfree.sh
#$ZYNTHIAN_RECIPE_DIR/install_zynaddsubfx.sh
#$ZYNTHIAN_RECIPE_DIR/install_linuxsampler.sh
# zynia: 2024-09-10 uncommented
$ZYNTHIAN_RECIPE_DIR/install_openav-artyfx.sh
#$ZYNTHIAN_RECIPE_DIR/install_calf.sh
#$ZYNTHIAN_RECIPE_DIR/install_eq10q.sh
#  zynia: 2024-09-10 uncommented
$ZYNTHIAN_RECIPE_DIR/install_ADLplug.sh
#  zynia: 2024-09-10 uncommented
$ZYNTHIAN_RECIPE_DIR/install_ams-lv2.sh
# zynia: 2024-09-10 new
$ZYNTHIAN_RECIPE_DIR/install_bchoppr.sh
# zynia: 2024-09-10 new
$ZYNTHIAN_RECIPE_DIR/install_beatslash-lv2.sh
# zynia: 2024-09-10 new
$ZYNTHIAN_RECIPE_DIR/install_bsequencer.sh
# zynia: 2024-09-10 new
$ZYNTHIAN_RECIPE_DIR/install_bshapr.sh
# zynia: 2024-09-10 new
$ZYNTHIAN_RECIPE_DIR/install_bslizr.sh
# zynia: 2024-09-10 new
$ZYNTHIAN_RECIPE_DIR/install_caps-lv2.sh
# zynia: 2024-09-10 new
$ZYNTHIAN_RECIPE_DIR/install_cv-lfo-blender-lv2.sh



#$ZYNTHIAN_RECIPE_DIR/install_amsynth.sh
$ZYNTHIAN_RECIPE_DIR/install_sooperlooper-lv2-plugin.sh
$ZYNTHIAN_RECIPE_DIR/install_sosynth.sh
$ZYNTHIAN_RECIPE_DIR/install_guitarix.sh
$ZYNTHIAN_RECIPE_DIR/install_gxswitchlesswah.sh
$ZYNTHIAN_RECIPE_DIR/install_gxdenoiser2.sh
$ZYNTHIAN_RECIPE_DIR/install_gxdistortionplus.sh
# zynia 2024-09-17 uncommented
$ZYNTHIAN_RECIPE_DIR/install_gxplugins.sh
#$ZYNTHIAN_RECIPE_DIR/install_gxsupersaturator.sh
#$ZYNTHIAN_RECIPE_DIR/install_helm.sh
# zynia 2024-09-17 uncommented
$ZYNTHIAN_RECIPE_DIR/install_infamous.sh
#$ZYNTHIAN_RECIPE_DIR/install_padthv1.sh
# zynia 2024-09-10 uncomment
$ZYNTHIAN_RECIPE_DIR/install_distrho_ports.sh
#$ZYNTHIAN_RECIPE_DIR/install_dpf_plugins.sh
$ZYNTHIAN_RECIPE_DIR/install_foo-yc20.sh
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
$ZYNTHIAN_RECIPE_DIR/install_mod-arpeggiator.sh
$ZYNTHIAN_RECIPE_DIR/install_stereo-mixer.sh
$ZYNTHIAN_RECIPE_DIR/install_alo.sh
$ZYNTHIAN_RECIPE_DIR/install_VL1.sh
$ZYNTHIAN_RECIPE_DIR/install_qmidiarp.sh
$ZYNTHIAN_RECIPE_DIR/install_mod-cabsim-IR-loader.sh
$ZYNTHIAN_RECIPE_DIR/install_bolliedelay.sh
$ZYNTHIAN_RECIPE_DIR/install_talentedhack.sh
$ZYNTHIAN_RECIPE_DIR/install_mimi.sh
$ZYNTHIAN_RECIPE_DIR/install_avldrums.sh


# We should install only the included presets ...
# $ZYNTHIAN_RECIPE_DIR/install_surge_prebuilt.sh

# X42 plugins
$ZYNTHIAN_RECIPE_DIR/install_x42_plugins.sh

# Zynthian precompiled plugins
######################## THIS MUST BE REBUILD =>
#$ZYNTHIAN_RECIPE_DIR/install_lv2_plugins_prebuilt.sh
#################################################

# Fixup amsynth bank/presets
$ZYNTHIAN_RECIPE_DIR/fixup_amsynth.sh

# Install MOD-UI skins
#$ZYNTHIAN_RECIPE_DIR/postinstall_mod-lv2-data.sh

# Remove VSTs and other plugin format we don't need and take a lot of space
rm -rf /usr/lib/vst
rm -rf /usr/lib/dssi
rm -rf /usr/lib/ladspa
rm -rf /usr/local/lib/vst
rm -rf /usr/local/lib/dssi
rm -rf /usr/local/lib/ladspa
rm -rf /usr/lib/lsp-plugins
rm -f /usr/bin/lsp-*
