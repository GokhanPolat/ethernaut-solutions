This repo contains [ethernaut](https://ethernaut.openzeppelin.com/) solution and exploits for hacking.

I did work on CoinFlip contract two different methods.

1. Exploiting with fork network for see actual code is working or not.
2. Creating test case and real contracts for see actual code working on real networks including test networks.

> As we always say DYOR.

# Run Project

## Installation

```shell
make install
```

## Update

```shell
make update
```

## Build

```shell
make build
```

## Test

For example:
Exploit CoinFlip contract

```shell
make coinflip-hack-goerli
```

## Getting Help

```shell
make # or make help
```

# Disclaimer

This repository does not constitute legal or investment advice. The preparers of this repository present it as an informational exercise documenting the due diligence involved in the secure development of the target contract only, and make no material claims or guarantees concerning the contract's operation post-deployment. The preparers of this repository assume no liability for any and all potential consequences of the deployment or use of this contract.

Importantly, the presented formal specification considers only the behaviors within the EVM, without considering the block/transaction level properties or off-chain behaviors, meaning that the verification result does not completely rule out the possibility of the contract being vulnerable to existing and/or unknown attacks.

Smart contracts are still a nascent software arena, and their deployment and public offering carries substantial risk. This repository makes no claims that its analysis is fully comprehensive, and recommends always seeking multiple opinions and audits.

This repository is also not comprehensive in scope, excluding a number of components critical to the correct operation of this system.

The possibility of human error in the manual review process is very real, and we recommend seeking multiple independent opinions on any claims which impact a large quantity of funds.
