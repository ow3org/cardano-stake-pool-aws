#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram Channel: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install Cabal and its dependencies

export BOOTSTRAP_HASKELL_NONINTERACTIVE=true
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

GHCUP_PROFILE_FILE="$HOME/.bashrc"
GHCUP_DIR=$HOME/.ghcup
echo "[ -f \"${GHCUP_DIR}/env\" ] && source \"${GHCUP_DIR}/env\" # ghcup-env" >> "${GHCUP_PROFILE_FILE}"
eval "$(cat "${GHCUP_PROFILE_FILE}" | tail -n +10)"

ghcup upgrade
ghcup install ghc 8.10.4
ghcup set ghc 8.10.4
ghcup install cabal 3.4.0.0
ghcup set cabal 3.4.0.0

echo PATH="$HOME/.local/bin:$PATH" >> $HOME/.bashrc
echo export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> $HOME/.bashrc
echo export NODE_HOME=$HOME/cardano-my-node >> $HOME/.bashrc
# CNODE_HOME is the same variable as NODE_HOME, but we need to keep this alias around because
# it is a variable that's used in guild-operator's cnode-helper-scripts
echo export CNODE_HOME=$HOME/cardano-my-node >> $HOME/.bashrc

# TODO: document how to use testnet
echo export NODE_CONFIG=mainnet >> $HOME/.bashrc
echo export NODE_BUILD_NUM=$(curl https://hydra.iohk.io/job/Cardano/iohk-nix/cardano-deployment/latest-finished/download/1/index.html | grep -e "build" | sed 's/.*build\/\([0-9]*\)\/download.*/\1/g') >> $HOME/.bashrc
eval "$(cat $HOME/.bashrc | tail -n +10)"

cabal update
