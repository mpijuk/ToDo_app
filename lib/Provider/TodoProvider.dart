import 'package:flutter/material.dart';
import 'package:todo/Models/Todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Buy Food',
      description: '''
      -Eggs
      - Milk
      - Bread ''',
      id: '0',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Trip Plan',
      description: '''
      - Rent a car
      - Rent a hotel
      - Buy clothes
      - Enjoy ''',
      id: '1',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the dog',
      description: '''
      - from 12:00 to 14:00
      - Central park
      - Buy dog food ''',
      id: '2',
    ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }
}