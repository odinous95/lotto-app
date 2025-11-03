## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Project

This repository implements a lottery (lotto) decentralized application using Solidity smart contracts. It leverages Chainlink services for secure and automated operations:

- Chainlink Automation (Keepers) to trigger periodic upkeep (start/close the lottery and request winner selection).
- Chainlink VRF (Verifiable Random Function) to produce tamper-proof randomness for selecting the winner.

Key behaviors:

- Players enter the lottery by sending the required entry fee.
- The contract uses Automation to determine when to pick a winner.
- A VRF-provided random number chooses the winner; funds are transferred to the winner automatically.
- Mocks are used for local testing; real Chainlink addresses/subscriptions are used on testnets/mainnet.

Requirements:

- Foundry (forge, cast)
- Anvil for local testing
- RPC URL and private key for deployment to testnets/mainnet
- Chainlink VRF subscription ID, coordinator address, and keyHash for live networks

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

(Replace with your project's deploy script and provide Chainlink VRF/Automation configuration when deploying to public networks.)

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

# lotto-app
