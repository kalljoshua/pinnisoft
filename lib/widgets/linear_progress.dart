import 'package:flutter/material.dart';

class LinearProgress extends StatelessWidget {
  final double progress;

  const LinearProgress({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: Colors.grey.shade800,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        SizedBox(height: 5),
        Text(
          "${progress.toInt()}% Complete",
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}
