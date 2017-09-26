pragma solidity ^0.4.4;

contract Adoption {
	address[16] public adopters;
	address owner;

	function Adoption () {
		owner = msg.sender;
	}

	function GetOwner() returns (address) {
		return owner;
	}
}
