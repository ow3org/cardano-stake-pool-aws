#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures bash with a set of aliases and required variables.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/cardano-stake-pool-helpers/config/.bashrc | tail -n +10)"

# echo NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> $HOME/.bashrc

# if [ "$NODE_CONFIG" = "mainnet" ]; then
#     sed -i ./.node-config -e "s/NETWORK_ARGUMENT=/NETWORK_ARGUMENT=--mainnet/g"
# elif [ "$NODE_CONFIG" = "testnet" ]; then
#     sed -i ./.node-config -e "s/NETWORK_ARGUMENT=/NETWORK_ARGUMENT='--testnet-magic 1097911063'/g"
# # elif [ "$NODE_CONFIG" = "guild" ]; then
# #     sed -i ./.node-config -e "s/NETWORK_ARGUMENT=/NETWORK_ARGUMENT=--guild/g"
# # elif [ "$NODE_CONFIG" = "staging" ]; then
# #     sed -i ./.node-config -e "s/NETWORK_ARGUMENT=/NETWORK_ARGUMENT=--staging/g"
# fi

# symlink a few config files - overwrite if they already exist
ln -sf ~/cardano-stake-pool-helpers/config/.bashrc ~/.bashrc
ln -sf ~/cardano-stake-pool-helpers/config/.node-config ~/.node-config

eval "$(cat /home/ubuntu/cardano-stake-pool-helpers/config/.bashrc | tail -n +10)"

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "HELPERS: $HELPERS"
echo "NETWORK_ARGUMENT: $NETWORK_ARGUMENT"
echo $banner
