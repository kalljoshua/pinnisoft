import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/task_provider.dart';
import '../models/task.dart';

void showDeleteTaskDialog(BuildContext context, Task task) {
  final taskProvider = Provider.of<TaskProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.black87,
      title: Text("Delete Task", style: TextStyle(color: Colors.white)),
      content: Text("Are you sure you want to delete this task?", style: TextStyle(color: Colors.white70)),
      actions: [
        TextButton(
          child: Text("Cancel", style: TextStyle(color: Colors.blue)),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text("Delete", style: TextStyle(color: Colors.red)),
          onPressed: () {
            taskProvider.deleteTask(task.id);
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}