// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {Owned} from "solmate/auth/Owned.sol";

contract MockToken is ERC20, Owned(msg.sender) {
    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_, 18) {
        _mint(msg.sender, type(uint256).max);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        return _mint(to, amount);
    }
}
