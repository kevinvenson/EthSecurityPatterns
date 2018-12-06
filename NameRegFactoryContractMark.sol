/*
exercise code
STRING COMPARISON
NAME REGISTRY
FACTORY CONTRACT

*/

pragma solidity ^0.4.24;
// FACTORY CONTRACT
contract QuizFactory {
    
    address[] public quizzes;
    
    function createQuiz(string _question, bytes32 _sealedAnswer)
    public returns(address){
        
        Quiz newQuiz = new Quiz(msg.sender, _question,
        _sealedAnswer);
        
            quizzes.push(newQuiz);
            return newQuiz;
    }
}
// ASSET CONTRACT (part of FACTORY CONTRACT)     
    contract Quiz {
        address owner;
        string question;
        
        string public revealedAnswer;
        string public saltAnswer;
        
        bytes32 public sealedAnswer;
        
        uint public winnersCount;
        
        uint creationTimestamp = now;
        
        struct Guess {
            bytes32 sealedGuess;
            string revealedGuess;
            string saltGuess;
            
            
        }
        
        constructor(address _owner, string _question,
        bytes32 _sealedAnswer) payable public {
            owner = _owner;
            question = _question;
            sealedAnswer = _sealedAnswer;
        }
//NAME REGISTRY        
        mapping(address => Guess) public guesses;
        uint public guessesCount;
        modifier onlyOwner() {
            
            require(msg.sender == owner);
            _;
        }
//STATE MACHINE        
        modifier onlyPeriod(uint fromDays, uint toDays) {
            require(now >= creationTimestamp + fromDays * 1 days
            && now < creationTimestamp + toDays * 1 days);
            
            _;
            
        }
// STRING COMPARISON        
        function compareStrings(string _a, string _b) pure private
        returns(bool) {
            if (bytes(_a).length == bytes(_b).length){
                
                return keccak256(_a) == keccak256(_b);
            } else {
                return false;
            }
        }
        
        function commitGuess(bytes32 _sealedGuess) onlyPeriod(0,7)
        payable public {
            require(msg.value >= 1 ether);
            Guess memory newGuess;
            newGuess.sealedGuess = _sealedGuess;
            guesses[msg.sender] = newGuess;
            guessesCount++;
            if (msg.value > 1 ether){
                address(msg.sender).transfer(msg.value - 1 ether);
            }
        }
        
        function revealAnswer(string _revealedAnswer, string _saltAnswer)
        onlyOwner onlyPeriod(7,14) public {
            
            if (sealedAnswer == keccak256(_revealedAnswer, _saltAnswer)){
                
                revealedAnswer = _revealedAnswer;
                saltAnswer = _saltAnswer;
            } else {
                revert();
            }
        }
        
        function revealGuess(string _revealedGuess, string _saltGuess)
        onlyPeriod(14, 21) public {
            require(guesses[msg.sender].sealedGuess != 0x0);
            require(bytes(guesses[msg.sender].revealedGuess).length == 0);
            
            if(guesses[msg.sender].sealedGuess == keccak256(_revealedGuess, _saltGuess)) {
                guesses[msg.sender].revealedGuess = _revealedGuess;
                guesses[msg.sender].saltGuess = _saltGuess;
                
                if(compareStrings(_revealedGuess, revealedAnswer) ||
                bytes(revealedAnswer).length == 0){
                    winnersCount++;
                } 
            } else {
                revert();
            }
        }
        
        function withdrawPrize() onlyPeriod(21, 28) public {
            
            if(winnersCount > 0 ) {
                require(compareStrings(guesses[msg.sender].revealedGuess,revealedAnswer));
            } else {
                winnersCount = guessesCount;
            }
            
            delete guesses[msg.sender];
            address(msg.sender).transfer(guessesCount / winnersCount * 1 ether);
            
            assert(guesses[msg.sender].sealedGuess == 0x0);
        }
// CONTRACT DESTRUCTION        
        function destroyQuiz() onlyOwner onlyPeriod(28, 365) public {
            selfdestruct(owner);
        }
        
        
}