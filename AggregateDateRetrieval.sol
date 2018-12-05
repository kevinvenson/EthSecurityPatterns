/*  	https://fravoll.github.io/solidity-patterns
	https://fravoll.github.io/solidity-patterns/memory_array_building.html
	Reference from : Consensys Presentation (2018) */

pragma solidity 0.4.24;

contract MemoryArrayBuilding {

    struct Item {
        string name;
        string category;
        address owner;
        uint32 zipcode;
        uint32 price;
    }

    Item[] public items;

    mapping(address => uint) public ownerItemCount;

    function getItemIDsByOwner(address _owner) public view returns (uint[]) {
        uint[] memory result = new uint[](ownerItemCount[_owner]);
        uint counter = 0;
        
        for (uint i = 0; i < items.length; i++) {
            if (items[i].owner == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}