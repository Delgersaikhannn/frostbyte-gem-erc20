// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GEMToken.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract GEMBurnable is GEMToken, ERC20Burnable {
    constructor(string memory name, string memory symbol) GEMToken(name, symbol) {}
}
