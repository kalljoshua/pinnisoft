import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final double progress; // Progress value (0 to 100)

  const CircularProgress({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(
            value: progress / 100, // Convert percentage to decimal
            backgroundColor: Colors.grey.shade800,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            strokeWidth: 8,
          ),
        ),
        Text(
          "${progress.toInt()}%", // Show progress as text
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
