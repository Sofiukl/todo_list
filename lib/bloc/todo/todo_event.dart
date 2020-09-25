import 'package:equatable/equatable.dart';
import 'package:todo_list/model/Todo.dart';

abstract class TodoEvent extends Equatable {}

class LoadTodoEvent extends TodoEvent {
  LoadTodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;
  AddTodoEvent(this.todo);

  @override
  List<Object> get props => [this.todo];
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;
  UpdateTodoEvent(this.todo);

  @override
  List<Object> get props => [this.todo];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  DeleteTodoEvent(this.id);

  @override
  List<Object> get props => [this.id];
}
