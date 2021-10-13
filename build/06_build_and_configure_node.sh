#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install and configure the Cardano node onto our server.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat $HELPERS/config/.bashrc | tail -n +10)"

cd /home/ubuntu/git
git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --recurse-submodules --tags
git checkout 1.30.1
cabal configure -O0 -w ghc-8.10.4

## update the Cabal config, project settings, and reset build folder
sudo ln -sf $HELPERS/config/cabal.project.local cabal.project.local
sed -i /home/ubuntu/.cabal/config -e "s/overwrite-policy:/overwrite-policy: always/g"
rm -rf /home/ubuntu/git/cardano-node/dist-newstyle/build/x86_64-linux/ghc-8.10.4

## build the node from the source code -- this process may take around an hour
cabal build cardano-cli cardano-node
sudo cp $(find /home/ubuntu/git/cardano-node/dist-newstyle/build -type f -name "cardano-cli") /usr/local/bin/cardano-cli
sudo cp $(find /home/ubuntu/git/cardano-node/dist-newstyle/build -type f -name "cardano-node") /usr/local/bin/cardano-node

## next, let us configure this node
mkdir -p $NODE_HOME
cd $NODE_HOME
# NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g')
wget -N https://hydra.iohk.io/build/${NODE_BUILD_NUM}/download/1/${NODE_CONFIG}-byron-genesis.json
wget -N https://hydra.iohk.io/build/${NODE_BUILD_NUM}/download/1/${NODE_CONFIG}-shelley-genesis.json
wget -N https://hydra.iohk.io/build/${NODE_BUILD_NUM}/download/1/${NODE_CONFIG}-alonzo-genesis.json
wget -N https://hydra.iohk.io/build/${NODE_BUILD_NUM}/download/1/${NODE_CONFIG}-topology.json
wget -N https://hydra.iohk.io/build/${NODE_BUILD_NUM}/download/1/${NODE_CONFIG}-config.json

## update TraceBlockFetchDecisions to "true"
sed -i ${NODE_CONFIG}-config.json \
    -e "s/TraceBlockFetchDecisions\": false/TraceBlockFetchDecisions\": true/g"

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

eval "$(cat $HELPERS/config/.bashrc | tail -n +10)"

echo $banner
echo "Script runtime: $runtime seconds"
echo "cardano-node version: $(cardano-node version)"
echo "cardano-cli version: $(cardano-cli version)"
echo $banner
