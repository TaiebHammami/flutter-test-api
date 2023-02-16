class Task {
  final int id;
  final String name;
  final String priority;

  Task({
    required this.name,
    required this.id,
    required this.priority,
  });

  factory Task.fromJson(dynamic json) {
    return Task(name: json['name'], id: json['id'], priority: json['priority']);
  }
}
