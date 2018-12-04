This solidity file is about voting.
1. Go to www.remix.ethereum.org
2. Copy and Paste the CommitReveal.sol file into the web (www.remix.ethereum.org)
3. Under the Compile Tab at the upper right hand side of the remix, Select the compiler version to 0.4.24
4. Click Start to Compile or CTRL + S
5. Go to the Run Tab beside Compile Tab and click Deploy
6. Once the Deploy is clicked, you would see that there's a Deployed Contracts, click the arrow beside the deployed contract (left side)
7. You would see a clickable commitVote, Election, revealVote, choice1, choice2, voteCommits, votesForChoice1, votesForChoice2.
8. First we would like to set how much time is allotted for Election, and the Participants. Under Election tab, click the arrow at the right hand side.
9. The _commitphase means how much time is allotted for the election and it is set to seconds. i.e. 1 hour = 3600 seconds, put it 3600. The _choice1 is the name of the first participant, and _choice2 is the name of the second name of the participant.
10. First we need to create hash to vote for our selected participants. Go to https://emn178.github.io/online-tools/keccak_256.html and put there your choice followed by hyphen and your password. i.e. 1-password123


For more comprehensive instructions, please go to:
https://karl.tech/learning-solidity-part-2-voting/