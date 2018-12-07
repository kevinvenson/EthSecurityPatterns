/*
    The simplest way to implement the Design Patterns: Security and Programming(String Comparison)
    Referenced from: ConsenSys Presentation, ConsenSys, Inc (2018)
*/
pragma solidity ^0.4.24;

contract Atm{
    string pass;
    // access restriction
    address owner;
    
    // guard checks
    uint donate_amount = 2;
    
    //emergency stop
    bool isStopped = false;
    
    // checks effects interactions
    mapping(address => uint) balances;
    
    // access restriction
    constructor() payable public {
        owner = msg.sender;
    }
    
    // access restriction
    modifier onlyOwner {
        require(msg.sender==owner, "Not Authorized");
        _;
    }
    //StringComparison
    function enterPassword (string _pass) onlyOwner public {
        pass = _pass;
    }
    function verifyPassword(string pass, string passd) pure public returns(bool){
        if (bytes(pass).length == bytes(passd).length) {
            return keccak256(abi.encodePacked(pass)) == keccak256(abi.encodePacked(passd));
        } 
        else { 
            return false;
        }
    }
    function getAccountInfo () public view returns (string, address) {
        return (pass, owner);
    }
    
    // checks effects interactions
    function deposit() onlyOwner public payable {
        require(isStopped==false);
        balances[msg.sender] = msg.value;
    }
    
    function balance() onlyOwner public view returns (uint) {
        require(isStopped==false);
        return balances[msg.sender];
    }
    
    // checks effects interactions, guard check, pull over push, secure ether transfer
    function withdraw(uint amount) onlyOwner public {
        require(balances[msg.sender] >= amount && isStopped==false);
        balances[msg.sender] -= amount;
        msg.sender.transfer(amount);
    }
}