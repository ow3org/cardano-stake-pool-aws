#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram Channel: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install and configure the Cardano node onto our server.

eval "$(cat $HOME/.bashrc | tail -n +10)"

cp $HOME/cardano-helpers/scripts/start_node.sh $NODE_HOME/start_node.sh
chmod +x $NODE_HOME/start_node.sh

cp $HOME/cardano-helpers/config/cardano-node.service /etc/systemd/system/cardano-node.service
sudo chmod 644 /etc/systemd/system/cardano-node.service

sudo systemctl daemon-reload
sudo systemctl enable cardano-node

sudo systemctl start cardano-node
