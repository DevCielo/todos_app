import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos_app/models/todo.dart';
import 'package:todos_app/storage/storage.dart';

final todoProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier(UserInputStorage());
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier(this.storage): super([]) {
    _loadTodos();
  }

  final UserInputStorage storage;

  Future<void> _loadTodos() async {
    final todos = await storage.readUserInput();
    state = todos;
  }

  Future<void> _saveTodos() async {
    await storage.writeUserInput(state);
  }
  
  void addTodo(String content) {
    state = [...state, Todo(todoId: state.isEmpty ? 0 : state[state.length - 1].todoId + 1, content: content, completed: false,)];
    _saveTodos();
  }
  void completeTodo(int id) {
    state = [
      for (final todo in state) 
        if (todo.todoId == id)
          Todo(todoId: todo.todoId, content: todo.content, completed: true)
        else
          todo
    ];
    _saveTodos();
  }
  void deleteTodo(int id) {
    state = state.where((todo) => todo.todoId != id).toList();
    _saveTodos();
  }
}