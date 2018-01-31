pragma solidity ^0.4.18;

// Contract is an extention on OpenZeppelin's contracts for safe maths and token base: https://github.com/OpenZeppelin/zeppelin-solidity

contract GweiIToken is StandardToken {
    
    address _owner;
    uint256 _weiToGweiI;
    
    function GweiIToken() public payable {
        totalSupply_ = 1000000000;
        balances[msg.sender] = 1000000000;
        _owner = msg.sender;
        _weiToGweiI = 8550000000000;
    }
    
    function getEthBalance() public view returns (uint256) {
        return this.balance;
    }
    
    function setConversion(uint256 exchangeRate) public {
        require(msg.sender == _owner);
        _weiToGweiI = exchangeRate;
    }
    
    function ethExchange(uint256 toExchange) payable external returns (bool) {
        require(toExchange <= balances[msg.sender]);

        // SafeMath.sub will throw if there is not enough balance.
        balances[msg.sender] = balances[msg.sender].sub(toExchange);
        balances[_owner] = balances[_owner].add(toExchange);
        Transfer(msg.sender, _owner, toExchange);
        
        uint amountToPay = SafeMath.mul(toExchange, _weiToGweiI);
        if (!msg.sender.send(amountToPay)) {
            balances[msg.sender] = balances[msg.sender].add(toExchange);
            return false;
        }
        return true;
    }
}
