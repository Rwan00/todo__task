import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/features/home/presentation/widgets/custom_loading_widget.dart';

import '../../../../core/provider/todos_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodosProvider>().loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Consumer<TodosProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CustomLoadingWidget());
          }
          return ListView.builder(
            itemCount: provider.todos.length,
            itemBuilder: (context, index) {
              final todo = provider.todos[index];
              return ListTile(
                title: Text(todo.title),
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (value) {
                    provider.updateTodo(
                      todo.copyWith(completed: value ?? false),
                    );
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.deleteTodo(todo.id),
                ),
                onTap: () => _showEditTodoDialog(context, todo),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TodoDialog(
        onSave: (title) {
          final newTodo = TaskModel(
            userId: 1, 
            id: 0, 
            title: title,
            completed: false,
          );
          context.read<TodosProvider>().addTodo(newTodo);
        },
      ),
    );
  }

  void _showEditTodoDialog(BuildContext context, TaskModel todo) {
    showDialog(
      context: context,
      builder: (context) => TodoDialog(
        initialValue: todo.title,
        onSave: (title) {
          final updatedTodo = todo.copyWith(title: title);
          context.read<TodosProvider>().updateTodo(updatedTodo);
        },
      ),
    );
  }
}

class TodoDialog extends StatefulWidget {
  final String? initialValue;
  final Function(String) onSave;

  const TodoDialog({super.key, this.initialValue, required this.onSave});

  @override
  State<TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialValue == null ? 'Add Todo' : 'Edit Todo'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter todo title'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(_controller.text);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}




