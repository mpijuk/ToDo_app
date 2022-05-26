import 'package:flutter/material.dart';
import 'package:todo/CustomWidgets/TodoList.dart';
import 'package:todo/main.dart';
import 'package:todo/CustomWidgets/AddTodoDialog.dart';
import 'package:todo/CustomWidgets/CompletedTodoList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selected = 0;

  @override
  Widget build(BuildContext context) {

    final tabs = [
      TodoList(),
      CompletedTodoList(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
            MyApp.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        currentIndex: selected,
        onTap: (index) => setState(() {
          selected = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_rounded),
            label: 'to-do',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_box_rounded),
              label: 'completed',
          ),
        ],
      ),
      body: tabs[selected], // tabs,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.add, color: Colors.white ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AddTodoDialog(),
          barrierDismissible: true,
        ),
      ),
    );
  }
}
