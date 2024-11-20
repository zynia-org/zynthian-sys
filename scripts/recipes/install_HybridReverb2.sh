#!/bin/bash
# Zynia 2024-09-17
# HybridReverb2
#

cd $ZYNTHIAN_PLUGINS_DIR
if [ -d HybridReverb2 ]
then
    rm -rf HybridReverb2
fi
git clone https://github.com/jpcima/HybridReverb2.git
cd HybridReverb2
git submodule init
git submodule update
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release DHybridReverb2_LV2=ON -DHybridReverb2_VST2=OFF -DHybridReverb2_Standalone=OFF ..
cmake --build .
cmake --install .
cd ../..
rm -rf HybridReverb2


