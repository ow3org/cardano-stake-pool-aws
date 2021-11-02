#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures the Cardano core and relay nodes.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

sudo ln -sf $CNODE_HOME/scripts/env $HELPERS/scripts/env
$HELPERS/scripts/deploy-as-systemd.sh
sudo systemctl daemon-reload
sudo systemctl restart cnode.service

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "Status of Cardano Node: $(sudo systemctl status cnode.service)"
echo $banner

# if [ $IS_RELAY_NODE ]; then
# cat > $CNODE_HOME/${NODE_CONFIG}-topology.json << EOF
# {
#   "Producers": [
#     {
#       "addr": "${BLOCK_PRODUCER_NODE_IP}",
#       "port": 6000,
#       "valency": 1
#     },
#     {
#       "addr": "relays-new.cardano-mainnet.iohk.io",
#       "port": 3001,
#       "valency": 2
#     }
#   ]
# }
# EOF
# else
# cat > $CNODE_HOME/${NODE_CONFIG}-topology.json << EOF
# {
#   "Producers": [
#     {
#       "addr": "${RELAY_NODE_1_IP}",
#       "port": 6000,
#       "valency": 1
#     },
#     {
#       "addr": "${RELAY_NODE_2_IP}",
#       "port": 6000,
#       "valency": 1
#     }
#   ]
# }
# EOF
# fi
