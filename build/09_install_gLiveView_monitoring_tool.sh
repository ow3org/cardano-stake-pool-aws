#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Install gLiveView Monitoring tool.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

cd $NODE_HOME
sudo apt install bc tcptraceroute -y
curl -s -o gLiveView.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/gLiveView.sh
curl -s -o env https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/env
chmod 755 gLiveView.sh

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "gLiveView location: $NODE_HOME/gLiveView.sh"
echo $banner
