#!/bin/bash
# zynia 2024-09-10
# https://github.com/blablack/beatslash-lv2

# 2024-09-10 need to run on Python <3.12 because waf in cloned repo uses
# the imp module which has been removed in Python >=3.12.
#
source $ZYNTHIAN_DIR/venv38/bin/activate

cd $ZYNTHIAN_PLUGINS_DIR

if [ -d beatslash-lv2 ]; then
	rm -rf beatslash-lv2
fi

git clone https://github.com/blablack/beatslash-lv2.git
cd beatslash-lv2

./waf configure
./waf build
./waf install
./waf clean

cd ..
rm -rf beatslash-lv2

deactivate

