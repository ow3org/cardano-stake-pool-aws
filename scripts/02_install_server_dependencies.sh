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
    pkg-config libffi-dev libgmp-dev \
    libssl-dev libtinfo-dev libsystemd-dev \
    zlib1g-dev make g++ wget libncursesw5 libtool \
    libncurses-dev libtinfo5 autoconf

echo $banner
echo "Total Time Took To Complete Script: $runtime seconds"
echo "Installed cabal Version: $(cabal -V)"
echo "Installed ghc version: $(ghc -V)"
echo $banner
