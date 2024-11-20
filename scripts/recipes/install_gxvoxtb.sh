#!/bin/bash
#zynia Created 2024-09-17

# gxvoxtonebender lv2 plugin
cd $ZYNTHIAN_PLUGINS_DIR

if [ -d gxvoxtb ]; then
	rm -rf gxvoxtb
fi

wget -O gxvoxtb.tar.bz2 https://sourceforge.net/projects/guitarix/files/lv2/gx_voxtb.lv2.tar.bz2/download
tar xjf gxvoxtb.tar.bz2
mv gx_voxtb.lv2 gxvoxtb
cd gxvoxtb
sed -i -e "s/-msse -mfpmath=sse//" Makefile
sed -i -e "s/-msse2 -mfpmath=sse//" Makefile
# make all  -- make install calls make all ???
make install
cd ..
rm -rf gxvoxtb

