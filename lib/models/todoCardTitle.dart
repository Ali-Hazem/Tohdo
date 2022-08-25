import 'package:flutter/material.dart';

class TodoCardTitle with ChangeNotifier {
  final List<String> _todos = [];
  List<String> get todos => _todos;
  void addTodo(String todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(String todo) {
    _todos.remove(todo);
    notifyListeners();
  }
}
