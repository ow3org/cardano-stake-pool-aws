#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install Cabal and its dependencies

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

cd /home/ubuntu/git

export BOOTSTRAP_HASKELL_NONINTERACTIVE=true
export GHCUP_PROFILE_FILE="/home/ubuntu/.bashrc"
export GHCUP_DIR="/home/ubuntu/.ghcup"
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

echo "[ -f \"${GHCUP_DIR}/env\" ] && source \"${GHCUP_DIR}/env\" # ghcup-env" >> "${GHCUP_PROFILE_FILE}"
eval "$(cat "${GHCUP_PROFILE_FILE}" | tail -n +10)"

ghcup upgrade
ghcup install ghc 8.10.4
ghcup set ghc 8.10.4
ghcup install cabal 3.4.0.0
ghcup set cabal 3.4.0.0

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

cabal update

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Total Time Took To Complete Script: $runtime seconds"
echo "Installed CABAL Version: $(cabal -V)"
echo "Installed GHC version: $(ghc -V)"
echo "Node Location: $NODE_HOME"
echo $banner
