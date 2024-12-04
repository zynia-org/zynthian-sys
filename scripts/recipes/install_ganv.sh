#!/bin/bash

# ganv
cd $ZYNTHIAN_SW_DIR

if [ -d "ganv" ]; then
	rm -rf "ganv"
fi

git clone https://github.com/drobilla/ganv.git
cd ganv
meson setup build
cd build
meson compile -j 3
meson install

cd ../..
rm -rf "ganv"
