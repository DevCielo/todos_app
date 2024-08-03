import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos_app/pages/add.dart';
import 'package:todos_app/pages/completed.dart';
import 'package:todos_app/providers/todo_provider.dart';
import 'package:todos_app/models/todo.dart';
import 'package:todos_app/storage/storage.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key, required this.storage}) : super(key: key);

  final UserInputStorage storage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos = todos.where((todo) => todo.completed == false).toList();
    List<Todo> completedTodos = todos.where((todo) => todo.completed == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: ListView.builder(
        itemCount: activeTodos.length + 1,
        itemBuilder: (context, index) {
          if (activeTodos.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 300.0),
              child: Center(child: Text('Add a todo using the button below'),));
          }
          else if (index == activeTodos.length) {
            if (completedTodos.isEmpty) return Container();
            else {
              return Center(child: TextButton(child: Text("Completed Todos"), onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompletedTodo()));
              },),);
            }

          } else {
        return Slidable(
          startActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(onPressed: (context) {
              ref.watch(todoProvider.notifier).deleteTodo(activeTodos[index].todoId);
            },
            backgroundColor: Colors.red, 
            borderRadius: const BorderRadius.all(Radius.circular(20)), 
            icon: Icons.delete,)
          ]),
          endActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(onPressed: (context) {
              ref.watch(todoProvider.notifier).completeTodo(activeTodos[index].todoId);
            },
            backgroundColor: Colors.green, 
            borderRadius: const BorderRadius.all(Radius.circular(20)), 
            icon: Icons.check,)
          ]),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
            child: ListTile(
              title: Text(activeTodos[index].content))
            )
        );
          }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AddTodo()));
        },
        tooltip: 'Add todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
