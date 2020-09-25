import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:todo_list/screen/app_settings.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:todo_list/screen/list_screen.dart';

class TodoFormBloc extends FormBloc<String, String> {
  TodoService todoService;

  // ignore: close_sinks
  final title = TextFieldBloc(
      name: 'title',
      validators: [FieldBlocValidators.required, _min4CharValidator]);

  // ignore: close_sinks
  final tag =
      TextFieldBloc(name: 'tag', validators: [FieldBlocValidators.required]);

  // ignore: close_sinks
  final description = TextFieldBloc(name: 'description');

  // ignore: close_sinks
  final priority = SelectFieldBloc(
      name: 'priority',
      items: ['High', 'Low', 'Critical'],
      validators: [FieldBlocValidators.required]);

  // ignore: close_sinks
  final status = SelectFieldBloc(
      name: 'status',
      items: ['Open', 'In Progress', 'Resolved', 'Close'],
      validators: [FieldBlocValidators.required]);

  // ignore: close_sinks
  final dueDate = InputFieldBloc<DateTime, Object>(
    name: 'dueDate',
    toJson: (value) => value.toUtc().toIso8601String(),
  );

  TodoFormBloc({this.todoService}) {
    addFieldBlocs(
      fieldBlocs: [title, priority, status, dueDate, tag, description],
    );
  }

  static String _min4CharValidator(String value) {
    if (value == null) {
      return "Title must have at least four characters";
    } else if (value.length < 4) {
      return "Title must have at least four characters";
    }
    return null;
  }

  @override
  void onSubmitting() async {
    final todoJson = JsonEncoder.withIndent('').convert(state.toJson());
    Todo newTodo = Todo.fromJson(todoJson);
    print('newTodo: ${newTodo.toString()}');
    try {
      this.todoService.addTask(todo: newTodo);
      print('list: ${this.todoService.listTask()}');
      emitSuccess(
        canSubmitAgain: true,
        successResponse: "Your task is added successfully!",
      );
    } catch (error) {
      emitFailure(failureResponse: error);
    }
  }
}

class TodoForm extends StatelessWidget {
  bool isOn = true;
  final TodoService todoService;
  TodoForm({this.todoService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoFormBloc(todoService: this.todoService),
      child: Builder(
        builder: (context) {
          final formBloc = context.bloc<TodoFormBloc>();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Todo Tracker'),
              leading: Icon(Icons.blur_linear),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(todoService: this.todoService)),
                        );
                      },
                      child: Icon(Icons.list),

                    )),
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppSettingScreen()),
                        );
                      },
                      child: Icon(Icons.settings),
                    )),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: formBloc.submit,
              child: Icon(Icons.add),
            ),
            body: FormBlocListener<TodoFormBloc, String, String>(
              onSuccess: (context, state) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.successResponse),
                  duration: Duration(seconds: 2),
                ));
              },
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.title,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Enter Your task title',
                          prefixIcon: Icon(Icons.title),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.description,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Enter Your task description',
                          prefixIcon: Icon(Icons.description),
                        ),
                      ),
                      RadioButtonGroupFieldBlocBuilder<String>(
                        selectFieldBloc: formBloc.priority,
                        itemBuilder: (context, value) =>
                            value[0].toUpperCase() + value.substring(1),
                        decoration: InputDecoration(
                          labelText: 'Priority',
                          prefixIcon: SizedBox(),
                        ),
                      ),
                      RadioButtonGroupFieldBlocBuilder<String>(
                        selectFieldBloc: formBloc.status,
                        itemBuilder: (context, value) =>
                            value[0].toUpperCase() + value.substring(1),
                        decoration: InputDecoration(
                          labelText: 'Status',
                          prefixIcon: SizedBox(),
                        ),
                      ),
                      DateTimeFieldBlocBuilder(
                        dateTimeFieldBloc: formBloc.dueDate,
                        format: DateFormat('dd-mm-yyyy'),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        decoration: InputDecoration(
                          labelText: 'Due Date',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.tag,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Enter Your task label',
                          prefixIcon: Icon(Icons.label),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
