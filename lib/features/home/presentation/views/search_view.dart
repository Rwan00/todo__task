import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home/presentation/widgets/tasks_list_view.dart';

import '../../../../core/provider/todos_provider.dart';

class SearchView extends StatefulWidget {
  static String routeName = "SearchView";
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search todos...',
            border: InputBorder.none,
          ),
          onChanged: (value) =>
              context.read<TodosProvider>().setSearchQuery(value),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              context.read<TodosProvider>().setSearchQuery('');
            },
          ),
        ],
      ),
      body: TasksListView(
        isSerach: true,
      ),
    );
  }
}
