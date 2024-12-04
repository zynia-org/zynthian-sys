#!/bin/bash

set -x

source /zynthian/zynia/scripts/zynthian_envars_extended.sh

cd $ZYNTHIAN_PLUGINS_SRC_DIR
if [ -d "dexed.lv2" ]; then
	rm -rf "dexed.lv2"
fi

git clone https://github.com/dcoredump/dexed.lv2
cd dexed.lv2/src
# Replace "lvtk-plugin-2" by "lvtk-1" in Makefile!!
sed -i "s/lvtk-plugin-2/lvtk-1/g" Makefile
make -j 3
make install
cd ../..

#rm -rf "dexed.lv2"
