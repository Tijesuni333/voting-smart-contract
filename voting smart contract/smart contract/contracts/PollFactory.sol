// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract PollFactory {

  struct Poll {
    string name; 
    string[] options;
    mapping(address => uint) votes;
  }

  mapping(uint => Poll) public polls;
  uint public pollsCount;

  event PollCreated(uint id, string name);
  event Voted(uint pollId, uint optionId);

  function createPoll(string memory _name, string[] memory _options) public {
    pollsCount++;
    polls[pollsCount] = Poll({
      name: _name,
      options: _options,
      votes: new mapping(address => uint)
    });
    emit PollCreated(pollsCount, _name);
  }

  function getOptions(uint _pollId) public view returns(string[] memory) {
    return polls[_pollId].options;
  }

  function vote(uint _pollId, uint _optionId) public {
    require(!hasVoted(_pollId), "Already voted");
    Poll storage poll = polls[_pollId];
    require(_optionId < poll.options.length, "Invalid option");

    poll.votes[msg.sender] = _optionId;
    emit Voted(_pollId, _optionId);
  }

  function hasVoted(uint _pollId) public view returns(bool) {
    require(pollExists(_pollId), "Poll does not exist");
    return polls[_pollId].votes[msg.sender] != 0;
  }

  function pollExists(uint _pollId) public view returns(bool) {
    return polls[_pollId].options.length > 0;
  }

}