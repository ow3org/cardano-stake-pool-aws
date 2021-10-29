#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install all of our Cardano Node dependencies to ensure we are up to date and have all the latest security and bug fixes included.

start=`date +%s.%N`

banner="--------------------------------------------------------------------------"

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

mkdir $HOME/tmp
cd $HOME/tmp

#INTERACTIVE='N'        # Interactive mode (Default: silent mode)
NETWORK='testnet'      # Connect to specified network instead of public network (Default: connect to public cardano network)
#WANT_BUILD_DEPS='Y'    # Skip installing OS level dependencies (Default: will check and install any missing OS level prerequisites)
#FORCE_OVERWRITE='N'    # Force overwrite of all files including normally saved user config sections in env, cnode.sh and gLiveView.sh
                        # topology.json, config.json and genesis files normally saved will also be overwritten
#LIBSODIUM_FORK='Y'     # Use IOG fork of libsodium instead of official repositories - Recommended as per IOG instructions (Default: IOG fork)
INSTALL_CNCLI='Y'      # Install/Upgrade and build CNCLI with RUST
INSTALL_VCHC='Y'       # Install/Upgrade Vacuumlabs cardano-hw-cli for hardware wallet support
#CNODE_NAME='cnode'     # Alternate name for top level folder, non alpha-numeric chars will be replaced with underscore (Default: cnode)
#CURL_TIMEOUT=60        # Maximum time in seconds that you allow the file download operation to take before aborting (Default: 60s)
#UPDATE_CHECK='Y'       # Check if there is an updated version of prereqs.sh script to download
#SUDO='Y'               # Used by docker builds to disable sudo, leave unchanged if unsure.

curl -sS -o prereqs.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/prereqs.sh
chmod 755 prereqs.sh
./prereqs.sh

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

end=`date +%s.%N`
runtime=$( echo "$end - $start" | bc -l ) || true

echo $banner
echo "Script runtime: $runtime seconds"
echo "Finished installing server dependencies"
echo $banner
