#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Installs gLiveView monitoring tool.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

cd $CNODE_HOME
curl -s -o gLiveView.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/gLiveView.sh
chmod 755 gLiveView.sh

curl -s -o env https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/env
sed -i env \
     -e "s/\#CONFIG=\"\${CNODE_HOME}\/files\/config.json\"/CONFIG=\"\${CNODE_HOME}\/\${NODE_CONFIG}-config.json\"/g" \
     -e "s/\#SOCKET=\"\${CNODE_HOME}\/sockets\/node0.socket\"/SOCKET=\"\${CNODE_HOME}\/db\/socket\"/g"

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

echo $banner
echo "Script runtime: $runtime seconds"
echo "gLiveView location: $NODE_HOME/gLiveView.sh"
echo $banner
