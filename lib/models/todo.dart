class Todo {
  int todoId;
  String content;
  bool completed;

  Todo({
    required this.todoId,
    required this.content,
    required this.completed,
  });

  Map<String, dynamic> toJson() => {
    'todoId': todoId,
    'content': content,
    'completed': completed,
  };

  static Todo fromJson(Map<String, dynamic> json) => Todo(
    todoId: json['todoId'],
    content: json['content'],
    completed: json['completed'],
  );
}