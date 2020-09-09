pragma solidity ^0.6.0;

/**
 * @dev String operations.
 */
library Strings {
    /**
     * @dev Converts a `uint256` to its ASCII `string` representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        uint256 index = digits - 1;
        temp = value;
        while (temp != 0) {
            buffer[index--] = byte(uint8(48 + temp % 10));
            temp /= 10;
        }
        return string(buffer);
    }

    
    // @dev standard substring method. Note that endIndex == 0 indicates the substring should be taken to the end of the string.
    // @param takes in a string, and a starting (included) and ending index (not included in substring).
    // @return substring
    function substring(
        string memory str,
        uint256 startIndex,
        uint256 endIndex
    ) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        if (endIndex == 0) {
            endIndex = strBytes.length;
        }
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }

    // @dev gets the index of a certain character inside of a string; helper method
    // @param requires a string, a certain character, and the index to start checking from
    // @return returns the index of the character in the string
    function indexOfChar(string memory str, byte char, uint256 startIndex) internal pure returns (uint256) {
        bytes memory strBytes = bytes(str);
        uint256 length = strBytes.length;
        for (uint256 i = startIndex; i < length; i++) {
            if (strBytes[i] == char) {
                return i;
            }
        }
        return 0;
    }

    // @dev gets the latitude of the token from a geoId
    // @param takes in a string of form "Lat,Lon" as a parameter
    // @return returns the str of the latitude
    function getLat(string memory str) internal pure returns (string memory) {
        uint256 index = indexOfChar(str, byte(","), 0);
        return substring(str, 0, index);
    }

    // @dev gets the longitude of the token from a geoId
    // @param takes in a string of form "Lat,Lon" as a parameter
    // @return returns the str of the longitude
    function getLon(string memory str) internal pure returns (string memory) {
        uint256 index = indexOfChar(str, byte(","), 0);
        return substring(str, index + 1, 0);
    }


    // @dev converts ASCII encoding into a string
    // @param bytes32 ASCII encoding
    // @return string version
    function bytes32ToString(bytes32 _dataBytes32)
        internal 
        pure
        returns (string memory)
    {
        bytes memory bytesString = new bytes(32);
        uint256 charCount = 0;
        uint256 j;
        for (j = 0; j < 32; j++) {
            // outscope declaration
            byte char = byte(bytes32(uint256(_dataBytes32) * 2**(8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    
    }
    
    // @param takes in the string, and trims based on the decimal integer
    // @return returns the substring based on the decimal values.
    function truncateDecimals(string memory str, uint256 decimal)
        internal
        pure
        returns (string memory)
    {
        uint256 decimalIndex = indexOfChar(str, byte("."), 0);
        bytes memory strBytes = bytes(str);
        uint256 length = strBytes.length;
        return (decimalIndex + decimal + 1 > length) ? substring(str, 0, length) : substring(str, 0, decimalIndex + decimal + 1);
    }

    
    // @devs: Converts a number to a string literal of its hex representation (without the '0x' prefix)
    // @param a number
    // @return string literal of the number's hex
    function toHexString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT license
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 16;
        }
        bytes memory buffer = new bytes(digits);
        uint256 index = digits - 1;
        temp = value;
        while (temp != 0) {
            uint256 digit = temp % 16;
            if (digit < 10) {
                buffer[index--] = byte(uint8(48 + digit));
            } else {
                buffer[index--] = byte(uint8(87 + digit));
            }
            temp /= 16;
        }
        return string(buffer);
    }
}
