# Cardano Stake Pool Ops

This project aims to simplify the setup of a Cardano Stake Pool (core & relay nodes) by implementing a dead simple setup to get up and running quickly and, most importantly, securely inside the AWS cloud.

## 🐋 Features

- Most simple way to setup a secure "Cardano Stake Pool"
- Well configured AWS cloud
- Management tools & beautiful graphs

Our managed pools offer a "High Pledge" and great rewards. Feel free to join! We would love to get to know you.

## Prerequisite

This guide assumes that you have `aws-cli` setup locally. It's an incredibly simple process and well explained within the official documentation that can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

Once you have the `aws` binary installed on your machine, run the following command to get authenticated:

```bash
# follow the prompts
aws configure
```

## TODO

- make sure the initial relay node is created
- create an image of the relay node
- create relay node 2 and the core node
- trigger all the alerts
- create a local Docker env for the cold machine

## 🐙 Usage

```bash
# Useful snippets
## Starting the "Block Producer Node" or one of the "Relay Nodes"
sudo systemctl start cardano-node

## Restarting the node service
sudo systemctl reload-or-restart cardano-node

## Stopping the node service
sudo systemctl stop cardano-node

## Viewing & filtering logs
journalctl --unit=cardano-node --follow
journalctl --unit=cardano-node --since=yesterday
journalctl --unit=cardano-node --since=today
journalctl --unit=cardano-node --since='2021-09-01 00:00:00' --until='2021-09-30 12:00:00'
```

### How to use the testnet?

When testing the nodes, it is important you practice enough in the testnet first before moving to the mainnet. While this guide explains how to get setup for the mainnet, simply run the following command:

```bash
echo export NODE_CONFIG=testnet >> $HOME/.bashrc
source $HOME/.bashrc
```

In other words, you simply have to ensure the `NODE_CONFIG` variable is set to `testnet`.

Additionally, when using the `cardano-cli`, make sure you do not use the `--mainnet` parameter but rather use `--testnet-magic 1097911063` instead.

## 📈 Changelog

Please see our [releases](https://github.com/meemalabs/cardano-stake-pool-aws/releases) page for more information on what has changed recently.

## 💪🏼 Contributing

Please see [CONTRIBUTING](.github/CONTRIBUTING.md) for details.

## 🏝 Community

For help, discussion about best practices, or any other conversation that would benefit from being searchable:

[Stake Pool Discussion on GitHub](https://github.com/meemalabs/cardano-stake-pool-aws/discussions)

For casual chit-chat with others using this package:

[Join the Stake Pool Discord Server](https://discord.meema.io)

## 🚨 Security

Please review [our security policy](https://github.com/meemalabs/cardano-stake-pool-aws/security/policy) on how to report security vulnerabilities.

## 🙏🏼 Credits

- [Chris Breuer](https://github.com/Chris1904)
- [Folks at Meema](https://github.com/meemalabs)
- [All Contributors](../../contributors)

## 📄 License

The MIT License (MIT). Please see [LICENSE](LICENSE.md) for more information.

Made with ❤️ by Meema, Inc.
