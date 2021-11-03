#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Generates all the keys required for your Cardano Stake Pool operations.

# *Before continuing, please read & be cautious*
## For any "live stake pools," *only* execute this script on servers not connected to any network ("cold machines")
## Payment and stake keys must be generated and used to build transactions in a cold environment

# The only steps performed in a hot environment (a server connected to the internet) are those steps that require live data:
## querying the current slot tip
## querying the balance of an address
## submitting a transaction

# Be sure to back up your all your keys to another secure storage device. Make multiple copies.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat $HOME/.bashrc | tail -n +10)"

cd $CNODE_HOME

cardano-cli node key-gen-KES \
    --verification-key-file kes.vkey \
    --signing-key-file kes.skey

mkdir -p $HOME/cold-keys

cardano-cli node key-gen \
    --cold-verification-key-file node.vkey \
    --cold-signing-key-file node.skey \
    --operational-certificate-issue-counter node.counter

slotsPerKESPeriod=$(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
echo "slotsPerKESPeriod: ${slotsPerKESPeriod}"

slotNo=$(cardano-cli query tip --mainnet | jq -r '.slot')
echo slotNo: ${slotNo}

kesPeriod=$((${slotNo} / ${slotsPerKESPeriod}))
echo "kesPeriod: ${kesPeriod}"
startKesPeriod=${kesPeriod}
echo "startKesPeriod: ${startKesPeriod}"

cardano-cli node issue-op-cert \
    --kes-verification-key-file kes.vkey \
    --cold-signing-key-file $HOME/cold-keys/node.skey \
    --operational-certificate-issue-counter $HOME/cold-keys/node.counter \
    --kes-period ${startKesPeriod} \
    --out-file node.cert

cardano-cli node key-gen-VRF \
    --verification-key-file vrf.vkey \
    --signing-key-file vrf.skey

chmod 400 vrf.skey

# let's now create the payment and stake keys
cardano-cli query protocol-parameters \
    ${NETWORK_ARGUMENT} \
    --out-file params.json

cardano-cli address key-gen \
    --verification-key-file payment.vkey \
    --signing-key-file payment.skey

cardano-cli stake-address key-gen \
    --verification-key-file stake.vkey \
    --signing-key-file stake.skey

cardano-cli stake-address build \
    --stake-verification-key-file stake.vkey \
    --out-file stake.addr \
    ${NETWORK_ARGUMENT}

cardano-cli address build \
    --payment-verification-key-file payment.vkey \
    --stake-verification-key-file stake.vkey \
    --out-file payment.addr \
    ${NETWORK_ARGUMENT}

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "Payment Address: $(cat payment.addr)"
echo $banner
