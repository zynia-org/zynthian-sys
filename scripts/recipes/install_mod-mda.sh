#!/bin/bash

# mod-mda.lv2
cd $ZYNTHIAN_PLUGINS_SRC_DIR
if [ -d "mda-lv2" ]; then
	rm -rf "mda-lv2"
fi

git clone https://github.com/moddevices/mda-lv2.git
cd mda-lv2
#
#
# 2024-08-12 waf in cloned repo fails due to NULLs in the comment the incorporates the waf library
# Current versions of python do not allow NULLs anywhere in the source file
# replacing with more current version of waf to handle this issue
#
mv waf waf-orig
wget https://waf.io/waf-2.0.21
chmod +x waf-2.0.21
ln -s waf-2.0.21 waf
#
# 2024-08-12 The waf wscript imports waflib.extras.autowaf.  But waflib is not installed
# so installing here.
#
git clone https://github.com/drobilla/autowaf.git waflib
sed -i -e "s/autowaf.display_header/#autowaf.display_header/" wscript
#
#
# --lv2-user --lv2dir=$ZYNTHIAN_PLUGINS_DIR/lv2
export LV2DIR="$ZYNTHIAN_PLUGINS_DIR"/lv2
./waf configure
./waf build
./waf -j1 install
./waf clean
cd ..

#rm -rf "mda-lv2"
