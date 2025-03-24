// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Shipping { 
    // 状态变量
    enum ShippingStatus {
        Pending,
        Shipped,
        Delivered
    }

    ShippingStatus public status;

    event LogNewAlert(string desc);

    constructor() {
        status = ShippingStatus.Pending;
    }

    function shipped() public  {
        status = ShippingStatus.Shipped;
        emit LogNewAlert("your package has been Shipped");
    }

    function delivered() public  {
        status = ShippingStatus.Delivered;
        emit LogNewAlert("your package has been arrived");
    }

    function getStatus(ShippingStatus _status) internal pure returns (string memory statusText) { 
        if (ShippingStatus.Pending == _status) return "Pending"; 
        if (ShippingStatus.Shipped == _status) return "Shipped"; 
        if (ShippingStatus.Delivered == _status) return "Delivered"; 
    }

    function Status() public view returns (string memory statusText) { 
        ShippingStatus _status = status;
        return getStatus(_status); 
    }
}