import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: task.progress < 50 ? Colors.purple : Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(task.title, style: TextStyle(color: Colors.white, fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description, style: TextStyle(color: Colors.white54)),
            SizedBox(height: 5),
            LinearProgressIndicator(value: task.progress / 100, color: Colors.green),
            SizedBox(height: 5),
            Text("${task.daysLeft} Days Left", style: TextStyle(color: Colors.white70)),
          ],
        ),
        trailing: PopupMenuButton<String>(
          color: Colors.white,
          onSelected: (String value) {
            if (value == 'edit') {
              // Edit task logic
            } else if (value == 'delete') {
              // Delete task logic
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: 'edit', child: Text("Edit")),
            PopupMenuItem(value: 'delete', child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
