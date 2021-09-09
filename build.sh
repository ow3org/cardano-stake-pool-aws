#!/usr/bin/env bash

# Author: Meema Labs
# Telegram Channel: https://telegram.meema.io
# Discord: https://discord.meema.io

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git jq \
                    bc make automake \
                    rsync htop curl \
                    build-essential pkg-config \
                    libffi-dev libgmp-dev libssl-dev \
                    libtinfo-dev libsystemd-dev zlib1g-dev \
                    make g++ wget libncursesw5 libtool autoconf libncurses-dev libtinfo5 -y
