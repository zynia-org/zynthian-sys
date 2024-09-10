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
apt-get -y install adlplug
apt-get -y install amsynth
apt-get -y install ams-lv2
apt-get -y install arctican-plugins-lv2
apt-get -y install artyfx
apt-get -y install bchoppr
apt-get -y install beatslash-lv2
apt-get -y install blop-lv2
apt-get -y install bsequencer
apt-get -y install bshapr
apt-get -y install bslizr
apt-get -y install calf-plugins
apt-get -y install caps-lv2
apt-get -y install cv-lfo-blender-lv2
apt-get -y install drumkv1-lv2
apt-get -y install distrho-plugin-ports-lv2
apt-get -y install dpf-plugins
apt-get -y install dragonfly-reverb
apt-get -y install drmr
apt-get -y install drowaudio-plugins-lv2 drumgizmo
apt-get -y install easyssp-lv2
apt-get -y install eq10q
apt-get -y install fabla
apt-get -y install g2reverb
apt-get -y install geonkick
apt-get -y install gxplugins
apt-get -y install gxvoxtonebender
apt-get -y install helm
apt-get -y install hybridreverb2
apt-get -y install infamous-plugins
apt-get -y install invada-studio-plugins-lv2
apt-get -y install juced-plugins-lv2
apt-get -y install juce-opl-lv2
apt-get -y install klangfalter-lv2
apt-get -y install lsp-plugins
apt-get -y install lufsmeter-lv2
apt-get -y install luftikus-lv2
apt-get -y install lv2vocoder
apt-get -y install mod-cv-plugins
apt-get -y install mod-distortion
apt-get -y install mod-pitchshifter
apt-get -y install mod-utilities
apt-get -y install moony.lv2
apt-get -y install noise-repellent
apt-get -y install obxd-lv2
apt-get -y install oxefmsynth
apt-get -y install padthv1-lv2
apt-get -y install pitcheddelay-lv2
apt-get -y install pizmidi-plugins
apt-get -y install regrader
apt-get -y install rubberband-lv2
apt-get -y install safe-plugins
apt-get -y install samplv1-lv2
apt-get -y install shiro-plugins
apt-get -y install synthv1-lv2
apt-get -y install sorcer
apt-get -y install surge
apt-get -y install temper-lv2
apt-get -y install tal-plugins-lv2
apt-get -y install tap-lv2
apt-get -y install teragonaudio-plugins-lv2
apt-get -y install vitalium-lv2
apt-get -y install wolf-shaper
apt-get -y install wolf-spectrum
apt-get -y install wolpertinger-lv2
apt-get -y install zam-plugins
apt-get -y install zlfo

# TODO review:
# avw.lv2 riban-lv2 boops

#------------------------------------------------
# Install LV2 Plugins from source code
#------------------------------------------------

#$ZYNTHIAN_RECIPE_DIR/install_fluidsynth.sh
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
$ZYNTHIAN_RECIPE_DIR/install_guitarix.sh
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
