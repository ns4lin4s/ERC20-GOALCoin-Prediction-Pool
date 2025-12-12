// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GOALCoin is ERC20 {
    
    constructor(string memory name_, string memory symbol_) ERC20(name_,symbol_) {
        _mint(msg.sender, 1000*1e18);
    }

    function _update(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        
        // the address ('to') can't be the current contract address
        // address(this) represent the address GOALCoin contract.
        require(to != address(this), "GOALCoin: Cannot transfer tokens to the contract address.");
        
        super._update(from, to, amount);
    }
}