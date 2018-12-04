/* The simplest way to implement the Behavioral Pattern: State Machine 
    	Tandang, Kevin Venson M.
	Reference from: ConsenSys Presentation, ConsenSys, Inc (2018)
*/

pragma solidity 0.4.24;

contract Atm {

enum Stages { 
	Deposits, 
	Withdraws 
    } 
Stages public stage = Stages.Deposits; 
mapping(address => uint) balances; 
uint creationTime = now;

    function deposit() payable public {
        stage = Stages.Deposits;
        require(stage == Stages.Deposits && msg.value > 0);
        balances[msg.sender] = msg.value;
    }    
    function withdraw(uint amount) payable public {
        if(stage != Stages.Withdraws && now >= creationTime + 1 seconds) {
            stage = Stages.Withdraws;
        }
            require(stage == Stages.Withdraws && balances[msg.sender] > 0);
            balances[msg.sender] -= amount;
            msg.sender.transfer(amount); 
    }
    function viewBalance() public view returns (uint) {
        return balances[msg.sender];
        }   
}