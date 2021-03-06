#!/usr/bin/env bash

set -x

mkdir tmp
BUILD_PREFIX=$PWD/tmp

( ./autogen.sh && ./configure --prefix=${BUILD_PREFIX} && make && make install ) || exit 1

git clone --depth 1 https://github.com/imatix/gsl gsl
( cd gsl/src && make -j4 && DESTDIR=${BUILD_PREFIX} make install ) || exit 1

git clone --depth 1 https://github.com/zeromq/czmq czmq
( cd czmq && PATH=$PATH:${BUILD_PREFIX}/bin gsl -target:* project.xml ) || exit 1
