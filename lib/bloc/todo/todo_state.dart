import 'package:equatable/equatable.dart';
import 'package:todo_list/model/Todo.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoInitialState extends TodoState {}
class TodoLoadingState extends TodoState {}
class TodoListEmptyState extends TodoState {}
class TodoListState extends TodoState {
  final List<Todo> todoList;
  TodoListState(this.todoList);
}