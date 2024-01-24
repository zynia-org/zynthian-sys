#!/bin/bash

cd $ZYNTHIAN_SW_DIR
if [ ! -d "jpmidi-0.21" ]; then
	wget https://github.com/jerash/jpmidi/archive/v0.21.tar.gz -O jpmidi-0.21.tar.gz
	tar xfvz jpmidi-0.21.tar.gz
	cd jpmidi-0.21/jpmidi
        # start fgh 2024-01-16
        cd config
        wget -O config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'
        wget -O config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'
        cd ..
        # end fgh 2024-01-16
	./configure
	make -j 4
	cp ./src/jpmidi /usr/local/bin
	cd ../..
	rm -f jpmidi-0.21.tar.gz
fi
