#!/usr/bin/env bash

# Author: Meema Labs
# Telegram Channel: https://telegram.meema.io
# Discord: https://discord.meema.io

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

# 1. let's install all of our Cardano Node dependencies to ensure we are up to date and have all the latest security and bug fixes included
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git jq bc \
                     make automake rsync \
                     htop curl build-essential \
                     pkg-config libffi-dev libgmp-dev \
                     libssl-dev libtinfo-dev libsystemd-dev \
                     zlib1g-dev make g++ wget libncursesw5 libtool \
                     libncurses-dev libtinfo5 autoconf -y

## let's install Libsodium
mkdir $HOME/git
cd $HOME/git
git clone https://github.com/input-output-hk/libsodium
cd libsodium
git checkout 66f017f1
./autogen.sh
./configure
make
sudo make install
sudo ln -s /usr/local/lib/libsodium.so.23.3.0 /usr/lib/libsodium.so.23

## now we need to install Cabal and its dependencies
export BOOTSTRAP_HASKELL_NONINTERACTIVE=true
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

GHCUP_PROFILE_FILE="$HOME/.bashrc"
GHCUP_DIR=$HOME/.ghcup
echo "[ -f \"${GHCUP_DIR}/env\" ] && source \"${GHCUP_DIR}/env\" # ghcup-env" >> "${GHCUP_PROFILE_FILE}"
eval "$(cat "${GHCUP_PROFILE_FILE}" | tail -n +10)"

ghcup upgrade
ghcup install ghc 8.10.4
ghcup set ghc 8.10.4
ghcup install cabal 3.4.0.0
ghcup set cabal 3.4.0.0

echo PATH="$HOME/.local/bin:$PATH" >> $HOME/.bashrc
echo export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> $HOME/.bashrc
echo export NODE_HOME=$HOME/cardano-my-node >> $HOME/.bashrc
# TODO: document how to use testnet
echo export NODE_CONFIG=mainnet >> $HOME/.bashrc
echo export NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> $HOME/.bashrc
eval "$(cat $HOME/.bashrc | tail -n +10)"

cabal update

# 2. let's install and configure the Cardano node onto our server next
cd $HOME/git
git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --recurse-submodules --tags
git checkout 1.29.0
cabal configure -O0 -w ghc-8.10.4

## update the Cabal config, project settings, and reset build folder
echo -e "package cardano-crypto-praos\n flags: -external-libsodium-vrf" > cabal.project.local
sed -i $HOME/.cabal/config -e "s/overwrite-policy:/overwrite-policy: always/g"
rm -rf $HOME/git/cardano-node/dist-newstyle/build/x86_64-linux/ghc-8.10.4

## build the node from the source code -- this process may take a while
cabal build cardano-cli cardano-node
sudo cp $(find $HOME/git/cardano-node/dist-newstyle/build -type f -name "cardano-cli") /usr/local/bin/cardano-cli
sudo cp $(find $HOME/git/cardano-node/dist-newstyle/build -type f -name "cardano-node") /usr/local/bin/cardano-node

## next, let us configure this node

# conclude this script
end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Total Time Took To Complete Script: $runtime seconds"
echo "Installed Cabal Version: $(cabal -V)"
echo "Installed GHC version: $(ghc -V)"
echo "cardano-node version: $(cardano-node version)"
echo "cardano-cli version: $(cardano-cli version)"
echo "Node Location: $NODE_HOME"
echo $banner
