pragma solidity 0.4.21;


interface AppToken {
    function payment(address _from, uint value) public returns (bool);
}


contract Ownable {
    address public owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function Ownable() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}


contract App is Ownable {
    string public message;
    address public lastDonator;
    AppToken public token;
    uint public price = 10;

    function App(AppToken _token) {
        token = _token;
    }

    function setPrice(uint _price) public onlyOwner {
        price = _price;
    }

    function setMessage(string _message) public returns (bool) {
        if (token.payment(msg.sender, price)) {
            message = _message;
            likes += 1;
            lastDonator = msg.sender;
            return true;
        } else {
            return false;
        }
    }
}
