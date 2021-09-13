#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram Channel: https://telegram.meema.io
# Discord: https://discord.meema.io

# Install gLiveView Monitoring tool.

cd $HOME/cardano-helpers

sudo ln -s ./config/.bash_aliases $HOME/.bash_aliases

cat > $HOME/.bashrc << EOF
if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi
EOF
