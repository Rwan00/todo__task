import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home/presentation/widgets/task_item_widget.dart';

import '../../../../core/provider/todos_provider.dart';
import 'custom_loading_widget.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CustomLoadingWidget());
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: provider.todos.length,
          itemBuilder: (context, index) {
            final todo = provider.todos[index];
            return TaskItemWidget(todo: todo, onChanged: (value) {
              provider.updateTodo(
                todo.copyWith(completed: value ?? false),
              );
            },
              delete: () async {
                try {
                  await provider.deleteTodo(todo.id);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },);
          },
        );
      },
    );
  }
}
