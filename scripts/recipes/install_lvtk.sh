#!/bin/bash



source /zynthian/zynthian-sys/scripts/zynthian_envars_extended.sh

#if [ -d lvtk ]; then
#	rm -rf lvtk
#fi

# LVTK-1
cd $ZYNTHIAN_SW_DIR
if [ -d lvtk-1 ]; then
	rm -rf lvtk-1
fi

wget https://github.com/lvtk/lvtk/archive/refs/tags/1.2.0.tar.gz
tar xfvz 1.2.0.tar.gz
cd lvtk-1.2.0


git clone https://github.com/lvtk/lvtk.git lvtk-1
cd lvtk-1
git checkout v1
#
#
# 2024-08-12 waf in cloned repo fails due to NULLs in the comment the incorporates the waf library
# Current versions of python do not allow NULLs anywhere in the source file
# replacing with more current version of waf to handle this issue
#
mv waf waf-orig
wget https://waf.io/waf-2.0.19
chmod +x waf-2.0.19
ln -s waf-2.0.19 waf
#
#
./waf configure
./waf build
./waf install
./waf clean
cd ..

# LVTK-2
cd $ZYNTHIAN_SW_DIR
if [ -d lvtk-2 ]; then
	rm -rf lvtk-2
fi
git clone https://github.com/lvtk/lvtk.git lvtk-2
cd lvtk-2
git checkout v2
meson setup build
cd build
meson compile
meson install
cd ../..

# pugl: needed for v3
apt install -y sphinxygen
if [ -d pugl ]; then
	rm -rf pugl
fi
git clone https://github.com/lv2/pugl
cd pugl
meson setup build
cd build
meson compile
meson install
cd ../..

# LVTK-3
cd $ZYNTHIAN_SW_DIR
if [ -d lvtk-3 ]; then
	rm -rf lvtk-3
fi
git clone https://github.com/lvtk/lvtk.git lvtk-3
cd lvtk-3
meson setup build
cd build
meson compile
meson install
cd ../..

cp /usr/local/lib/pkgconfig/lvtk-plugin-1.pc /usr/local/lib/pkgconfig/lvtk-plugin-2.pc
