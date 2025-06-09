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
sudo apt install glslang-dev ladspa-sdk libasound2-dev libarchive-dev libbluray-dev libbs2b-dev libcaca-dev libcdio-paranoia-dev libdisplay-info-dev libdrm-dev libdav1d-dev libdvdnav-dev libegl1-mesa-dev libgl1-mesa-dev libjack-jackd2-dev libgnutls28-dev  libmodplug-dev libmp3lame-dev libopenal-dev libopus-dev libopencore-amrnb-dev libopencore-amrwb-dev libpipewire-0.3-dev libpulse-dev librtmp-dev librubberband-dev libsdl2-dev libsixel-dev libssh-dev libsoxr-dev libspeex-dev libuchardet-dev libv4l-dev libva-dev libvdpau-dev libvorbis-dev libvo-amrwbenc-dev libunwind-dev libvpx-dev libx264-dev libxkbcommon-dev libxpresent-dev libxrandr-dev libxss-dev libxv-dev libxvidcore-dev nasm python3-docutils -y

git clone https://github.com/mpv-player/mpv-build.git mpv-build --depth=1

mkdir dist

cd mpv-build

echo "build mpv"
./rebuild -j4

cp ./mpv/build/mpv ../dist/mpv
cp ./mpv/build/mpv_protocols ../dist/mpv_protocols
cp ./mpv/build/mpv.1 ../dist/mpv.1
cp ./mpv/build/mpv.desktop ../dist/mpv.desktop
cp -r ./mpv/build/libmpv* ../dist/

ls -lh ../dist
ls -lh ./mpv/build

echo "build deb"
mk-build-deps -s sudo -i
dpkg-buildpackage -uc -us -b -j4
# sudo dpkg -i ../mpv_<version>_<architecture>.deb


cp -r ./*.deb ../mpv-$OS.deb

cd ..

tar -czf ./mpv-${OS}.tar.gz -C dist .

ls -lh .
