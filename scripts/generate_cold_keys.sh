#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Generates the cold keys.

# *Before continuing, please read & be cautious*
# For any "live stake pools," *only* execute this script on servers not connected to any network ("cold machines")
# Be sure to back up your all your keys to another secure storage device. Make multiple copies.

# Additionally, your node must be fully synchronized to the blockchain.
# Otherwise, you won't calculate the latest KES period. Your node is synchronized when the epoch and slot # is equal to
# that found on a block explorer, like https://pooltool.io

mkdir $HOME/cold-keys
pushd $HOME/cold-keys

cardano-cli node key-gen \
    --cold-verification-key-file node.vkey \
    --cold-signing-key-file $HOME/cold-keys/node.skey \
    --operational-certificate-issue-counter node.counter


pushd +1
slotsPerKESPeriod=$(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
echo slotsPerKESPeriod: ${slotsPerKESPeriod}
