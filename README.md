# Cardano Stake Pool Ops

This project aims to be the most simple way to set up a Cardano Stake Pool (Block Producer & Relay nodes) inside a secure, highly-available, and fault-tolerant AWS cloud network. It implements an easily configurable, yet a well-opinionated approach, based on some of the best practices found inside the community. Soon, we intend on providing the script for other cloud providers & custom environments.

## 🐋 Features

- Installs latest `cardano-node` v1.30.1
- Secure by default
- Most simple AWS setup with 1 Core & 2 Relay nodes
- Automatic alarms & notifications for CPU, RAM and storage alerts
- Useful management tools & beautiful graphs

Thanks to the Guild Operators who have created some great tooling for Stake Pool Operators (SPO).

_Our managed pools offer not only a "High Pledge" but also provide a lot of utility & rewards for simply being a member. Feel free to reach out! We would love to get to know you._

## Prerequisite

This guide assumes that you have `aws-cli` set up locally. It's an incredibly simple process and well-explained within the official documentation that can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

Once you have the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed on your machine, run the following command to get authenticated:

```bash
aws configure

# next, let's install the `serverless`-CLI tool & authenticate it
npm install -g serverless
serverless
```

Serverless is an amazing tool that _automates the setup of our AWS account._ It is important to note that while you configure your AWS account, you need to select a region that, at minimum, offers 3 Availability Zones, like `us-east-1`. View the regions you may select [here](./docs/AWS_AZ_ZONES.md).

## Get Started

```bash
# 1. let's create a .env file and make sure to set all variables as appropriate
cp .env.example .env

# 2. now, we need to create a SSH key pair that can authenticate our device securely with AWS
./scripts/generate_ssh_key_pair.sh

# 3. next, let's create your Stake Pool environment including 1x Block Producer node & 2x Relay nodes
npm run build:stake-pool # this will take ~3 hours for `testnet` nodes & ~8 hours for `mainnet` nodes

## during this process, you will receive 2 emails asking to confirm a "subscription" which is required in order for you to receive "system alerts"

# 4. you can now securely SSH into your Cardano node (navigate to AWS EC2 to figure out the host and use the port defined in .env)
ssh -i "cardano-stake-pool.pem" ubuntu@ec2-12-68-116-220.compute-1.amazonaws.com -p 22

# 5. at this point, we assume the node is in sync with the blockchain which then allows us to create the block producer node keys and certificate.
./scripts/generate_block_producer_keys.sh # please only run this command on your core node & read the comments for details


```

## 🐙 Useful commands

```bash
## "Cardano Node"-specific commands
start # starts the "Block Producer" or a "Relay" node
restart # restarts the node service
stop # stops the node service
status # view the status of your node
update # alpha: updates the node

## viewing & filtering logs
logs
logsToday
logsYesterday
journalctl --unit=cnode --since='2021-09-01 00:00:00' --until='2021-09-30 12:00:00'
logMonitor # monitors the Cardano Node log
creationLogMonitor # monitors the log output of the "User Data" script (mostly the `build_node.sh` log output)

## other useful commands
gLiveView
systemInfo # displays system info about your server

## please beware, this will delete your AWS stake pool resources
npm run cleanup # cleans all environments
npm run cleanup:guild
npm run cleanup:testnet
npm run cleanup:mainnet
```

## Important notes

- In `mainnet`, you will need to regenerate the KES key every 90 days (use our provided script - will be automated in future release)
- Cold Keys must be generated and stored on your air-gapped offline machine
- Exercise plenty in a "test network" before operating a `mainnet` node

You may also want to check out the `aliases`-file for some helpful shortcuts.

## 📈 Changelog

Please see our [releases](https://github.com/meemalabs/cardano-stake-pool-aws/releases) page for more information on what has changed recently.

## 💪🏼 Contributing

Please see [CONTRIBUTING](.github/CONTRIBUTING.md) for details.

One important command oftentimes used when debugging is:

```bash
tail -f /var/log/cloud-init-output.log # alias `monitorNodeCreationLogs`
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

- [Guild Operators](https://github.com/cardano-community/guild-operators/)
- [Chris Breuer](https://github.com/Chris1904)
- [Folks at Meema](https://github.com/meemalabs)
- [All Contributors](../../contributors)

## 📄 License

The MIT License (MIT). Please see [LICENSE](LICENSE.md) for more information.

Made with ❤️ by Meema, Inc.
