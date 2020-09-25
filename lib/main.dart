import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/repositories/todo_repo.dart';
import 'package:todo_list/screen/add_screen.dart';
import 'package:todo_list/screen/v2/home_screen.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/common/theme_manager.dart';

void main() {
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: App(),
  ));
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);
  final TodoRepo todoRepo = TodoRepo();

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService(todoRepo: todoRepo);
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        theme: theme.getTheme(),
        debugShowCheckedModeBanner: false,
        home: TodoForm(todoService: todoService),
      ),
    );
  }

// For V2

//  @override
//  Widget build(BuildContext context) {
//    TodoService todoService = TodoService(todoRepo: todoRepo);
//    return Consumer<ThemeNotifier>(
//        builder: (context, theme, _) => MaterialApp(
//            theme: theme.getTheme(),
//              home: MyHomePage(),
//            ));
//  }
}
