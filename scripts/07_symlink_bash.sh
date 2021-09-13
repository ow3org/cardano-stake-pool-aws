#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram Channel: https://telegram.meema.io
# Discord: https://discord.meema.io

# Install gLiveView Monitoring tool.

cd $HOME/cardano-helpers

sudo ln -s $HOME/cardano-helpers/config/.bashrc $HOME/.bashrc
sudo ln -s $HOME/cardano-helpers/config/.bash_aliases $HOME/.bash_aliases

eval "$(cat $HOME/.bashrc | tail -n +10)"
