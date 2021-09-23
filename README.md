# Cardano Stake Pool Ops

This project aims to be the most simple way to set up a Cardano Stake Pool (core & relay nodes) inside a secure, highly-available, and fault-tolerant AWS cloud network. It implements an easily configurable, yet a well-opinionated approach, based on some of the best practices found inside the community.

## 🐋 Features

- Most simple way to setup a secure "Cardano Stake Pool"
- Highly-available & fault-tolerant cloud
- Several management tools & beautiful graphs
- Secure by default

_Our managed pools offer a "High Pledge" and great rewards. Feel free to join! We would love to get to know you._

## Prerequisite

This guide assumes that you have `aws-cli` setup locally. It's an incredibly simple process and well explained within the official documentation that can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

Once you have the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed on your machine, run the following command to get authenticated:

```bash
aws configure

# next, let's install the serverless CLI tool and also authenticate into it
npm install -g serverless
serverless
```

Serverless is an amazing tool that _automates the setup of our AWS account._ It is important to note that while you configure your AWS account, you need to select a region that, at least, offers 3 Availability Zones, like `us-east-1`. View the regions you may select [here](./AWS_AZ_ZONES.md).

## Get Started

```bash
# 1. let's create a .env file and make sure to set all variables as appropriate
cp .env.example .env

# 2. now, we need to create a SSH key pair that can authenticate our device securely with AWS
./scripts/generate_ssh_key_pair.sh

# 3. if you are creating a development environment for testing purposes, run the following command
npm run create-aws-stake-pools:testnet # this may take around ~3h
## or else if you are provisioning a production environment, run this command
npm run create-aws-stake-pools:mainnet # this may take around ~8h
### during this process you will receive 2 emails asking you to confirm a "subscription" which are needed for our "system alerts"

# 4. you can now securely SSH into your Cardano node (navigate to AWS EC2 to figure out the host and use the port defined in .env)
ssh -i "~/.ssh/cardano-stake-pool.pem" ubuntu@ec2-12-68-116-220.compute-1.amazonaws.com -p 22

# 5. once ssh'ed into the machine, you can run gLiveView to check the status of the sync
gLiveView

# 6. once fully synced

```

Last but not least, you will need to still need to generate your cold keys and you may

## TODO

- create relay node 2 and the core node
- trigger all the alerts
- run gLiveView in the background after it is installed

## 🐙 Useful snippets

```bash
## if you want to remove the AWS resources out of your account. Please beware, this will delete your stake pool environment
npm run cleanup-aws:testnet
npm run cleanup-aws:mainnet

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

## Important notes

- On mainnet, you will need to regenerate the KES key every 90 days
- Cold keys must be generated and stored on your air-gapped offline machine
- Please test plenty in the testnet before launching a production node
- You may also want to check out the `.bash_aliases` file for some helpful shortcuts

## 📈 Changelog

Please see our [releases](https://github.com/meemalabs/cardano-stake-pool-aws/releases) page for more information on what has changed recently.

## 💪🏼 Contributing

Please see [CONTRIBUTING](.github/CONTRIBUTING.md) for details.

One important command oftentimes used when debugging is:

```bash
tail -f /var/log/cloud-init-output.log
```

This command will log the "user data" script that builds the AWS Ubuntu server.

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
