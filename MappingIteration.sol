// https://medium.com/@i6mi6/solidty-smart-contracts-design-patterns-ecfa3b1e9784

pragma solidity 0.4.24;

contract MappingIterator {
   mapping(string => address) elements;
   string[] keys;
   function put(string key, address addr) public returns (bool) {
      bool exists = elements[key] != address(0);
      if (!exists) {
         keys.push(key);
      }
      elements[key] = addr;
      return true;
    }
    function getKeyCount() public constant returns (uint) {
       return keys.length;
    }
    function getElementAtIndex(uint index) public view returns (address) {
       return elements[keys[index]];
    }
    function getElement(string name) public view returns (address) {
       return elements[name];
    }
}