import 'package:flutter/material.dart';
import 'package:tasklist/model/TaskModel.dart';

class TaskViewModel extends ChangeNotifier {
  List<TaskModel> tasks = [];

  void addTask(String title) {
    tasks.add(TaskModel(title: title));
    notifyListeners();
  }

  void updateTaskCompletion(int index, bool isCompleted) {
    tasks[index].isCompleted = isCompleted;
    notifyListeners();
  }

}
