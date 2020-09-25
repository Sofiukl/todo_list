import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo/todo_bloc.dart';
import 'package:todo_list/bloc/todo/todo_event.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/bloc/todo/todo_state.dart';

class HomeScreen extends StatelessWidget {

  final TodoService todoService;
  const HomeScreen({this.todoService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TodoBloc(todoService: this.todoService),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('My Todo'),
            ),
            body: Center(
                child: Column(
              children: [ListTask()],
            )),
          );
        }));
  }
}

class ListTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      if (state is TodoInitialState) {
        BlocProvider.of<TodoBloc>(context).add(LoadTodoEvent());
        return Text("Loading your list");
      } else if (state is TodoListEmptyState) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text("You have no task!!", style: TextStyle(
              fontSize: 16
            ),),
          ),
        );
      } else if (state is TodoListState) {
        final todoList = state.todoList;
        return Expanded(
            child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  final todo = todoList[index];
                  final title = todo.title;
                  return Dismissible(
                    key: Key(title),
                    onDismissed: (direction) {
                      BlocProvider.of<TodoBloc>(context)
                          .add(DeleteTodoEvent(todo.id));
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("$title dismissed")));
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                        title: Text('${todo.title}'),
                        subtitle: Text(
                            '${todo.status} ${todo.priority} ${todo.dueDate}'),
                        leading: CircleAvatar(
                          child: Text('${todo.priority[0]}'),
                        ),
                        onLongPress: () {
                          print("edit $index");
                        }),
                  );
                }));
      }
      return CircularProgressIndicator();
    });
  }
}
