#!/bin/bash
#zynia Created 2024-09-10

# https://github.com/sjaehn/BSlizr.git

cd $ZYNTHIAN_PLUGINS_DIR

if [ -d BSlizr ]; then
	rm -rf BSlizr
fi

git clone https://github.com/sjaehn/BSlizr.git
cd BSlizr
make CPPFLAGS+=-O3
make install
cd ..
rm -rf BSlizr

