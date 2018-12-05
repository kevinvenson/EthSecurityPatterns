//  https://fravoll.github.io/solidity-patterns
//  https://fravoll.github.io/solidity-patterns/eternal_storage.html
//  https://fravoll.github.io/solidity-patterns/proxy_delegate.html

pragma solidity 0.4.24;

contract EternalProxy {
    address delegate;
    address owner = msg.sender;
    address latestVersion;
    mapping(bytes32 => uint) uIntStorage;
    
    function upgradeVersion(address _newVersion) public {
        require(msg.sender == owner);
        latestVersion = _newVersion;
    }
    
    function getUint(bytes32 _key) external view returns(uint) {
        return uIntStorage[_key]; 
        
    }
    
    function setUint(bytes32 _key, uint _value) external {
        require(msg.sender == latestVersion);    
        uIntStorage[_key] = _value; 
        
    }
    
    function deleteUint(bytes32 _key) external { 
        require(msg.sender == latestVersion); 
        delete uIntStorage[_key]; 
        
    }
    
    function upgradeDelegate(address _newAddress) public { 
        require(msg.sender == owner); 
        delegate = _newAddress; 
    }
    
    function() external payable { 
        assembly {
            let _addr := sload(0)
            calldatacopy(0x0, 0x0, calldatasize) 
            let res := delegatecall(gas, _addr, 0x0, calldatasize, 0x0, 0) 
            returndatacopy(0x0, 0x0, returndatasize)
            switch res case 0 { revert(0, 0)
        }                       
            default { return (0, returndatasize) 
                
            }        
            
        }    
        
    }

}