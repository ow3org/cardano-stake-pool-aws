#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures the relay node. If running this file manually, only execute this on your "Relay Node 1."

cat > $NODE_HOME/${NODE_CONFIG}-topology.json << EOF
 {
    "Producers": [
      {
        "addr": "${BLOCK_PRODUCER_NODE_1_IP}",
        "port": 6000,
        "valency": 1
      },
      {
        "addr": "relays-new.cardano-mainnet.iohk.io",
        "port": 3001,
        "valency": 2
      }
    ]
  }
EOF
