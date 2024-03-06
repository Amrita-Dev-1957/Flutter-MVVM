import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/TaskModel.dart';
import '../viewmodel/TaskViewModel.dart';

class TodoAppMVVM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskViewModel>(
      create: (context) => TaskViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Todo List', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue),
        body: Column(
          children: <Widget>[
            AddTaskWidget(),
            TaskListWidget(),
          ],
        ),
      ),
    );
  }
}

class AddTaskWidget extends StatefulWidget {
  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter task',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                Provider.of<TaskViewModel>(context, listen: false).addTask(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class TaskListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('List Build');
    return Expanded(
      child: Consumer<TaskViewModel>(
        builder: (context, taskViewModel, child) => ListView.builder(
          itemCount: taskViewModel.tasks.length,
          itemBuilder: (context, index) {
            TaskModel task = taskViewModel.tasks[index];
            return ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: task.isCompleted ? Colors.grey : Colors.black,
                ),
              ),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  taskViewModel.updateTaskCompletion(index, value ?? false);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
