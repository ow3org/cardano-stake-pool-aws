#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram Channel: https://telegram.meema.io
# Discord: https://discord.meema.io

# Install gLiveView Monitoring tool.

cat > $NODE_HOME/${NODE_CONFIG}-topology.json << EOF
 {
    "Producers": [
      {
        "addr": "<BLOCK PRODUCER NODE'S PUBLIC IP ADDRESS>",
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

