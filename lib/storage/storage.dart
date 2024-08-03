import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todos_app/models/todo.dart';


class UserInputStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todos.json');
  }

  Future<List<Todo>> readUserInput() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(contents);
      return jsonList.map((json) => Todo.fromJson(json)).toList();
    } catch (error) {
      return [];
    }
  }

  Future<File> writeUserInput(List<Todo> todos) async {
    final file = await _localFile;
    final List<Map<String, dynamic>> jsonList = todos.map((todo) => todo.toJson()).toList();
    return file.writeAsString(jsonEncode(jsonList));
  }
}
