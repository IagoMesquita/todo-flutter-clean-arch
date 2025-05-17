import 'dart:async';

import 'package:todo_clean_arch/domain/entities/todo.dart';
import 'package:todo_clean_arch/domain/params/create_todo_params.dart';
import 'package:todo_clean_arch/domain/repositories/todo_repository.dart';

class AddToDo {
  final ToDoRepository repository;

  AddToDo(this.repository);

  Future<void> call(CreateTodoParams todoParams) async {
    final todo = ToDo(
      id: '',
      title: todoParams.title,
      isDone: false,
    );
    await repository.addToDo(todo);
  }
}
