// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract OMS_COVID {

    address public OMS;

    constructor () public {
        OMS = msg.sender;
    }

    mapping (address => bool) public centersValidated;

    address [] public center_addresses;

    address [] AccessRequests;

    event NewValidatedCenter (address);
    event NewContract (address, address);
    event AccessRequest(address);

    modifier OwnerOnly(address _address) {
        require(_address == OMS,"Not the owner");
                _;
    }

    function RequestAccess() public {
        AccessRequests.push(msg.sender);
        emit AccessRequest(msg.sender);
    }

    function RequestedAddresses() view public OwnerOnly(msg.sender) returns (address[] memory){
        return AccessRequests;
    }

    function validateCenter(address center) public OwnerOnly(msg.sender) {
        centersValidated[center] = true;
        emit NewValidatedCenter(center);
    }

    function FactoryCenter() public {
        require(centersValidated[msg.sender] == true, "Not enough permissions");
        address centerContract = address (new Center(msg.sender));
        center_addresses.push(centerContract);
        emit NewContract(centerContract, msg.sender );
    }
}

contract Center {

    address public centerAddress;
    address public contractAddress;

    constructor (address _address) public {
        centerAddress = _address;
        contractAddress = address(this)
    }
}