#!/bin/bash
#zynia Created 2024-09-10

# BSEQuencer
cd $ZYNTHIAN_PLUGINS_DIR

if [ -d BSEQuencer ]; then
	rm -rf BSEQuencer
fi

git clone https://github.com/sjaehn/BSEQuencer.git
cd BSEQuencer
make
make install
cd ..
rm -rf BSEQuencer


