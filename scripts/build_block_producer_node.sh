#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

su ubuntu

cd /home/ubuntu/cardano-helpers/scripts

./01_configure_bash.sh
./02_install_server_dependencies.sh
./03_update_ssh_port.sh
./04_install_libsodium.sh
./05_install_cabal_and_dependencies.sh
./06_build_and_configure_node.sh
./07_create_startup_scripts.sh
./08_configure_block_producer_node.sh
./09_install_gLiveView_monitoring_tool.sh

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
