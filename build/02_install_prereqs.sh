#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install all of our Cardano Node dependencies to ensure we are up to date and have all the latest security and bug fixes included.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat $HELPERS/config/.bashrc | tail -n +10)"

mkdir $HOME/tmp
cd $HOME/tmp
curl -sS -o prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/prereqs.sh
chmod 755 prereqs.sh
./prereqs.sh
# . "${HOME}/.bashrc"


# sudo apt-get update -y
# sudo apt-get upgrade -y
# sudo apt-get install -y \
#     git jq bc \
#     make automake rsync \
#     htop curl build-essential \
#     pkg-config libffi-dev libffi7 libgmp-dev \
#     libssl-dev libtinfo-dev libsystemd-dev libgmp10 \
#     zlib1g-dev make g++ wget libncursesw5 libncurses5 libtool \
#     libncurses-dev libtinfo5 autoconf \

echo $banner
echo "Script runtime: $runtime seconds"
echo "Finished installing server dependencies"
echo $banner
