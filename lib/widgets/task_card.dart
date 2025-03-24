import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/mobile/task_screen.dart';
import '../screens/web/task_screen_web.dart';
import 'confirm_dialog.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  void _showTaskDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(task.description, style: TextStyle(color: Colors.white70, fontSize: 16)),
              SizedBox(height: 15),
              LinearProgressIndicator(
                value: task.progress / 100,
                color: Colors.green,
                backgroundColor: Colors.grey.shade700,
              ),
              SizedBox(height: 5),
              Text("${task.progress.toInt()}% Complete", style: TextStyle(color: Colors.white70)),
              SizedBox(height: 15),
              Text("Days Left: ${task.daysLeft}", style: TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
        );
      },
    );
  }

  void _editTask(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android || Theme.of(context).platform == TargetPlatform.iOS) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskScreen(task: task)),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Color(0xFF181A2E),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: TaskScreenWeb(task: task),
          ),
        ),
      );
    }
  }

  void _deleteTask(BuildContext context) {
    showDeleteTaskDialog(context, task);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: task.progress < 50 ? Colors.purple : Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () => _showTaskDetails(context), // Show details on tap
        title: Text(task.title, style: TextStyle(color: Colors.white, fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description, style: TextStyle(color: Colors.white54)),
            SizedBox(height: 5),
            LinearProgressIndicator(
              value: task.progress / 100,
              color: Colors.green,
              backgroundColor: Colors.grey.shade700,
            ),
            SizedBox(height: 5),
            Text("${task.daysLeft} Days Left", style: TextStyle(color: Colors.white70)),
          ],
        ),
        trailing: PopupMenuButton<String>(
          color: Colors.white,
          onSelected: (String value) {
            if (value == 'edit') {
              _editTask(context);
            } else if (value == 'delete') {
              _deleteTask(context);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Text("Edit", style: TextStyle(color: Colors.black)),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text("Delete", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}