// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ERC-20.sol";

contract customERC20 is ERC20 {
    constructor() ERC20("SANTINO", "SA") {}

    function createTokens() public {
        _mint(msg.sender, 1000);
    }
}
