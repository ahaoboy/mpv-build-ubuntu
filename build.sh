#!/bin/bash

TARGET=$1
OS=$2

# install deps
sudo apt update -y
sudo apt install devscripts equivs -y
sudo apt install libwayland-dev wayland-protocols -y
sudo apt install libtool libmujs-dev  mujs lua5.2 liblua5.2-dev -y
sudo apt install libwayland-bin libwayland-client0 libwayland-server0 wayland-utils -y
sudo apt install python3 python3-pip python3-setuptools python3-wheel ninja-build meson -y
sudo apt install libass-dev libmujs-dev libavcodec-dev libavfilter-dev ffmpeg libplacebo-dev -y

git clone https://github.com/mpv-player/mpv-build.git mpv-build --depth=1

cd mpv-build

mk-build-deps -s sudo -i
dpkg-buildpackage -uc -us -b -j4
# sudo dpkg -i ../mpv_<version>_<architecture>.deb


cp -r ./*.deb ../mpv-$OS.deb

cd ..

ls -lh .
