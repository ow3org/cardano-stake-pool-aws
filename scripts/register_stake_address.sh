#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Register your stake pool.

cd $NODE_HOME

# creates a certificate using the stake.vkey
cardano-cli stake-address registration-certificate \
    --stake-verification-key-file stake.vkey \
    --out-file stake.cert

# find your balance and UTXO
cardano-cli query utxo \
    --address $(cat payment.addr) \
    --testnet-magic 1097911063 > fullUtxo.out

tail -n +3 fullUtxo.out | sort -k3 -nr > balance.out

cat balance.out

tx_in=""
total_balance=0

while read -r utxo; do
    in_addr=$(awk '{ print $1 }' <<< "${utxo}")
    idx=$(awk '{ print $2 }' <<< "${utxo}")
    utxo_balance=$(awk '{ print $3 }' <<< "${utxo}")
    total_balance=$((${total_balance}+${utxo_balance}))
    echo TxHash: ${in_addr}#${idx}
    echo ADA: ${utxo_balance}
    tx_in="${tx_in} --tx-in ${in_addr}#${idx}"
done < balance.out

txcnt=$(cat balance.out | wc -l)

echo Total ADA balance: ${total_balance}
echo Number of UTXOs: ${txcnt}

# find the stakeAddressDeposit value
stakeAddressDeposit=$(cat $NODE_HOME/params.json | jq -r '.stakeAddressDeposit')
echo stakeAddressDeposit : $stakeAddressDeposit

cardano-cli transaction build-raw \
    ${tx_in} \
    --tx-out $(cat payment.addr)+0 \
    --invalid-hereafter $(( ${currentSlot} + 10000)) \
    --fee 0 \
    --out-file tx.tmp \
    --certificate stake.cert

# calculates the current minimum fee
fee=$(cardano-cli transaction calculate-min-fee \
    --tx-body-file tx.tmp \
    --tx-in-count ${txcnt} \
    --tx-out-count 1 \
    --testnet-magic 1097911063 \
    --witness-count 2 \
    --byron-witness-count 0 \
    --protocol-params-file params.json | awk '{ print $1 }')
echo fee: $fee

txOut=$((${total_balance}-${stakeAddressDeposit}-${fee}))
echo Change Output: ${txOut}

# copy tx.raw to your cold environment

# sign the transaction with both the payment and stake secret keys
cardano-cli transaction sign \
    --tx-body-file tx.raw \
    --signing-key-file payment.skey \
    --signing-key-file stake.skey \
    --testnet-magic 1097911063 \
    --out-file tx.signed

# copy tx.signed to your hot environment

# send the signed transaction to the blockchain
cardano-cli transaction submit \
    --tx-file tx.signed \
    --testnet-magic 1097911063

# edit the poolMetaData.json now and then run the following command
cardano-cli stake-pool metadata-hash --pool-metadata-file poolMetaData.json > poolMetaDataHash.txt

# now, copy poolMetaDataHash.txt to your cold environment

# next, create a registration certificate for your stake pool
cardano-cli stake-pool registration-certificate \
    --pool-relay-port 6000 \
    --pool-relay-ipv4 44.199.135.88
