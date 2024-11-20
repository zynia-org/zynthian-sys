#!/bin/bash
#zynia Created 2024-09-10

# B.Choppr
cd $ZYNTHIAN_PLUGINS_DIR

if [ -d BChoppr ]; then
	rm -rf BChoppr
fi


git clone --recurse-submodules https://github.com/sjaehn/BChoppr
cd BChoppr
make
make install
cd ..
rm -rf BChoppr
