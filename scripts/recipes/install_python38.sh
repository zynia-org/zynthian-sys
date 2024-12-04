#!/bin/bash
if [ -z "$(which python3.8)" ]; then
    WORKDIR="$(mktemp -d)"
    mkdir -p ${WORKDIR}
    pushd ${WORKDIR}
    curl -O https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz
    tar -xf Python-3.8.2.tar.xz
    cd Python-3.8.2
    ./configure --enable-optimizations
    make -j 4
    sudo make altinstall
    popd
    rm -rf ${WORKDIR}
fi
if [ ! -d "${ZYNTHIAN_DIR}/venv38" ]; then
    cd "${ZYNTHIAN_DIR}"
    python3.8 -m venv venv38
fi


