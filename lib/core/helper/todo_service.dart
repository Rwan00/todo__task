import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/core/models/task_model.dart';

class TodoService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<TaskModel>> getTodos() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((todo) => TaskModel.fromJson(todo))
          .toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<TaskModel> createTodo(TaskModel todo) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: json.encode(todo.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return TaskModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<TaskModel> updateTodo(TaskModel todo) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${todo.id}'),
      body: json.encode(todo.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return TaskModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}

