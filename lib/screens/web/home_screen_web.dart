import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/task_provider.dart';
import '../../widgets/task_card.dart';
import 'task_screen_web.dart';

class HomeScreenWeb extends StatefulWidget {
  @override
  _HomeScreenWebState createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  void _openTaskScreenWeb(BuildContext context) {
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
          child: TaskScreenWeb(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<TaskProvider>(context).tasks;

    return Scaffold(
      backgroundColor: Color(0xFF181A2E),
      appBar: AppBar(
        title: Text("Task Management"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () => _openTaskScreenWeb(context),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recent Activities",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 13 / 3,
                ),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(task: tasks[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}