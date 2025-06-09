#!/bin/bash

TARGET=$1
OS=$2

# install deps
sudo apt-get install devscripts equivs -y

git clone https://github.com/mpv-player/mpv-build.git mpv-build --depth=1

cd mpv-build

mk-build-deps -s sudo -i
dpkg-buildpackage -uc -us -b -j4
# sudo dpkg -i ../mpv_<version>_<architecture>.deb


cp -r ./*.deb ../mpv-$OS.deb

cd ..

ls -lh .
