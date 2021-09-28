# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# custom aliases
alias gLiveView="$NODE_HOME/gLiveView.sh"

alias nodeStatus="sudo systemctl status cardano-node"
alias nodeLogs="journalctl --unit=cardano-node --follow"
alias nodeLogsToday="journalctl --unit=cardano-node --since=today"
alias nodeLogsYesterday="journalctl --unit=cardano-node --since=yesterday"

alias ~="cd $HOME"
alias home="cd $HOME"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias reloadshell="source $HOME/.bashrc"
alias helpers="cd $HELPERS"
alias scripts="cd $HELPERS/scripts"
alias node="cd $NODE_HOME"
alias start="sudo systemctl start cardano-node"
alias stop="sudo systemctl stop cardano-node"
alias restart="sudo systemctl reload-or-restart cardano-node"
alias nah="sudo git clean -df && sudo git reset --hard"
alias linkaliases="sudo ln -s $HELPERS/config/.bash_aliases $HOME/.bash_aliases"
alias systeminfo="sudo $HELPERS/scripts/system_info.sh"

# Stake Pool specific aliases
alias slotsPerKESPeriod=$(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
alias slotNo=$(cardano-cli query tip ${NETWORK_ARGUMENT}| jq -r '.slot')
alias currentSlot=slotNo
alias paymentBalance=$(cardano-cli query utxo --address $(cat $NODE_HOME/payment.addr) ${NETWORK_ARGUMENT})
# alias paymentBalance=$(cardano-cli query utxo --address $(cat $NODE_HOME/payment.addr) --testnet-magic 1097911063)
alias minPoolCost=$(cat $NODE_HOME/params.json | jq -r .minPoolCost)

# TODO: needs work still because updates does not persist custom edits
alias update="helpers; nah; sudo git pull; linkaliases; reloadshell"

# Add an "alert" alias for long running commands.  Use like so: (currently unused, but left in for convenience)
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
