#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install all of our Cardano Node dependencies to ensure we are up to date and have all the latest security and bug fixes included.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y \
    git jq bc \
    make automake rsync \
    htop curl build-essential \
    pkg-config libffi-dev libffi7 libgmp-dev \
    libssl-dev libtinfo-dev libsystemd-dev libgmp10 \
    zlib1g-dev make g++ wget libncursesw5 libncurses5 libtool \
    libncurses-dev libtinfo5 autoconf \

echo $banner
echo "Script runtime: $runtime seconds"
echo "Finished installing server dependencies"
echo $banner
