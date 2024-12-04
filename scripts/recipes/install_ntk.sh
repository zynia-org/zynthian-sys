#!/bin/bash

# 2024-09-10 need to run on Python <3.12 because waf in cloned repo uses
# the imp module which has been removed in Python >=3.12.
#
if [ $(python3 -c 'import sys; print(sys.version_info.minor)') > 8 ]; then
    source $ZYNTHIAN_DIR/venv38/bin/activate
fi

cd $ZYNTHIAN_SW_DIR
if [ -d "ntk" ]; then
    rm -rf ntk
fi

# zynia: 2024-09-17 moved from tuxfamily.org to github.com/linuxaudio/ntk
#	git clone git://git.tuxfamily.org/gitroot/non/fltk.git ntk
git clone https://github.com/linuxaudio/ntk
cd ntk
./waf configure
./waf
./waf install
cd ..
rm -rf ntk

deactivate

