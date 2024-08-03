import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos_app/pages/add.dart';
import 'package:todos_app/pages/completed.dart';
import 'package:todos_app/providers/todo_provider.dart';
import 'package:todos_app/models/todo.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos = todos.where((todo) => todo.completed == false).toList();
    List<Todo> completedTodos = todos.where((todo) => todo.completed == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: ListView.builder(
        itemCount: activeTodos.length + 1,
        itemBuilder: (context, index) {
          if (index == activeTodos.length) {
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
              ref.watch(todoProvider.notifier).deleteTodo(index);
            },
            backgroundColor: Colors.red, 
            borderRadius: BorderRadius.all(Radius.circular(20)), 
            icon: Icons.delete,)
          ]),
          endActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(onPressed: (context) {
              ref.watch(todoProvider.notifier).completeTodo(index);
            },
            backgroundColor: Colors.green, 
            borderRadius: BorderRadius.all(Radius.circular(20)), 
            icon: Icons.check,)
          ]),
          child: ListTile(title: Text(activeTodos[index].content))
        );
          }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddTodo()));
        },
        tooltip: 'Add todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
