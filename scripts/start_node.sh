#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Starts the node.

if [[ -S "$CARDANO_NODE_SOCKET_PATH" ]]; then
  if pgrep -f "[c]ardano-node.*.$CARDANO_NODE_SOCKET_PATH"; then
     echo "ERROR: A Cardano node is already running, please terminate this node before starting a new one with this script. You may run the command `restart`"
     exit
  else
    echo "WARN: A prior running Cardano node was not properly shutdown. The socket file still exists. Cleaning it up..."
    unlink "$CARDANO_NODE_SOCKET_PATH"
  fi
fi

if [ $IS_RELAY_NODE ]; then
  # start the relay node
  echo "Starting Cardano Relay Node..."
  /usr/local/bin/cardano-node run +RTS -N -A16m -qg -qb -RTS \
    --topology "$TOPOLOGY" \
    --config "$CONFIG" \
    --port $PORT \
    --database-path "$DB_PATH" \
    --socket-path "$CARDANO_NODE_SOCKET_PATH" \
    --host-addr "$HOSTADDR"
else
  # start the block producing node
  echo "Starting Cardano Core Node..."

  if [ ! -f "$KES" ]; then
      echo "Missing required file: $NODE_HOME/kes.skey"
      MISSING_FILES=1
  fi

  if [ ! -f "$VRF" ]; then
      echo "Missing required file: ${NODE_HOME}/vrf.skey"
      MISSING_FILES=1
  fi

  if [ ! -f "$CERT" ]; then
      echo "Missing required $NODE_HOME/node.cert."
      MISSING_FILES=1
  fi

  if [ -n "$MISSING_FILES" ]; then
    echo "You are missing required files to start."
    echo "You need to initialize the Stake Pool keys, addresses and certificates and submit them to the blockchain first."
    echo "You can do that by executing \`generate_block_producer_keys\`"
    read

    exit
  fi

  /usr/local/bin/cardano-node run +RTS -N -A16m -qg -qb -RTS \
    --topology "$TOPOLOGY" \
    --config "$CONFIG" \
    --port $PORT \
    --database-path "$DB_PATH" \
    --socket-path "$CARDANO_NODE_SOCKET_PATH" \
    --shelley-kes-key "$KES" \
    --shelley-vrf-key "$VRF" \
    --shelley-operational-certificate "$CERT" \
    --host-addr "$HOSTADDR"
fi

# aws ec2 associate-address --instance-id i-0602a5460425d2010 --allocation-id eipalloc-0770c00035328c3a2 --allow-reassociation --region us-east-1
