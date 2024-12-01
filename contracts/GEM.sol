// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GEM is ERC20, ERC20Burnable, Ownable {
    uint256 public constant TOTAL_SUPPLY = 1_000_000_000 * 10 ** 18; // 1 billion tokens

    // Constructor with token allocation
    constructor(
        address _teamAndAdvisorsWallet,
        address _mineStakingPoolWallet,
        address _interactiveRewardPoolWallet
    ) ERC20("GemToken", "GEM") Ownable(msg.sender) {
        // Call the Ownable constructor to set the owner (deployer)
        transferOwnership(msg.sender); // Set the deployer as the initial owner

        require(_teamAndAdvisorsWallet != address(0), "Invalid team wallet");
        require(_mineStakingPoolWallet != address(0), "Invalid staking pool wallet");
        require(_interactiveRewardPoolWallet != address(0), "Invalid reward pool wallet");

        // Token allocation
        uint256 teamSupply = TOTAL_SUPPLY * 88 / 1000; // 8.8%
        uint256 mineStakingSupply = TOTAL_SUPPLY * 32 / 100; // 22%
        uint256 initialClaimSupply = TOTAL_SUPPLY * 42 / 1000; // 4.2%
        uint256 interactiveRewardSupply = TOTAL_SUPPLY - teamSupply - mineStakingSupply - initialClaimSupply;

        _mint(_teamAndAdvisorsWallet, teamSupply);
        _mint(_mineStakingPoolWallet, mineStakingSupply);
        _mint(msg.sender, initialClaimSupply); // Initial claim to deployer
        _mint(_interactiveRewardPoolWallet, interactiveRewardSupply);
    }
}
