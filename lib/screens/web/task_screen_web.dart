import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../core/providers/task_provider.dart';
import '../../models/task.dart';
import '../../widgets/confirm_dialog.dart';

class TaskScreenWeb extends StatefulWidget {
  final Task? task; // If null, it's adding a new task.

  const TaskScreenWeb({Key? key, this.task}) : super(key: key);

  @override
  _TaskScreenWebState createState() => _TaskScreenWebState();
}

class _TaskScreenWebState extends State<TaskScreenWeb> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  double _progress = 0.0;
  int _daysLeft = 7;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _progress = widget.task!.progress;
      _daysLeft = widget.task!.daysLeft;
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);

      if (widget.task == null) {
        // Adding new task
        final newTask = Task(
          id: Uuid().v4(),
          title: _titleController.text,
          description: _descriptionController.text,
          progress: _progress,
          daysLeft: _daysLeft,
        );
        taskProvider.addTask(newTask);
      } else {
        // Updating existing task
        final updatedTask = Task(
          id: widget.task!.id,
          title: _titleController.text,
          description: _descriptionController.text,
          progress: _progress,
          daysLeft: _daysLeft,
        );
        taskProvider.updateTask(updatedTask);
      }

      Navigator.pop(context); // Close screen after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181A2E),
      appBar: AppBar(
        title: Text(widget.task == null ? "Create Task" : "Edit Task"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (widget.task != null)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDeleteTaskDialog(context, widget.task!);
              },
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title", style: TextStyle(color: Colors.white70)),
                  TextFormField(
                    controller: _titleController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter task title",
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.black45,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Title cannot be empty" : null,
                  ),
                  SizedBox(height: 16),
                  Text("Description", style: TextStyle(color: Colors.white70)),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter task description",
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.black45,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Description cannot be empty" : null,
                  ),
                  SizedBox(height: 16),
                  Text("Progress: ${_progress.toInt()}%",
                      style: TextStyle(color: Colors.white70)),
                  Slider(
                    value: _progress,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: _progress.toInt().toString(),
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() => _progress = value);
                    },
                  ),
                  SizedBox(height: 16),
                  Text("Days Left: $_daysLeft",
                      style: TextStyle(color: Colors.white70)),
                  Slider(
                    value: _daysLeft.toDouble(),
                    min: 1,
                    max: 30,
                    divisions: 29,
                    label: "$_daysLeft days",
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() => _daysLeft = value.toInt());
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: _saveTask,
                      child: Text(
                          widget.task == null ? "Create Task" : "Save Changes"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}