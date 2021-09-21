#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# This updates the SSH port to whatever is defined in your .env file to "harden your server."
## We need this step executed after we updated the server dependencies in "Step 1" because otherwise there will be install issues due to the sshd_config file having been modified.

eval "$(cat $HOME/.bashrc | tail -n +10)"

echo "PORT $SSH_PORT" | sudo tee -a /etc/ssh/sshd_config > /dev/null
sudo service ssh restart
