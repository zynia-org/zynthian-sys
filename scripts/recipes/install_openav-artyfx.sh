#!/bin/bash

# openav-artyfx.sh
# zynia 2024-09-11
# artyfx has moved to meson based builds
if 0; then
export CXXFLAGS="$CFLAGS -fpermissive"

cd $ZYNTHIAN_PLUGINS_SRC_DIR
if [ -d "openAV-ArtyFX" ]; then
	rm -rf "openAV-ArtyFX"
fi

git clone https://github.com/openAVproductions/openAV-ArtyFX.git
cd openAV-ArtyFX
sed -i -- 's/ lib\/lv2\// \/zynthian\/zynthian-plugins\/lv2\//' CMakeLists.txt
#cmake -DBUILD_GUI=OFF -DBUILD_SSE=OFF .
cmake -DBUILD_SSE=OFF .
make -j 4
make install
make clean
cd ..

rm -rf "openAV-ArtyFX"
fi


# zynia Meson-based build
# Created 2024-09-10

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
