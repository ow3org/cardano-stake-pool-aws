#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install Cabal and its dependencies

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

export BOOTSTRAP_HASKELL_NONINTERACTIVE=true
export BOOTSTRAP_HASKELL_GHC_VERSION=8.10.4
export BOOTSTRAP_HASKELL_CABAL_VERSION=3.4.0.0

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

GHCUP_PROFILE_FILE="/home/ubuntu/.bashrc"
GHCUP_DIR="/home/ubuntu/.ghcup"
echo "[ -f \"${GHCUP_DIR}/env\" ] && source \"${GHCUP_DIR}/env\" # ghcup-env" >> "${GHCUP_PROFILE_FILE}"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

ghcup upgrade

echo "Installing GHC v${BOOTSTRAP_HASKELL_GHC_VERSION} ..."
ghcup install ghc ${BOOTSTRAP_HASKELL_GHC_VERSION}
ghcup set ghc ${BOOTSTRAP_HASKELL_GHC_VERSION}

echo "Installing Cabal v${BOOTSTRAP_HASKELL_CABAL_VERSION}.."
ghcup install cabal ${BOOTSTRAP_HASKELL_CABAL_VERSION}
ghcup set cabal ${BOOTSTRAP_HASKELL_CABAL_VERSION}

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

cabal update

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "Installed GHC version: $(ghc -V)"
echo "Installed Cabal version: $(cabal -V)"
echo "Cardano Node location: $NODE_HOME"
echo $banner
