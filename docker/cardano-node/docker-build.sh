#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram Channel: https://telegram.meema.io
# Discord: https://discord.meema.io

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

echo '$HOME/ubuntu is '
echo $HOME/ubuntu
cd $HOME/ubuntu
git clone https://github.com/meemalabs/cardano-stake-pool-aws.git cardano-helpers
cd cardano-helpers

chmod +x ./scripts/*

./scripts/02_install_libsodium.sh
./scripts/03_install_cabal_and_dependencies.sh
./scripts/04_build_node_and_configure.sh
./scripts/05_create_startup_scripts.sh

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner

echo "Total Time Took To Complete Script: $runtime seconds"
echo "Installed Cabal Version: $(cabal -V)"
echo "Installed GHC version: $(ghc -V)"
echo "Node Location: $NODE_HOME"
echo "cardano-node version: $(cardano-node version)"
echo "cardano-cli version: $(cardano-cli version)"
echo "Status of Cardano Node: $(sudo systemctl status cardano-node)"
# echo "gLiveView is installed under Directory : $NODE_HOME/gLiveView.sh"

echo $banner
