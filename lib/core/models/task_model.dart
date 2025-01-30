class TaskModel {
  final int userId;
  final int id;
  final String title;
  bool completed;

  TaskModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  TaskModel copyWith({
  int? userId,
  int? id,
  String? title,
  bool? completed,
}) {
  return TaskModel(
    userId: userId ?? this.userId,
    id: id ?? this.id,
    title: title ?? this.title,
    completed: completed ?? this.completed,
  );
}
}