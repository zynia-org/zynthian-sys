#!/bin/bash
#zynia Created 2024-09-10

# https://github.com/BramGiesen/cv-lfo-blender-lv2.git

cd $ZYNTHIAN_PLUGINS_DIR

if [ -d cv-lfo-blender-lv2 ]; then
	rm -rf cv-lfo-blender-lv2
fi

git clone --recurse-submodules https://github.com/BramGiesen/cv-lfo-blender-lv2.git
cd cv-lfo-blender-lv2
make
make install
cd ..
rm -rf cv-lfo-blender-lv2

