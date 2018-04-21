pragma solidity 0.4.21;

import "./SBAS.sol";


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


contract REMtoken is Ownable, SBAS { // тут должен быть не просто mapping balanceOf, а более сложная структура
    mapping (address => uint256) public balanceOf;
    address public appContract;
    address public sellerContract;
    bool public isActive;
    mapping (address => bool) public vendors;
    mapping (string => address) public certificates;

    function REMtoken() public {
        balanceOf[msg.sender] = 1000000000000000000;
        isActive = false;
    }

    function transfer(address _to, uint256 _value) public {
        require(msg.sender == sellerContract);
        require(balanceOf[msg.sender] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }

    function setAppContract(address _app) public onlyOwner {
        require(_app != address(0));
        appContract = _app;
        if (!isActive) {
            isActive = true;
        }
    }

    function setSellerContract(address _app) public onlyOwner {
        require(_app != address(0));
        sellerContract = _app;

    }

    function payment(address _from, uint _value) public returns (bool) {
        require(isActive);
        require(msg.sender == appContract);
        if (balanceOf[_from] >= _value) {
            balanceOf[appContract] += _value;
            balanceOf[_from] -= _value;
            return true;
        } else {
            return false;
        }
    }

    //TODO: передавать сюда name: string
    function addCertificate(address _from, uint _value) public returns (bool) {
        // isActive
        require(isActive);
        // request comes from Super-contract
        require(msg.sender == appContract);
        // certificate issuer is in Vendors list
        require(vendors[_from] == true);
        // issuer has enough tokens to produce certificate
        if (balanceOf[_from] >= _value) {
            balanceOf[appContract] += _value;
            balanceOf[_from] -= _value;
            return true;
        } else {
            return false;
        }
    }

    // вызывается из APP
    function addProvider(address _vendor) public {
        require(msg.sender == appContract);
        require(_vendor != address(0));
        require(vendors[_vendor] != false);
        vendors(_vendor) = true;
    }

    function checkProvider(address _provider) public veiw returns(bool) {
        return providers[_provider]
    }
}
