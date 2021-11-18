#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

cd $HERLPERS/build

./01_configure_bash.sh
./02_install_prereqs.sh
./03_build_node.sh
./04_configure_node.sh
./05_update_ssh_port.sh

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

echo "Script runtime: $runtime seconds"
echo "Installed Cabal version: $(cabal -V)"
echo "Installed GHC version: $(ghc -V)"
echo "Cardano Node location: $CNODE_HOME"
echo "cardano-node version: $(cardano-node version)"
echo "cardano-cli version: $(cardano-cli version)"
echo "Status of Cardano Node: $(sudo systemctl status cnode.service)"

echo $banner
