// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

contract TodoList {
    
    // 定义结构体 包含任务id，内容，完成状态
    struct Task {
        uint256 id;
        string content;
        bool completed;
    }

    // 定义一个数组，用来存储任务
    Task[] public tasks;
 
    // 定义一个函数，用来添加任务计数
    uint256 private taskCount =0;

    // 事件，任务添加
    event TaskAdded(uint256 id, string content);

    // 事件，任务完成
    event TaskCompleted(uint256 id, bool completed);

    //添加新任务
    function addTask(string memory _content) public {
        // 判断任务内容不能为空
        require(bytes(_content).length > 0, "Task content cannot be empty");
        // 创建一个新任务
        Task memory newTask = Task(taskCount, _content, false);
        // 将新任务添加到数组中
        tasks.push(newTask);
        // 触发任务添加事件
        emit TaskAdded(taskCount, _content);
        // 更新任务计数
        taskCount++;
    }

    // 获取所有任务
    function getTasks() public view returns (Task[] memory) {
        return tasks;
    }

    // 根据id 获取任务
    function getTaskById(uint256 _id) public view returns (Task memory) {
       // 判断任务是否存在
        require(_id < taskCount, "Task does not exist");
        // 任务id 不能小于1
        require(_id >= 1, "Task id cannot be less than 1");
        return tasks[_id-1];
    }

    // 完成任务
    function completeTask(uint256 _id) public {
        // 判断任务是否存在
        require(_id < taskCount, "Task does not exist");
        // 任务id 不能小于1
        require(_id >= 1, "Task id cannot be less than 1");
        tasks[_id-1].completed = !tasks[_id-1].completed;
        emit TaskCompleted(_id, tasks[_id-1].completed);
    }
}