import 'package:flutter/material.dart';
import 'package:todo/CustomWidgets/TodoForm.dart';
import 'package:todo/Models/Todo.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/TodoProvider.dart';
import 'package:todo/Models/CustomUser.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {

  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {

    //final user = Provider.of<CustomUser?>(context, listen: false);

    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Todo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TodoForm(
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) => setState(() => this.description = description),
              onSavedTodo: saveTodo,
            ),
          ]
        ),
      ),
    );
  }

  void saveTodo () {
    final isValid = _formKey.currentState!.validate();

    if(!isValid) {
      return;
    } else {
      final user = Provider.of<CustomUser?>(context, listen: false);

      final todo = Todo(
        taskID: DateTime.now().toString(),
        userID: user!.uid,
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
