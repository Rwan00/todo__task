import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home/presentation/widgets/todo_dialog.dart';

import '../../../../core/models/task_model.dart';
import '../../../../core/provider/todos_provider.dart';

void showEditTodoDialog(BuildContext context, TaskModel todo) {
  showDialog(
    context: context,
    builder: (context) => TodoDialog(
      initialValue: todo.title,
      onSave: (title) async {
        try {
          final updatedTodo = todo.copyWith(title: title);
          await context.read<TodosProvider>().updateTodo(updatedTodo);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    ),
  );
}

void showAddTodoBottomSheet(BuildContext context) {
  final TextEditingController textController = TextEditingController();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final title = textController.text.trim();
                    if (title.isNotEmpty) {
                      final newTodo = TaskModel(
                        userId: 1,
                        id: 0,
                        title: title,
                        completed: false,
                      );
                      context.read<TodosProvider>().addTodo(newTodo);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
