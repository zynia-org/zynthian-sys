#!/bin/bash
# zynia 2024-09-17
# Install the lv2 plugin for the ge-onkick drum synthesizer

apt-get install -y libjack-dev
apt-get install -y rapidjson-dev
apt-get install -y lv2-dev
apt-get install -y libcairo2-dev

cd $ZYNTHIAN_PLUGINS_DIR

if [ -d geonkick ]; then
	rm -rf geonkick
fi

git clone https://github.com/Geonkick-Synthesizer/geonkick.git

cd geonkick
mkdir build
cd build
cmake ..
make
make install

cd ../..
rm -rf geonkick
