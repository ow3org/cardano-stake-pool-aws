#!/usr/bin/env bash

# Maintainer: Meema Labs
# Telegram: https://telegram.meema.io
# Discord: https://discord.meema.io

# Let's install and configure the Cardano node onto our server.

eval "$(cat /home/ubuntu/.bashrc | tail -n +10)"

cat > $NODE_HOME/start_node.sh << EOF
#!/bin/bash
DIRECTORY=$NODE_HOME
PORT=6000
HOSTADDR=0.0.0.0
TOPOLOGY=\${DIRECTORY}/${NODE_CONFIG}-topology.json
DB_PATH=\${DIRECTORY}/db
SOCKET_PATH=\${DIRECTORY}/db/socket
CONFIG=\${DIRECTORY}/${NODE_CONFIG}-config.json
/usr/local/bin/cardano-node run --topology \${TOPOLOGY} --database-path \${DB_PATH} --socket-path \${SOCKET_PATH} --host-addr \${HOSTADDR} --port \${PORT} --config \${CONFIG}
EOF

chmod +x $NODE_HOME/start_node.sh

cat > $NODE_HOME/cardano-node.service << EOF
# The Cardano node service (part of systemd)
# file: /etc/systemd/system/cardano-node.service
[Unit]
Description = Cardano node service
Wants       = network-online.target
After       = network-online.target
[Service]
User              = ${USER}
Type              = simple
WorkingDirectory  = ${NODE_HOME}
ExecStart         = /bin/bash -c '${NODE_HOME}/start_node.sh'
KillSignal        = SIGINT
RestartKillSignal = SIGINT
TimeoutStopSec    = 2
LimitNOFILE       = 32768
Restart           = always
RestartSec        = 5
[Install]
WantedBy = multi-user.target
EOF

sudo cp $NODE_HOME/cardano-node.service /etc/systemd/system/cardano-node.service
sudo chmod 644 /etc/systemd/system/cardano-node.service

sudo systemctl daemon-reload
sudo systemctl enable cardano-node

sudo systemctl start cardano-node
