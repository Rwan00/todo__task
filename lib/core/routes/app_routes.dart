import 'package:flutter/material.dart';
import 'package:todo_app/features/home/presentation/views/home_view.dart';

import '../../features/home/presentation/views/search_view.dart';

Map<String, WidgetBuilder> routes = {
  "/": (_) => const HomeView(),
  
  SearchView.routeName: (_) => const SearchView(),
  
};