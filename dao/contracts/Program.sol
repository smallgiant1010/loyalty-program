// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Program {
    struct ItemCost {
        uint256 tokenCost;
        uint256 stock;
        bool isSet;
    }
    address public owner;
    mapping(string => ItemCost) public purchasableItems;
    string[] public itemNames;
    IERC20 public loyaltyToken;

    constructor(string[] memory _itemNames, uint256[] memory _tokenCosts, uint256[] memory _stocks, address _tokenAddress) {
        for(uint256 i = 0; i < _itemNames.length; i++) {
            itemNames.push(_itemNames[i]);
            purchasableItems[_itemNames[i]] = ItemCost({ tokenCost: _tokenCosts[i], stock: _stocks[i], isSet: true });
            loyaltyToken = IERC20(_tokenAddress);
        }
        owner = msg.sender;
    }

    function hasBalance(string memory _itemName) private view returns(bool) {
        return purchasableItems[_itemName].isSet;
    }

    function addItem(string memory _itemName, uint256 _tokenCost, uint256 _initialStock) public {
        require(!hasBalance(_itemName), "Item Already Exists");
        purchasableItems[_itemName] = ItemCost({ tokenCost: _tokenCost, stock: _initialStock, isSet: true });
        itemNames.push(_itemName);
    }

    function removeItem(string memory _itemName) public {
        require(hasBalance(_itemName), "Item does not Exist");
        require(purchasableItems[_itemName].stock >= 0, "Item Out of Stock");
        purchasableItems[_itemName].stock--;
        if(purchasableItems[_itemName].stock == 0) {
            delete purchasableItems[_itemName];
        }
    }

    function getAllItems() public view returns(string[] memory, uint256[] memory, uint256[] memory) {
        uint256 len = itemNames.length;
        uint256 index = 0;
        string[] memory names = new string[](len);
        uint256[] memory tokenCosts = new uint256[](len);
        uint256[] memory stocks = new uint256[](len);
        for(uint256 i = 0;i < len;i++) {
            if(hasBalance(itemNames[i])) {
                ItemCost memory itemCost = purchasableItems[itemNames[i]];
                names[index] = itemNames[i];
                tokenCosts[index] = itemCost.tokenCost;
                stocks[index] = itemCost.stock;
                index++;
            }
        }

        return (names, tokenCosts, stocks);
    }
    
}