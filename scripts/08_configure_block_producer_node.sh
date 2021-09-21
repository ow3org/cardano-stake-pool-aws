#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures the block producer node. If running this file manually, only execute this on your Block Producer Node.

cat > $NODE_HOME/${NODE_CONFIG}-topology.json << EOF
 {
    "Producers": [
      {
        "addr": "${RELAY_NODE_1_IP}",
        "port": 6000,
        "valency": 1
      }
    ]
  }
EOF
