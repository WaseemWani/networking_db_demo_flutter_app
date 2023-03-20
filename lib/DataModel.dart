class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const Todo({this.userId, this.id, this.title, this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed']);
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'id': id, 'title': title};
  }
}
