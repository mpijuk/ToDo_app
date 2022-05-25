import 'package:flutter/material.dart';
import 'package:todo/CustomWidgets/TodoForm.dart';
import 'package:todo/Models/Todo.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/TodoProvider.dart';

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({Key? key}) : super(key: key);

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {

  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
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
      final todo = Todo(
        id: DateTime.now().toString(),
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
