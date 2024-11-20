#!/bin/bash
#zynia Created 2024-09-10

# OpenAV - Artyfx
cd $ZYNTHIAN_PLUGINS_DIR

if [ -d artyfx ]; then
	rm -rf artyfx
fi

git clone https://github.com/openAVproductions/openAV-ArtyFX.git artyfx
cd artyfx

meson build
cd build
ninja
ninja install

cd ..
rm -rf artyfx
