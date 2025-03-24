// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldate _text) public {
        // 3种初始化对象的方法
        todos.push(Todo({
            text: _text,
            completed: false
        }));

        todos.push(Todo(
            _text,
            false
        ));

        Todo memory todo;
        todo.text = _text;
        todos.push(Todo(todo));
    }

    function get(uint _index) public view returns (string memory text, bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }


    function updateText(uint _index, string calldata _text) public {
        todos[_index].text = _text;
    }

    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }

}