#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Starts the node.

DIRECTORY=$NODE_HOME
PORT=6000
HOSTADDR=0.0.0.0
TOPOLOGY=${DIRECTORY}/${NODE_CONFIG}-topology.json
DB_PATH=${DIRECTORY}/db
SOCKET_PATH=${DIRECTORY}/db/socket
CONFIG=${DIRECTORY}/${NODE_CONFIG}-config.json
KES=\${DIRECTORY}/kes.skey
VRF=\${DIRECTORY}/vrf.skey
CERT=\${DIRECTORY}/node.cert

if [[ -f "${VRF}" && -f "${VRF}" && -f "${CERT}" ]]; then
  # start the block producing node
  /usr/local/bin/cardano-node run \
    --topology "${TOPOLOGY}" \
    --database-path "${DB_PATH}" \
    --socket-path "${SOCKET_PATH}" \
    --host-addr ${HOSTADDR} \
    --port ${PORT} \
    --config ${CONFIG} \
    --shelley-kes-key "${KES}" \
    --shelley-vrf-key "${VRF}" \
    --shelley-operational-certificate "${CERT}"
else
  # start the relay node
  /usr/local/bin/cardano-node run --topology "${TOPOLOGY}" \
    --database-path "${DB_PATH}" \
    --socket-path "${SOCKET_PATH}" \
    --host-addr ${HOSTADDR} \
    --port ${PORT} \
    --config ${CONFIG}
fi
