#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

cd $HOME/cardano-helpers/scripts

./00_configure_bash.sh
./01_install_server_dependencies.sh
./02_update_ssh_port.sh
./03_install_libsodium
./04_install_cabal_and_dependencies.sh
./05_build_and_configure_node.sh
./06_create_startup_scripts.sh
./07_install_gLiveView_monitoring_tool.sh

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
