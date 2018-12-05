/* https://ethereumdev.io/manage-several-contracts-with-factories/
https://medium.com/@i6mi6/solidty-smart-contracts-design-patterns-ecfa3b1e9784
nameregistry + factory contract
*/

pragma solidity ^0.4.24;
	//FACTORY CONTRACT
contract Car {

  // index of created contracts

  address[] public contracts;

  struct Details{
      address contractAddress;
  }
	//NAME REGISTRY  
  mapping(string => Details) registry;
  // useful to know the row count in contracts index
  function getContractCount() 
    public
    constant
    returns(uint contractCount)
  {
    return contracts.length;
  }

  // deploy a new contract

  function newCar(string _name)
    public
    returns(address newContract)
  {
    Details memory info;
    CarDetails c = new CarDetails();
    info.contractAddress = c;
    contracts.push(c);
    registry[_name] = info;
    return c;
  }
  
  function searchCarName(string _name) public constant returns(address){
      return (registry[_name].contractAddress);
  }
}
	//ASSET CONTRACT
contract CarDetails {

  // suppose the deployed contract has a purpose

  function getCarDetails() pure public returns (string)
  {
    return "car";
  }    
}