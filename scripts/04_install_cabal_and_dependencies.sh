#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install Cabal and its dependencies

eval "$(cat $HOME/.bashrc | tail -n +10)"

export BOOTSTRAP_HASKELL_NONINTERACTIVE=true
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

GHCUP_PROFILE_FILE="$HOME/.bashrc"
GHCUP_DIR="$HOME/.ghcup"

echo "[ -f \"${GHCUP_DIR}/env\" ] && source \"${GHCUP_DIR}/env\" # ghcup-env" >> "${GHCUP_PROFILE_FILE}"
eval "$(cat "${GHCUP_PROFILE_FILE}" | tail -n +10)"

ghcup upgrade
ghcup install ghc 8.10.4
ghcup set ghc 8.10.4
ghcup install cabal 3.4.0.0
ghcup set cabal 3.4.0.0

eval "$(cat $HOME/.bashrc | tail -n +10)"

cabal update
