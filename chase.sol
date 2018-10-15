pragma solidity ^0.4.25;

contract ChaseContract{
    
    mapping (address => uint) private balances;
    address public owner;
    event depositSuccess(string printline, address etheraccount, uint amt);
    event withdrawSuccess(string printline, address etheraccount, uint amt);
    
    constructor() public {
        owner = msg.sender;
    }
    
    function deposit() public payable{
        balances[msg.sender] += msg.value;
        emit depositSuccess("Deposit Succesful!", msg.sender, msg.value);
    }
    
    function withdraw(uint amount) public {
       require (balances[msg.sender] >= amount);
            balances[msg.sender] -= amount;
            
            if(!msg.sender.send(amount)){
                balances[msg.sender] += amount;
            }
            else{
                emit withdrawSuccess("Withdrawal Successfull!", msg.sender, amount);
            }
        
    }
    
    function getBalance() public view returns (uint){
        return balances[msg.sender];
    }
    
}