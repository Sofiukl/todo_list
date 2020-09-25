import 'package:todo_list/model/Todo.dart';

class TodoRepo {

  List<Todo> todoList = [
    Todo(id:'t1', title: 'Lets do some fun together', status: 'Open', priority: 'High', dueDate: '25/09/2020'),
    Todo(id:'t1', title: 'Learn Deno and develop one real application', status: 'Open', priority: 'Low', dueDate: '10/12/2020'),
    Todo(id:'t1', title: 'Write a tool in python for parsing draw.io yml and generate automatic ui', status: 'InProgress', priority: 'Critical', dueDate: '10/12/2020'),
    Todo(id:'t1', title: 'Integrate GraphQL with node server', status: 'InProgress', priority: 'High', dueDate: '22/10/2020')
  ];

  List<Todo> listTodo() {
    return this.todoList;
  }

  void addTodo({Todo todo}) {
    this.todoList.add(todo);
  }

  void removeTodo(String id) {
    this.todoList.removeWhere((todo) {
      return todo.id == id;
    });
  }
}