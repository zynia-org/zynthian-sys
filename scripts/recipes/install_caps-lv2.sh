#!/bin/bash
#zynia Created 2024-09-10

# https://github.com/moddevices/caps-lv2.git

cd $ZYNTHIAN_PLUGINS_DIR

if [ -d caps-lv2 ]; then
	rm -rf caps-lv2
fi

git clone https://github.com/moddevices/caps-lv2.git
cd caps-lv2
make CPPFLAGS+=-O3
make install
cd ..
rm -rf caps-lv2


