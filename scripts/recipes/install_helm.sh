#!/bin/bash

# helm

cd $ZYNTHIAN_SW_DIR/plugins

if [ -d "helm" ]; then
	rm -rf helm
fi
git clone https://github.com/mtytel/helm.git
cd helm

# Zynia 2024-11-20
# Adjust build for vf2 board
if [ -z "${ZYNIA}" ]
then
  # Original build
  sed -i -- "s/SDEBCXXFLAGS := \$(shell dpkg-buildflags --get CXXFLAGS)/SDEBCXXFLAGS = -O2 -fstack-protector-strong -Wformat -Werror=format-security ${CPU} ${FPU}/" Makefile
  sed -i -- "s/PDEBCXXFLAGS := \$(shell dpkg-buildflags --get CXXFLAGS)/PDEBCXXFLAGS = -O2 -fstack-protector-strong -Wformat -Werror=format-security ${CPU} ${FPU}/" Makefile
  sed -i -- "s/-march=armv8-a -mtune=cortex-a53/${CPU} ${FPU}/" Makefile
  # Don't use more than 2 cores: compilation takes all memory and the system crashes
  make -j 3 lv2
else
  # Zynia 2024-09-17
  # Simplify build for riscv
  sed -i -e "s/SIMDFLAGS := -msse2/SIMDFLAGS :=/" Makefile
  make lv2
fi

#make install_lv2
cp -R builds/linux/LV2/helm.lv2 "${ZYNTHIAN_PLUGINS_DIR}"/lv2
make clean
cd ..
rm -rf helm

# Create config file
if [ ! -d "/root/.helm" ]; then
	mkdir "/root/.helm"
fi
echo '{
  "synth_version": "0.9.0",
  "day_asked_for_payment": 19989,
  "should_ask_for_payment": false,
  "animate_widgets": false
}' > /root/.helm/Helm.config
