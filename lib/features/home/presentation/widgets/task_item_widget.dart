import 'package:flutter/material.dart';
import 'package:todo_app/core/models/task_model.dart';
import 'package:todo_app/features/home/presentation/widgets/show_dialog_methods.dart';

class TaskItemWidget extends StatelessWidget {
 final TaskModel todo;
 final void Function(bool?) onChanged;
 final void Function() delete;
  const TaskItemWidget({required this.todo,required this.onChanged,required this.delete,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        color: const Color.fromARGB(255, 232, 244, 252),
        child: Row(
          children: [
            Checkbox(
              value: todo.completed,
              onChanged: onChanged,
            ),
            SizedBox(
              width: 170,
              child: Text(todo.title),
            ),
            Spacer(),
            Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed: delete,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                  ),
                  onPressed: () => showEditTodoDialog(context, todo),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
