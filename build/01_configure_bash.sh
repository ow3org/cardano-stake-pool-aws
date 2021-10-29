#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures bash with a set of aliases and required variables.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

# symlink the .bashrc file and copy some node specific variables
cp ~/cardano-stake-pool-helpers/config/.bashrc ~/.bashrc

eval "$(cat /home/ubuntu/cardano-stake-pool-helpers/config/.bashrc | tail -n +10)"

if [ "$NODE_CONFIG" = "mainnet" ]; then
    sed -i ~/.node-config -e "s/NETWORK_ARGUMENT=/NETWORK_ARGUMENT=--mainnet/g"
elif [ "$NODE_CONFIG" = "testnet" ]; then
    sed -i ~/.node-config -e "s/NETWORK_ARGUMENT=/NETWORK_ARGUMENT='--testnet-magic 1097911063'/g"
# elif [ "$NODE_CONFIG" = "guild" ]; then
#     sed -i ~/.node-config -e "s/NETWORK_ARGUMENT=/NETWORK_ARGUMENT=--guild/g"
# elif [ "$NODE_CONFIG" = "staging" ]; then
#     sed -i ~/.node-config -e "s/NETWORK_ARGUMENT=/NETWORK_ARGUMENT=--staging/g"
fi

eval "$(cat /home/ubuntu/cardano-stake-pool-helpers/config/.bashrc | tail -n +10)"

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "HELPERS: $HELPERS"
echo "NETWORK_ARGUMENT: $NETWORK_ARGUMENT"
echo $banner
