import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home/presentation/views/home_view.dart';

import 'core/provider/todos_provider.dart';
import 'core/theme/my_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
        theme: ThemeData(
        scaffoldBackgroundColor: MyColors.kScaffoldColor,
        appBarTheme: const AppBarTheme(color: MyColors.kScaffoldColor),
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.kPrimaryColor),
        useMaterial3: true,
       
      ),
        home: const HomeView(),
      ),
    );
  }
}















