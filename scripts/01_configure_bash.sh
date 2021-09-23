#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures bash with a set of aliases and required variables.

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

echo export NODE_HOME="/home/ubuntu/cardano-my-node" >> /home/ubuntu/.bashrc
echo export NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> /home/ubuntu/.bashrc
echo export CARDANO_NODE_SOCKET_PATH="$NODE_HOME/db/socket" >> /home/ubuntu/.bashrc

# CNODE_HOME is the same variable as NODE_HOME, but we need to keep this alias around because
# it is a variable that's used in guild-operator's cnode-helper-scripts
echo export CNODE_HOME="/home/ubuntu/cardano-my-node" >> /home/ubuntu/.bashrc

# needed when configuring libsodium
echo PATH="/home/ubuntu/.local/bin:$PATH" >> /home/ubuntu/.bashrc
echo export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> /home/ubuntu/.bashrc

# sudo ln -s $HOME/cardano-helpers/config/.bashrc $HOME/.bashrc # TODO: figure out how to properly set variables from the UserData script
sudo ln -s /home/ubuntu/cardano-helpers/config/.bash_aliases /home/ubuntu/.bash_aliases

source /home/ubuntu/.bashrc