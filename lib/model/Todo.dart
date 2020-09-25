import 'dart:convert';
import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String title;
  String priority;
  String dueDate;
  String status;

  Todo({this.id, this.title, this.priority, this.dueDate, this.status});

  static Todo fromJson(String todoJson) {
    var uuid = Uuid();
    Map<String, dynamic> todoMap = jsonDecode(todoJson);
    return Todo(
        id: uuid.v4(),
        title: todoMap['title'],
        priority: todoMap['priority'],
        dueDate: todoMap['dueDate'],
        status: todoMap['status']);
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, priority: $priority, dueDate: $dueDate, status: $status}';
  }
}
