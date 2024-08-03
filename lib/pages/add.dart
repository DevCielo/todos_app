import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:todos_app/providers/todo_provider.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController todoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(8.0),
            child: TextField(
          controller: todoController,
          decoration: InputDecoration(
            border: OutlineInputBorder()
          ),
        )
        ),
        TextButton(onPressed: (){
          ref.read(todoProvider.notifier).addTodo((todoController.text));
          Navigator.pop(context);
        }, child: Text('Add Todo'))
      ],
      )
    )
    );
  }
}

