#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install Libsodium

eval "$(cat $HELPERS/config/.bashrc | tail -n +10)"

echo PATH="/home/ubuntu/.local/bin:$PATH" >> /home/ubuntu/.bashrc
echo LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> /home/ubuntu/.bashrc

eval "$(cat $HELPERS/config/.bashrc | tail -n +10)"

mkdir /home/ubuntu/git
cd /home/ubuntu/git
git clone https://github.com/input-output-hk/libsodium
cd libsodium
git checkout 66f017f1
./autogen.sh
./configure
make
sudo make install
sudo ln -s /usr/local/lib/libsodium.so.23.3.0 /usr/lib/libsodium.so.23
