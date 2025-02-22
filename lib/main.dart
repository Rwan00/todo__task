import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/routes/app_routes.dart';


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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        scaffoldBackgroundColor: MyColors.kScaffoldColor,
        appBarTheme: const AppBarTheme(color: MyColors.kScaffoldColor),
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.kPrimaryColor),
        useMaterial3: true,
       
      ),
       routes: routes,
      ),
    );
  }
}















