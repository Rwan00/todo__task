import 'package:flutter/material.dart';
import 'package:todo_app/core/models/task_model.dart';

import '../helper/todo_service.dart';

class TodosProvider with ChangeNotifier {
  final TodoService _todoService = TodoService();
  List<TaskModel> _todos = [];
  bool _isLoading = false;

  List<TaskModel> get todos => _todos;
  bool get isLoading => _isLoading;

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _todos = await _todoService.getTodos();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTodo(TaskModel todo) async {
    try {
      final newTodo = await _todoService.createTodo(todo);
      _todos.insert(0, newTodo);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTodo(TaskModel todo) async {
    try {
      final updatedTodo = await _todoService.updateTodo(todo);
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index >= 0) {
        _todos[index] = updatedTodo;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await _todoService.deleteTodo(id);
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}