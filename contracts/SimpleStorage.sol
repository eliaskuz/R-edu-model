pragma solidity 0.4.19;


contract SimpleStorage {
    uint public myVariable;

    function set(uint x) public {
        myVariable = x;
    }

    function setWithError(uint x) public {
        while (true) {
            myVariable = x;
        }
    }

    function get() public constant returns (uint) {
        return myVariable;
    }
}