#!/bin/bash
#zynia Created 2024-09-10

# https://github.com/sjaehn/BShapr.git

cd $ZYNTHIAN_PLUGINS_DIR

if [ -d BShapr ]; then
	rm -rf BShapr
fi

git clone https://github.com/sjaehn/BShapr.git
cd BShapr
make CPPFLAGS+=-O3
make install
cd ..
rm -rf BShapr
