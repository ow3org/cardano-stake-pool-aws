#!/usr/bin/env bash

error() {
  printf "\n Error:  Exiting"
  ls -ltr; pwd
  exit 1
}

slotsPerKESPeriod() {
  if [[ -f "${KES}" && -f "${VRF}" && -f "${CERT}" ]]; then
    echo $(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r '.slotsPerKESPeriod');
  else
    error
  fi
}

slotNo() {
  if [[ -f "${KES}" && -f "${VRF}" && -f "${CERT}" ]]; then
    echo $(cardano-cli query tip ${NETWORK_ARGUMENT} | jq -r '.slot');
  else
    error
  fi
}

currentSlot() {
  if [[ -f "${KES}" && -f "${VRF}" && -f "${CERT}" ]]; then
    echo $(cardano-cli query tip ${NETWORK_ARGUMENT} | jq -r '.slot');
  else
    error
  fi
}

paymentBalance() {
  if [[ -f "$NODE_HOME/payment.addr" ]]; then
    echo $(cardano-cli query utxo --address $(cat $NODE_HOME/payment.addr) ${NETWORK_ARGUMENT});
  else
    error
  fi
}

minPoolCost() {
  if [[ -f "$NODE_HOME/params.json" ]]; then
    echo $(cat $NODE_HOME/params.json | jq -r .minPoolCost);
  else
    error
  fi
}

isCoreNode() {
  if [ "$IS_RELAY_NODE" ]; then
    echo 'false'
  else
    echo "true"
  fi
}

isRelayNode() {
  if [ "$IS_RELAY_NODE" ]; then
    echo 'true'
  else
    echo "false"
  fi
}
