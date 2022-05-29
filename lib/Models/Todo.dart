import 'package:todo/Shared/Utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String taskID;
  String userID;
  String description;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    required this.taskID,
    required this.userID,
    this.isDone = false,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
    createdTime: Utils.toDateTime(json['createdTime']),
    title: json['title'],
    description: json['description'],
    taskID: json['taskID'],
    userID: json['userID'],
    isDone: json['isDone'],
  );

  Map<String, dynamic> toJson() => {
    'createdTime': Utils.fromDateTimeToJson(createdTime),
    'title': title,
    'description': description,
    'taskID': taskID,
    'userID': userID,
    'isDone': isDone,
  };

}