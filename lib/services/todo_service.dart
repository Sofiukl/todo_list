import 'package:todo_list/repositories/todo_repo.dart';
import 'package:todo_list/model/Todo.dart';

class TodoService {

  TodoRepo todoRepo;
  TodoService({this.todoRepo});

  List<Todo> listTask() {
    return todoRepo.listTodo();
  }

  void addTask({Todo todo}) {
    todoRepo.addTodo(todo: todo);
  }

  void removeTask(String id) {
    todoRepo.removeTodo(id);
  }
}