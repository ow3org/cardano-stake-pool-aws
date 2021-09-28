#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's configure our Cardano node using systemd.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

sudo cp $NODE_HOME/config/cardano-node.service /etc/systemd/system/cardano-node.service
sudo chmod 644 /etc/systemd/system/cardano-node.service

sudo systemctl daemon-reload
sudo systemctl enable cardano-node

sudo systemctl start cardano-node

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "Status of Cardano Node: $(sudo systemctl status cardano-node)"
echo $banner
