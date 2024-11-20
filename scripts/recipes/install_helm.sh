#!/bin/bash

# helm

if [ -z "${ZYNIA}" ]
then
. $ZYNTHIAN_RECIPE_DIR/_zynth_lib.sh

cd $ZYNTHIAN_SW_DIR/plugins

zynth_git https://github.com/mtytel/helm.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]; then
	zynth_build_request clear
	cd helm
	sed -i -- "s/SDEBCXXFLAGS := \$(shell dpkg-buildflags --get CXXFLAGS)/SDEBCXXFLAGS = -O2 -fstack-protector-strong -Wformat -Werror=format-security ${CPU} ${FPU}/" Makefile
	sed -i -- "s/PDEBCXXFLAGS := \$(shell dpkg-buildflags --get CXXFLAGS)/PDEBCXXFLAGS = -O2 -fstack-protector-strong -Wformat -Werror=format-security ${CPU} ${FPU}/" Makefile
	sed -i -- "s/-march=armv8-a -mtune=cortex-a53/${CPU} ${FPU}/" Makefile
	#Don't use more than 2 cores: compilation takes all memory and the system crashes
	make -j 2 lv2
	#make install_lv2
	cp -R builds/linux/LV2/helm.lv2 "${ZYNTHIAN_PLUGINS_DIR}"/lv2
	zynth_build_request ready
	make clean
	cd ..
fi

else
# Zynia 2024-09-17
# Simplify build for riscv
#
cd $ZYNTHIAN_PLUGINS_DIR
if [ -d helm ]
then
    rm -rf helm
fi
git clone https://github.com/mtytel/helm.git
cd helm
sed -i -e "s/SIMDFLAGS := -msse2/SIMDFLAGS :=/" Makefile
make lv2
cp -R builds/linux/LV2/helm.lv2 "${ZYNTHIAN_PLUGINS_DIR}"/lv2
#make clean
cd ..
rm -rf helm
fi
