import 'package:flutter/material.dart';
import 'package:todo/API/Authentication.dart';
import 'package:todo/API/FirebaseApi.dart';
import 'package:todo/Provider/TodoProvider.dart';
import 'package:todo/main.dart';
import 'package:provider/provider.dart';
import 'package:todo/CustomWidgets/AddTodoDialog.dart';
import 'package:todo/CustomWidgets/CompletedTodoList.dart';
import 'package:todo/CustomWidgets/TodoList.dart';
import 'package:todo/Models/Todo.dart';
import 'package:todo/Models/CustomUser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Authentication _auth = Authentication();
  int selected = 0;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);

    final tabs = [
      TodoList(),
      CompletedTodoList(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
            MyApp.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
        ),
        elevation: 0,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
        ],
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
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context,snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong, try later'));
              } else {
                final todos = snapshot.data;
                final showTodos = todos!.where((todo) => todo.userID == user!.uid).toList();

                final provider = Provider.of<TodoProvider>(context);
                provider.setTodos(showTodos);

                return tabs[selected];
              }
          }
        },
      ),// tabs,
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
