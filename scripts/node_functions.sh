#!/usr/bin/env bash

function error() {
  printf "\n Error:  Exiting"
  ls -ltr; pwd
  exit 1
}

function slotsPerKESPeriod() {
  if [[ -f "${KES}" && -f "${VRF}" && -f "${CERT}" ]]; then
    echo $(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r '.slotsPerKESPeriod');
  else
    error
  fi
}

function slotNo() {
  if [[ -f "${KES}" && -f "${VRF}" && -f "${CERT}" ]]; then
    echo $(cardano-cli query tip ${NETWORK_ARGUMENT} | jq -r '.slot');
  else
    error
  fi
}

function currentSlot() {
  if [[ -f "${KES}" && -f "${VRF}" && -f "${CERT}" ]]; then
    echo $(cardano-cli query tip ${NETWORK_ARGUMENT} | jq -r '.slot');
  else
    error
  fi
}

function paymentBalance() {
  if [[ -f "$NODE_HOME/payment.addr" ]]; then
    echo $(cardano-cli query utxo --address $(cat $NODE_HOME/payment.addr) ${NETWORK_ARGUMENT});
  else
    error
  fi
}

function minPoolCost() {
  if [[ -f "$NODE_HOME/params.json" ]]; then
    echo $(cat $NODE_HOME/params.json | jq -r .minPoolCost);
  else
    error
  fi
}

function isCoreNode() {
  if [ $IS_RELAY_NODE ]; then
    echo "false";
  else
    echo "true";
  fi
}

function isRelayNode() {
  echo "$IS_RELAY_NODE";
}
