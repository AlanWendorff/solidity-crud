// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

contract TaskContract {
    
    uint nextId;
    
    struct Task {
        uint id;
        string name;
    }
    
    Task[] tasks;
    
    
    function _findIndex(string memory _name) internal view returns (uint) { // internal: internal use, is a helper function
                                                                            // view    : this function only read data into the SC doesn't modify data;
        for (uint i; i < tasks.length; i++) {
            if ( keccak256(abi.encodePacked(tasks[i].name)) == keccak256(abi.encodePacked(_name)) ) {   // As in Java, the == operator doesn't compare the literals of two strings. You should use the StringUtils (library) : if (StringUtils.equal(myString, "this is a string")) {} or compare strings by hashing the packed encoding values of the string.
                return i;
            }
        }
        
        revert("task not found"); // solidity method that creates a callback if the index not found
    }
    
    function arrayLength () view public returns (uint) {
        return tasks.length;
    }
    
    function createTask (string memory _name) public { //memory : for strings indicates that the value of the variable be stored at the exectue of the function. Then the data looses the value.
        uint id = tasks.length;
       
        for (uint i; i < tasks.length; i++) {
            if ( keccak256(abi.encodePacked(tasks[i].name)) == keccak256(abi.encodePacked(_name)) ) {   // As in Java, the == operator doesn't compare the literals of two strings. You should use the StringUtils (library) : if (StringUtils.equal(myString, "this is a string")) {} or compare strings by hashing the packed encoding values of the string.
                 revert("cannot crate another task with same name!");
            }
        }
        
        tasks.push(
            Task(
                id++,
                _name
            )
        );
    }
    
    function readTask (string memory _name) view public returns (uint, string memory) {
        uint index = _findIndex(_name);
        return (
            tasks[index].id,
            tasks[index].name
        );
    }
    
    function deleteTask (string memory _name) public {
        uint index = _findIndex(_name);
        
        if (index >= tasks.length) return;

        for (uint i = index; i < tasks.length - 1; i++){
            tasks[i] = tasks[i+1];
        }
        
        tasks.pop();
    }
}