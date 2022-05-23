import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/TodoTasks.dart';
import 'package:todo/Screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String title = "ToDo";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          scaffoldBackgroundColor: Colors.white70,
        ),

        home: const HomeScreen(),
      ),
    );
  }
}

