#!/bin/bash
WORKDIR="$ZYNTHIAN_DIR"/tmp-$$
mkdir -p $WORKDIR
cd $WORKDIR
curl -O https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz
tar -xf Python-3.8.2.tar.xz
cd Python-3.8.2
./configure --enable-optimizations
make -j 4
sudo make altinstall
cd "$ZYNTHIAN_DIR"
python3.8 -m venv venv38
rm -rf $WORKDIR

