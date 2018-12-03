/*
    The simplest way to implement the Design Patterns Security Restrictions
    Author: LLEGO, JOHN MACHY R.

    Referenced from: ConsenSys Presentation, ConsenSys, Inc (2018)
                     Volland, Franz (2018), https://fravoll.github.io/solidity-patterns/
*/
pragma solidity ^0.4.24;

contract Atm{
    
    /* Access Restriction: Restrict the access to contract functionality according to suitable criteria.
         Use the Access Restriction pattern when
            your contract functions should only be callable under certain circumstances.
            you want to apply similar restrictions to several functions.
            you want to increase security of your smart contract against unauthorized access.
    */
    address owner;
    
    /* Guard Checks: Ensure that the behavior of a smart contract and its input parameters are as expected.
         Use the Guard Check pattern when
            you want to validate user inputs.
            you want to check the contract state before executing logic.
            you want to check invariants in your code.
            you want to rule out conditions that should not be possible.   
    */
    uint donate_amount = 2;
    
    /* Emergency Stop: Add an option to disable critical contract functionality in case of an emergency.
         Use the Emergency Stop pattern when
            you want to have the ability to pause your contract.
            you want to guard critical functionality against the abuse of undiscovered bugs.
            you want to prepare your contract for potential failures.
    */
    bool isStopped = false;
    
    /* Checks Effects Interactions: Reduce the attack surface for malicious contracts trying to hijack control flow after an external call.
         Use the Checks Effects Interactions pattern when
            it cannot be avoided to hand over control flow to an external entity.
            you want to guard your functions against re-entrancy attacks.
    */
    mapping(address => uint) balances;
    
    // Access Restriction
    constructor() payable public {
        owner = msg.sender;
    }
    
    // Access Restriction
    modifier onlyOwner {
        require(msg.sender==owner, "Not Authorized");
        _;
    }
    
    // Checks Effects Interactions
    function deposit() onlyOwner public payable {
        require(isStopped==false);
        balances[msg.sender] = msg.value;
    }
    
    function balance() onlyOwner public view returns (uint) {
        require(isStopped==false);
        return balances[msg.sender];
    }
    
    // Checks Effects Interactions, Guard Check, Pull Over Push, Secure Ether Transfer
    
    /* Secure Ether Transfer: Secure transfer of ether from a contract to another address.
        Use the Secure Ether Transfer pattern when
            you want to transfer ether from a contract address to another address in a secure way.
            you are not sure which method of ether transfer is the most suitable for your needs.
            you want to guard your contract against re-entrancy attacks.
    */
    function withdraw(uint amount) onlyOwner public {
        require(balances[msg.sender] >= amount && isStopped==false);
        balances[msg.sender] -= amount;
        msg.sender.transfer(amount);
    }
    
    // Emergency Stop
    function stopContract() onlyOwner public {
        isStopped = true;
    }
    
    // Emergency Stop
    function resumeContract()  onlyOwner public {
        isStopped = false;
    }
}