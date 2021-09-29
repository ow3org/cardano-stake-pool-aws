#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures bash with a set of aliases and required variables.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat $HELPERS/config/.bashrc | tail -n +10)"

echo NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> /home/ubuntu/.bashrc

if [ "$NODE_CONFIG" = "mainnet" ]; then
    echo NETWORK="mainnet" >> $HELPERS/config/.bashrc
    echo NETWORK_ARGUMENT="--mainnet" >> $HELPERS/config/.bashrc
elif [ "$NODE_CONFIG" = "testnet" ]; then
    echo NETWORK="testnet" >> $HELPERS/config/.bashrc
    echo NETWORK_ARGUMENT="--testnet-magic 1097911063" >> $HELPERS/config/.bashrc
elif [ "$NODE_CONFIG" = "guild" ]; then
    # TODO: implement "guild"-network option
    echo NETWORK="guild" >> $HELPERS/config/.bashrc
    # echo NETWORK_ARGUMENT="--testnet-magic 1097911063" >> $HELPERS/config/.bashrc
fi

# symlink a few config files - overwrite if they already exist
ln -sf $HELPERS/config/.bashrc /home/ubuntu/.bashrc
ln -sf $HELPERS/config/.bash_aliases /home/ubuntu/.bash_aliases
ln -sf $HELPERS/config/.stake_pool /home/ubuntu/.stake_pool
ln -sf $HELPERS/config/poolMetaData.json $NODE_HOME/poolMetaData.json

eval "$(cat $HELPERS/config/.bashrc | tail -n +10)"

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
