import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/features/home/presentation/widgets/tasks_list_view.dart';

import '../../../../core/provider/todos_provider.dart';
import '../widgets/show_dialog_methods.dart';

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
      appBar: AppBar(
          title: const Text(
        'To-Do List',
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTodoBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      body: TasksListView(),
    );
  }

  }





