#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Updates cardano-node.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat $HELPERS/config/.bashrc | tail -n +10)"

mkdir -p ${HOME}/git
cd ${HOME}/git || error
mv -vf ${HOME}/git/cardano-node ${HOME}/git/cardano-node-old || true
git clone https://github.com/input-output-hk/cardano-node.git || error
cd cardano-node || error
git fetch --all --recurse-submodules --tags
git checkout 1.30.1
cabal configure -O0 -w ghc-8.10.4

## update the Cabal config, project settings, and reset build folder
sudo ln -sf $HELPERS/config/cabal.project.local cabal.project.local
# sed -i /home/ubuntu/.cabal/config -e "s/overwrite-policy:/overwrite-policy: always/g"
rm -rf ${HOME}/git/cardano-node/dist-newstyle/build/x86_64-linux/ghc-8.10.4

## build the node from the source code -- this process may take around an hour
cabal build cardano-cli cardano-node
sudo cp $(find /home/ubuntu/git/cardano-node/dist-newstyle/build -type f -name "cardano-cli") /usr/local/bin/cardano-cli
sudo cp $(find /home/ubuntu/git/cardano-node/dist-newstyle/build -type f -name "cardano-node") /usr/local/bin/cardano-node

sudo systemctl start cardano-node
end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "Installed GHC version: $(ghc -V)"
echo "Installed Cabal version: $(cabal -V)"
echo "Cardano Node location: $NODE_HOME"
echo "cardano-node version: $(cardano-node version)"
echo "cardano-cli version: $(cardano-cli version)"
echo $banner
