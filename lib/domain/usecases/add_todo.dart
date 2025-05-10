import 'dart:async';

import 'package:todo_clean_arch/domain/entities/todo.dart';
import 'package:todo_clean_arch/domain/repositories/todo_repository.dart';

class AddToDo {
  final ToDoRepository repository;

  AddToDo(this.repository);

  Future<void> call(ToDo todo) async {
    await repository.addToDo(todo);
  }
}
