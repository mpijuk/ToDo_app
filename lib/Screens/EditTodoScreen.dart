import 'package:flutter/material.dart';
import 'package:todo/CustomWidgets/TodoForm.dart';
import 'package:todo/Models/Todo.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/TodoProvider.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;

  const EditTodoScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {

  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;


  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final provider = Provider.of<TodoProvider>(context, listen: false);
              provider.removeTodo(widget.todo);

              Navigator.of(context).pop();
            },
          ),
        ]
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TodoForm(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) => setState(() => this.description = description),
            onSavedTodo: saveTodo,
          ),
        ),
      )
    );
  }

  void saveTodo () {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
    }
  }
}
