#!/bin/bash
# zynia 2024-09-17
# Install the for of DrMr from htpps://github.com/FalkTx/drmr
# Previous script pending/install_drmr.sh installed from https://github.com/nicklan/drmr.git

cd $ZYNTHIAN_PLUGINS_DIR

if [ -d fabla ]; then
	rm -rf fabla
fi

git clone https://github.com/openAVproductions/openAV-Fabla fabla
cd fabla
mkdir build
cd build
cmake ..
make
make install

cd ../..
rm -rf fabla



