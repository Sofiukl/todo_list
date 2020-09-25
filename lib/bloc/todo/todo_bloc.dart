import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo/todo_event.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/bloc/todo/todo_state.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  TodoService todoService;

  TodoBloc({this.todoService}) : super(TodoInitialState());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodoEvent) {
      yield TodoLoadingState();
      await Future.delayed(const Duration(seconds: 2), () {});
      final todoList = this.todoService.listTask();
      print('IN TODOBLOC list: ${this.todoService.listTask()}');
      yield findState(todoList);
    } else if (event is AddTodoEvent) {
      yield TodoLoadingState();
      final todo = event.todo;
      this.todoService.addTask(todo: todo);
      final todoList = this.todoService.listTask();
      yield findState(todoList);
    } else if (event is DeleteTodoEvent) {
      yield TodoLoadingState();
      final id = event.id;
      todoService.removeTask(id);
      final todoList = this.todoService.listTask();
      yield findState(todoList);
    }
  }

 findState(List<Todo> todoList) {
    if (todoList.isEmpty) {
      return TodoListEmptyState();
    } else {
      return TodoListState(todoList);
    }
  }
}
