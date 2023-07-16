// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract admin_manufacture {
    address public owner;
    uint256 public creationTime;
    //uint256 public userCount;
    uint256 public buyerCount;
    uint256 public supplierCount;

    mapping(address => Buyer) private buyers;
    mapping(address => Supplier) private suppliers;

    struct Buyer {
        string firstName;
        string lastName;
        string companyName;
        string email;
        string phoneNumber;
        string password;
        bool exists;
    }
   struct Supplier {
        string firstName;
        string lastName;
        string companyName;
        string email;
        string phoneNumber;
        string password;
        bool exists;
    }

    constructor() {
        owner = msg.sender;
        creationTime = block.timestamp;
    }

modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function.");
        _;
    }

    function isBuyer(address userAddress) public view returns (bool) {
        return buyers[userAddress].exists;
    }

    function isSupplier(address userAddress) public view returns (bool) {
        return suppliers[userAddress].exists;
    }

    function registerBuyer(
        string memory firstName,
        string memory lastName,
        string memory companyName,
        string memory email,
        string memory phoneNumber,
        string memory password
    ) public returns (bool) {
        require(!isBuyer(msg.sender), "Buyer already exists.");

        buyers[msg.sender] = Buyer({
            firstName: firstName,
            lastName: lastName,
            companyName: companyName,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            exists: true
        });

        buyerCount++;
        return true;
    }

    function registerSupplier(
        string memory firstName,
        string memory lastName,
        string memory companyName,
        string memory email,
        string memory phoneNumber,
        string memory password
    ) public returns (bool) {
        require(!isSupplier(msg.sender), "Supplier already exists.");

        suppliers[msg.sender] = Supplier({
            firstName: firstName,
            lastName: lastName,
            companyName: companyName,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            exists: true
        });

        supplierCount++;
        return true;
    }

    function getBuyer(address userAddress) public view returns (
        string memory firstName,
        string memory lastName,
        string memory companyName,
        string memory email,
        string memory phoneNumber,
        string memory password
    ) {
        require(isBuyer(userAddress), "Buyer does not exist.");

        Buyer memory buyer = buyers[userAddress];

        return (
            buyer.firstName,
            buyer.lastName,
            buyer.companyName,
            buyer.email,
            buyer.phoneNumber,
            buyer.password
        );
    }

    function getSupplier(address userAddress) public view returns (
        string memory firstName,
        string memory lastName,
        string memory companyName,
        string memory email,
        string memory phoneNumber,
        string memory password
    ) {
        require(isSupplier(userAddress), "Supplier does not exist.");

        Supplier memory supplier = suppliers[userAddress];

        return (
            supplier.firstName,
            supplier.lastName,
            supplier.companyName,
            supplier.email,
            supplier.phoneNumber,
            supplier.password
        );
    }
}