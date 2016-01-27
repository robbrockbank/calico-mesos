#!/usr/bin/env bash
set -e
set -x

# Build the Isolator.
mkdir -p /net-modules
git clone https://github.com/robbrockbank/net-modules.git /net-modules
cd /net-modules && git checkout $NETMODULES_BRANCH
mv /net-modules/isolator /
cd /isolator

./bootstrap && \
  rm -rf build && \
  mkdir build && \
  cd build && \
  export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/usr/local/lib && \
  ../configure --with-mesos=/usr/local --with-protobuf=/usr && \
  make all && make install

mkdir -p /calico
mv /net-modules/calico/modules.json /calico/
