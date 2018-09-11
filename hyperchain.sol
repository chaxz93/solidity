//auditchains token generation event (this is for demonstration purposes and not affiliated to any real organization)

//version of compiler
pragma solidity ^0.4.24;

contract audt_tge{
    
    //total audit supply for ico
    uint128 public audt_supply = 1200;
 
    //usdollar to audttokens conversion rate   
    uint128 public usd_to_audt = 4;

    //total number of audt bought by the people
    uint128 public total_audt_purchased = 0;

    //mapping from investor addresses to their audt and usdt equity
    mapping(address => uint128) audt_equity;
    mapping(address => uint128) usdt_equity;

    //checking if ico is complete or can more coins still be bought
    modifier can_buy_audt(uint128 usd_to_invest) {
        require (usd_to_invest*4 + total_audt_purchased <= audt_supply);    
        _;
    }
    
       //getting the equity in audt of an investor
    function equity_in_audt(address investor) external constant returns (uint128) {
        return audt_equity[investor];
    }
    
    //getting the equity in usdt of an investor
    function equity_in_usdt(address investor) external constant returns (uint128) {
        return usdt_equity[investor];
    }
    
    //buy audtcoins
    function invest_in_audt(address investor, uint128 usd_look_to_invest) external
    can_buy_audt(usd_look_to_invest) {
        uint128 audt_look_to_invest = usd_look_to_invest*usd_to_audt;
        audt_equity[investor] += audt_look_to_invest;
        usdt_equity[investor] = audt_equity[investor]/4;
        total_audt_purchased += audt_look_to_invest;
    }
    
    //sell audtcoins
     function profit_from_audt(address investor, uint128 audt_to_sell) external{
        audt_equity[investor] -= audt_to_sell;
        usdt_equity[investor] = audt_equity[investor]/4;
        total_audt_purchased -= audt_to_sell;
    }
}