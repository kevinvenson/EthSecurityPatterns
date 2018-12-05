/*  	https://github.com/ltfschoen/dex/commit/36583c0b64311b6cdc3264c8cc61df989b334317
	https://www.reddit.com/r/ethdev/comments/6rx9nf/is_this_a_valid_way_of_comparing_strings_in/
    String Comparison
*/

pragma solidity 0.4.24;

contract StringComparison {
    string pass;
    string uname;
    
    function enterUsername (string _uname) public {
        uname = _uname;
    }
    
    function enterPassword (string _pass) public {
        pass = _pass;
    }
    
    function verifyPassword(string pass, string passd) pure private returns(bool){
        if (bytes(pass).length == bytes(passd).length) {
            return keccak256(abi.encodePacked(pass)) == keccak256(abi.encodePacked(passd));
        } 
        else { 
            return false;
        }
    }
    
    function getAccountInfo () public view returns (string, string) {
        return (pass, uname);
    }
    
    
}