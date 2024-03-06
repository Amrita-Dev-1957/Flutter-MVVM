import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Task> tasks = [];

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
  }

  void updateTaskCompletion(int index, bool isCompleted) {
    setState(() {
      tasks[index].isCompleted = isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Todo List', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue),
        body: Column(
          children: <Widget>[
            AddTaskWidgetSimple(addTask),
            TaskListWidgetSimple(tasks, updateTaskCompletion),
          ],
        ),
      );
  }
}

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class AddTaskWidgetSimple extends StatefulWidget {
  final Function(String) addTask;

  AddTaskWidgetSimple(this.addTask);

  @override
  _AddTaskWidgetSimpleState createState() => _AddTaskWidgetSimpleState();
}

class _AddTaskWidgetSimpleState extends State<AddTaskWidgetSimple> {
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
                widget.addTask(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class TaskListWidgetSimple extends StatelessWidget {
  final List<Task> tasks;
  final Function(int, bool) updateTaskCompletion;

  TaskListWidgetSimple(this.tasks, this.updateTaskCompletion);

  @override
  Widget build(BuildContext context) {
    print('List Build');
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
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
                updateTaskCompletion(index, value ?? false);
              },
            ),
          );
        },
      ),
    );
  }
}