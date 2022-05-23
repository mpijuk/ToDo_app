import 'package:flutter/material.dart';

class TodoForm extends StatelessWidget {

  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoForm({
    Key? key,

    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTodo,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          SizedBox(height: 8),
          buildDescription(),
          SizedBox(height: 30),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildTitle() => TextFormField(

    initialValue: title,
    validator: (title) {
      if(title!.isEmpty) {
        return 'The title cannot be empty';
      }
      return null;
    },

    onChanged: onChangedTitle,

    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Title',
    ),
  );

  Widget buildDescription() => TextFormField(

    maxLines: 3,
    initialValue: description,

    onChanged: onChangedDescription,

    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Description',
    ),
  );

  Widget buildButton() => ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
    ),
    onPressed: onSavedTodo,
    child: Text(
      'Save',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
