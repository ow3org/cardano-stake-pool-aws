#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram Channel: https://telegram.meema.io
# Discord: https://discord.meema.io

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

cd $HOME/cardano-helpers

./01_install_cardano-node_dependencies.sh
./02_build_node_and_configure.sh
./03_create_startup_scripts.sh
./04_install_gLiveView_monitoring_tool.sh

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
echo "gLiveView is installed under Directory : $NODE_HOME/gLiveView.sh"

echo $banner
