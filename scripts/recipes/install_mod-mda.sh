#!/bin/bash

# mod-mda.lv2

# if running on python3 > 3.8; move to python 3.8 installing if necessary.
# waf for mod-mda-lv2 does not work beyond 3.8.
if [ $(python3 -c 'import sys; print(sys.version_info.minor)') > 8 ]; then
    source $ZYNTHIAN_DIR/venv38/bin/activate
fi

cd $ZYNTHIAN_PLUGINS_SRC_DIR
if [ -d "mda-lv2" ]; then
	rm -rf "mda-lv2"
fi

git clone https://github.com/moddevices/mda-lv2.git
cd mda-lv2
./waf configure
sed -i "s/rU/r/g" .waf3-1.7.16-298c23e5260e502b06df5657cfb0eb26/waflib/Context.py
sed -i "s/rU/r/g" .waf3-1.7.16-298c23e5260e502b06df5657cfb0eb26/waflib/ConfigSet.py
./waf configure --lv2-user --lv2dir=$ZYNTHIAN_PLUGINS_DIR/lv2
./waf build
./waf -j1 install
./waf clean
cd ..

