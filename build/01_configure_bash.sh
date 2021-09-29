#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures bash with a set of aliases and required variables.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

echo HELPERS="/home/ubuntu/cardano-stake-pool-helpers" >> /home/ubuntu/.bashrc
echo NODE_HOME="/home/ubuntu/cardano-my-node" >> /home/ubuntu/.bashrc
echo NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> /home/ubuntu/.bashrc

if [ "$NODE_CONFIG" = "mainnet" ]; then
    echo NETWORK="mainnet" >> /home/ubuntu/.bashrc
    echo NETWORK_ARGUMENT="--mainnet" >> /home/ubuntu/.bashrc
elif [ "$NODE_CONFIG" = "testnet" ]; then
    echo NETWORK="testnet" >> /home/ubuntu/.bashrc
    echo NETWORK_ARGUMENT="--testnet-magic 1097911063" >> /home/ubuntu/.bashrc
elif [ "$NODE_CONFIG" = "guild" ]; then
    # TODO: implement "guild"-network option
    echo NETWORK="guild" >> /home/ubuntu/.bashrc
    # echo NETWORK_ARGUMENT="--testnet-magic 1097911063" >> /home/ubuntu/.bashrc
fi

# DO NOT CHANGE: utilized by cnode-helper-scripts
echo CNODE_HOME="/home/ubuntu/cardano-my-node" >> /home/ubuntu/.bashrc
echo CARDANO_NODE_SOCKET_PATH="/home/ubuntu/cardano-my-node/db/socket" >> /home/ubuntu/.bashrc

# symlink a few config files - overwrite if they already exist
sudo ln -sf $HELPERS/config/.bashrc /home/ubuntu/.bashrc
sudo ln -sf $HELPERS/config/.bash_aliases /home/ubuntu/.bash_aliases
sudo ln -sf $HELPERS/config/poolMetaData.json $NODE_HOME/poolMetaData.json

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "HELPERS: $HELPERS"
echo "NODE_HOME: $NODE_HOME"
echo "CNODE_HOME: $CNODE_HOME"
echo "NODE_BUILD_NUM: $NODE_BUILD_NUM"
echo "NETWORK: $NETWORK"
echo "NETWORK_ARGUMENT: $NETWORK_ARGUMENT"
echo "CARDANO_NODE_SOCKET_PATH: $CARDANO_NODE_SOCKET_PATH"
echo $banner
