pragma solidity 0.4.21;


interface MyFirstERC20ICO {
    function transfer (address _receiver, uint256 _amount) public;
}


contract MyFirstSafeICO {

    uint public buyPrice;
    MyFirstERC20ICO public token;

    function MyFirstSafeICO(MyFirstERC20ICO _token) public {
        token = _token;
        buyPrice = 1 finney;
    }

    function () payable { // должна быть более сложная функция, с указанием какой ролью хотим воспользоваться
        _buy(msg.sender, msg.value);
    }

    function buy() public payable returns (uint) {
        uint tokens = _buy(msg.sender, msg.value);
        return tokens;
    }

    function _buy(address _sender, uint256 _amount) internal returns (uint) {
        uint tokens = _amount / buyPrice;
        token.transfer(_sender, tokens);
        return tokens;
    }
}
    //также добавить функцию оплаты % на развитие системы