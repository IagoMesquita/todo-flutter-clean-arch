import 'dart:async';

import 'package:todo_clean_arch/features/todo/domain/entities/todo.dart';
import 'package:todo_clean_arch/features/todo/domain/usecases/params/create_todo_params.dart';
import 'package:todo_clean_arch/features/todo/domain/repositories/todo_repository.dart';

class AddToDo {
  final ToDoRepository repository;

  AddToDo(this.repository);

  Future<void> call(CreateTodoParams todoParams) async {
    final todo = ToDo(
      id: '',
      title: todoParams.title,
      description: todoParams.description,
      createdAt: DateTime.now(),
      isDone: false,
    );
    await repository.addToDo(todo);
  }
}
