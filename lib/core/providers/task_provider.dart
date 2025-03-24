import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      saveTasks();
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? tasksData = prefs.getString('tasks');
    if (tasksData != null) {
      _tasks = (json.decode(tasksData) as List)
          .map((task) => Task.fromJson(task))
          .toList();
      notifyListeners();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', json.encode(_tasks.map((task) => task.toJson()).toList()));
  }
}
