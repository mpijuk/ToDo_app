import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/Models/Todo.dart';
import 'package:todo/Provider/TodoProvider.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screens/Home/EditTodoScreen.dart';
import 'package:todo/Shared/Utils.dart';

class TodoTask extends StatelessWidget {

  final Todo todo;

  const TodoTask({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Slidable(
        key: Key(todo.taskID),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.green,
              onPressed: (context) => editTodo(context, todo),
              label: 'Edit',
              icon: Icons.edit,
            ),
          ]
        ),

        endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                backgroundColor: Colors.red,
                onPressed: (context) => deleteTodo(context, todo) ,
                label: 'Delete',
                icon: Icons.delete,
              ),
            ]
        ),

        child: buildTodo(context),
      ),
    );
  }

  Widget buildTodo(BuildContext context) {
    return GestureDetector(
      onTap: () => editTodo(context, todo),
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (_) {
                final provider = Provider.of<TodoProvider>(context, listen: false);
                final isCompleted = provider.toggleTodoStatus(todo);

                Utils.showSnackBar(context,
                  isCompleted ? 'Task completed' : 'Task marked incomplete'
                );
              },
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                    ),
                  ),
                  if ( todo.description.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        todo.description,
                        style: TextStyle(fontSize: 20, height: 1.5),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => EditTodoScreen(todo: todo),
        ),
    );
  }
}
