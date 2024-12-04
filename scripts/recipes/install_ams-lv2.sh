#!/bin/bash


# 2024-09-10 need to run on Python <3.12 because waf in cloned repo uses
# the imp module which has been removed in Python >=3.12.
#
if [ $(python3 -c 'import sys; print(sys.version_info.minor)') > 8 ]; then
    source $ZYNTHIAN_DIR/venv38/bin/activate
fi

# LV2 port of Alsa Modular Synth
cd $ZYNTHIAN_PLUGINS_DIR

if [ -d ams-lv2 ]; then
	rm -rf ams-lv2
fi
git clone --recursive https://github.com/moddevices/ams-lv2.git
cd ams-lv2
./waf configure
./waf build
./waf install
./waf clean

# zynia 2024-09-10 Huh?
#if [ -e "$ZYNTHIAN_PLUGINS_DIR/lv2/mod-ams.lv2" ]; then
#	rm -rf "$ZYNTHIAN_PLUGINS_DIR/lv2/mod-ams.lv2"
#fi
# zynia 2024-09-10 instead
rm -rf ams-lv2

deactivate

