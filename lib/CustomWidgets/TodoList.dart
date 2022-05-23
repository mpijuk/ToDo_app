import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/CustomWidgets/TodoTask.dart';
import 'package:todo/Provider/TodoTasks.dart';
import 'package:todo/Models/Todo.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TodoProvider>(context);
    final allTasks = provider.todos;

    return allTasks.isEmpty
        ? Center(
            child: Text(
              'No todos.',
              style: TextStyle(fontSize: 20),
            ),
        )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Divider(height:  8),
            itemCount: allTasks.length,
            itemBuilder: (context, index) {
              final todo = allTasks[index];
              return TodoWidget(todo: todo);
            },
        );
  }
}
