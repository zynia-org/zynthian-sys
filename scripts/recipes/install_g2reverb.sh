#!/bin/bash
# zynia Created 2024-09-17
# build g2reverb LV2 plugin

cd $ZYNTHIAN_PLUGINS_DIR

if [ -d g2reverb ]; then
	rm -rf g2reverb
fi

wget https://kokkinizita.linuxaudio.org/linuxaudio/downloads/g2reverb-0.7.1.tar.bz2
tar xjf g2reverb-0.7.1.tar.bz2
cd g2reverb-0.7.1
make
make install
cd ..
rm g2reverb-0.7.1.tar.bz2
rm -rf g2reverb-0.7.1



