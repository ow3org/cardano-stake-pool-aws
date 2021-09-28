#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures bash with a set of aliases and required variables.

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

echo HELPERS="/home/ubuntu/cardano-helpers" >> /home/ubuntu/.bashrc
echo NODE_HOME="/home/ubuntu/cardano-my-node" >> /home/ubuntu/.bashrc
echo NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> /home/ubuntu/.bashrc

if [ "$NODE_CONFIG" = "mainnet" ]; then
    echo NETWORK="mainnet" >> /home/ubuntu/.bashrc
    echo NETWORK_ARGUMENT="--mainnet" >> /home/ubuntu/.bashrc
elif [ "$NODE_CONFIG" = "testnet" ]; then
    echo NETWORK="testnet" >> /home/ubuntu/.bashrc
    echo NETWORK_ARGUMENT="--testnet-magic 1097911063" >> /home/ubuntu/.bashrc
fi
# TODO: implement "guild"-network option

# DO NOT CHANGE: `CNODE_HOME` is utilized by cnode-helper-scripts
echo CNODE_HOME="/home/ubuntu/cardano-my-node" >> /home/ubuntu/.bashrc

# DO NOT CHANGE: `CARDANO_NODE_SOCKET_PATH` is utilized by cnode-helper-scripts
echo CARDANO_NODE_SOCKET_PATH="/home/ubuntu/cardano-my-node/db/socket" >> /home/ubuntu/.bashrc

# symlink a few config files
sudo ln -s /home/ubuntu/cardano-helpers/config/.bash_aliases /home/ubuntu/.bash_aliases
sudo ln -s /home/ubuntu/cardano-helpers/config/poolMetaData.json /home/ubuntu/cardano-my-node/poolMetaData.json

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"
