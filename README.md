# STX Rainmaker Smart Contract

A Clarity smart contract for distributing STX tokens equally among registered users.

## Overview

STX Rainmaker is a simple token distribution system built on Stacks blockchain that allows:
- Users to register for STX distributions
- Contract owner to fund the contract
- Equal distribution of STX among all registered users

## Functions

### Public Functions

```clarity
(register) -> (response uint uint)
```
Allows any user to register for STX distributions. Returns the user's ID.

```clarity
(fund (amount uint)) -> (response uint uint)
```
Allows anyone to fund the contract with STX tokens.

```clarity
(rain) -> (response uint uint)
```
Owner-only function that distributes the contract's STX balance equally among registered users.

### Read-Only Functions

```clarity
(get-total-users) -> (response uint uint)
```
Returns the total number of registered users.

## Error Codes

- `ERR-NOT-OWNER (u100)`: Caller is not the contract owner
- `ERR-NO-USERS (u101)`: No users registered
- `ERR-EMPTY (u102)`: Contract has no STX balance

## Getting Started

1. Deploy the contract to the Stacks blockchain
2. Users can register using the `register` function
3. Fund the contract using the `fund` function
4. Contract owner can distribute funds using the `rain` function

## Testing

To test the contract locally:

1. Install [Clarinet](https://github.com/hirosystems/clarinet)
2. Run tests:
```bash
clarinet test
```
