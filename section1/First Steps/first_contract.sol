pragma solidity ^0.4.26;
import "./ERC20.sol";

contract firstContract {

    address owner;
    ERC20Basic token;

    constructor() public {
        owner = msg.sender;
        token = new ERC20Basic(1000);
    }

}