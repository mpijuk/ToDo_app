import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/TodoProvider.dart';
import 'package:todo/CustomWidgets/TodoTask.dart';

class CompletedTodoList extends StatelessWidget {
  const CompletedTodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final allTasks = provider.todosCompleted;

    return allTasks.isEmpty
        ? Center(
      child: Text(
        'No completed tasks.',
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
        return TodoTask(todo: todo);
      },
    );
  }
}
