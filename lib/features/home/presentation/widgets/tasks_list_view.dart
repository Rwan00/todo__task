import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home/presentation/widgets/task_item_widget.dart';

import '../../../../core/provider/todos_provider.dart';
import 'custom_loading_widget.dart';

class TasksListView extends StatelessWidget {
  final bool isSerach;
  const TasksListView({super.key, required this.isSerach});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CustomLoadingWidget());
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount:
              isSerach ? provider.filteredTodos.length : provider.todos.length,
          itemBuilder: (context, index) {
            final todo = isSerach
                ? provider.filteredTodos[index]
                : provider.todos[index];
            return AnimationConfiguration.staggeredList(
              duration: const Duration(milliseconds: 500),
              position: index,
              child: SlideAnimation(
                horizontalOffset: 100,
                child: FadeInAnimation(
                  child: TaskItemWidget(
                    todo: todo,
                    onChanged: (value) {
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
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
