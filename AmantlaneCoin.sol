// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title AmantlaneCoin
 * @author Amantlane core engineering
 * @notice Fixed-supply enterprise utility token with native deflationary burn mechanisms.
 */
contract AmantlaneCoin is ERC20, ERC20Burnable, Ownable {

    error MintLimitExceeded();
    error InvalidTargetAddress();

    uint256 public immutable MAX_SUPPLY;

    constructor(
        address initialOwner, 
        uint256 supplyCap
    ) 
        ERC20("Amantlane Coin", "AMNT") 
        Ownable(initialOwner) 
    {
        if (initialOwner == address(0)) revert InvalidTargetAddress();
        if (supplyCap == 0) revert MintLimitExceeded();
        
        MAX_SUPPLY = supplyCap;
        _mint(initialOwner, supplyCap);
    }

    function burnToken(uint256 amount) external {
        burn(amount);
    }
}
