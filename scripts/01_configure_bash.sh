#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Configures bash with a set of aliases and required variables.

eval "$(cat $HOME/.bashrc | tail -n +10)"

echo export NODE_HOME="$HOME/cardano-my-node" >> $HOME/.bashrc
echo export NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> $HOME/.bashrc
echo export CARDANO_NODE_SOCKET_PATH="$NODE_HOME/db/socket" >> $HOME/.bashrc

# CNODE_HOME is the same variable as NODE_HOME, but we need to keep this alias around because
# it is a variable that's used in guild-operator's cnode-helper-scripts
echo export CNODE_HOME="$HOME/cardano-my-node" >> $HOME/.bashrc

# needed when configuring libsodium
echo PATH="$HOME/.local/bin:$PATH" >> $HOME/.bashrc
echo export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> $HOME/.bashrc

# sudo ln -s $HOME/cardano-helpers/config/.bashrc $HOME/.bashrc # TODO: figure out how to properly set variables from the UserData script
sudo ln -s $HOME/cardano-helpers/config/.bash_aliases $HOME/.bash_aliases

source $HOME/.bashrc
