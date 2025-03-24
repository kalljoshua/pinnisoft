
class Task {
  String id;
  String title;
  String description;
  double progress;
  int daysLeft;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.daysLeft,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        progress: json['progress'].toDouble(),
        daysLeft: json['daysLeft'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'progress': progress,
        'daysLeft': daysLeft,
      };
}
