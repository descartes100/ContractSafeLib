# Welcome to ContractSafeLib! 🎉

This module is the safest place to be for smart contract security! 🔒 Here's a quick rundown of what you'll find inside:

## bestPractice 📁

This folder is where all the best practices happen! 💡 You'll find two important files in here:

- ownerAccess.sol 👑: This file allows the owner to access specific functions.
- roleAccess.sol 👥: This file allows specific accounts to access specific functions by inheriting the RoleAccess contract.

## utilTools 📁

This folder is where we keep all our utility tools 🔧. Feel free to use them whenever you need to make your smart contracts even smarter! Here's a brief explanation of each file:

- mathGuard.sol ➕: Use this file for safe math calculations.
- payGuard.sol 💰: Inherit this file to let payers withdraw their payments themselves and avoid direct contract calling.
- reentrancyGuard.sol 🔒: Inherit from this file and use the nonReentrant modifier to guard functions against reentrancy attacks.
- urgentGuard.sol 🚨: Inherit from this file to make your functions only callable when in urgency or not in urgency to protect your contracts.

Thanks for choosing ContractSafeLib! 😊
