#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures the block producer & relay nodes.

if [ $IS_RELAY_NODE ]; then
cat > $CNODE_HOME/${NODE_CONFIG}-topology.json << EOF
{
  "Producers": [
    {
      "addr": "${BLOCK_PRODUCER_NODE_IP}",
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
else
cat > $CNODE_HOME/${NODE_CONFIG}-topology.json << EOF
{
  "Producers": [
    {
      "addr": "${RELAY_NODE_1_IP}",
      "port": 6000,
      "valency": 1
    },
    {
      "addr": "${RELAY_NODE_2_IP}",
      "port": 6000,
      "valency": 1
    }
  ]
}
EOF
fi
