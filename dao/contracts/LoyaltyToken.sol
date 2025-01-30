// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LoyaltyToken is ERC20, Ownable {
    constructor() ERC20("LoyaltyToken", "LOY") Ownable(msg.sender) {
        _mint(msg.sender, 10 * (10 ** decimals()));
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount * (10 ** decimals()));
    }

    function burnFrom(address burner, uint256 amount) public onlyOwner {
        _burn(burner, amount * (10 ** decimals()));
    }
}