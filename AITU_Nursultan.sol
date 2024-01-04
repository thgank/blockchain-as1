// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AITU_Nursultan is ERC20 {
   constructor() ERC20("AITU_Nursultan", "AITU") {
        uint256 initialSupply = 2000 * (10 ** uint256(decimals()));
        _mint(msg.sender, initialSupply);
    }

    function latestTransactionTime() public view returns (uint256 year, uint256 month, uint256 day, uint256 hour, uint256 minute, uint256 second) {
        return unixToDateTime(block.timestamp);
    }

    function getSender() public view returns (address) {
        return _msgSender();
    }

    function getReceiver() public view returns (address) {
        return address(this);
    }

    function unixToDateTime(uint256 timestamp) private pure returns (uint256 year, uint256 month, uint256 day, uint256 hour, uint256 minute, uint256 second) {
        uint256 secondsInDay = 86400;
        uint256 secondsInHour = 3600;
        uint256 secondsInMinute = 60;

        year = 1970;
        while (timestamp >= 31536000) {
            if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
                timestamp -= 31622400; // Leap year
            } else {
                timestamp -= 31536000;
            }
            year++;
        }

        month = 1;
        uint256[] memory monthSeconds = new uint256[](12);
        monthSeconds[0] = 2678400;
        monthSeconds[1] = 2419200;
        monthSeconds[2] = 2678400;
        monthSeconds[3] = 2592000;
        monthSeconds[4] = 2678400;
        monthSeconds[5] = 2592000;
        monthSeconds[6] = 2678400;
        monthSeconds[7] = 2678400;
        monthSeconds[8] = 2592000;
        monthSeconds[9] = 2678400;
        monthSeconds[10] = 2592000;
        monthSeconds[11] = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) ? 2505600 : 2419200;

        while (timestamp >= monthSeconds[month - 1]) {
            timestamp -= monthSeconds[month - 1];
            month++;
        }

        day = timestamp / secondsInDay + 1;
        timestamp %= secondsInDay;

        hour = timestamp / secondsInHour;
        timestamp %= secondsInHour;

        minute = timestamp / secondsInMinute;
        timestamp %= secondsInMinute;

        second = timestamp;
    }
}
