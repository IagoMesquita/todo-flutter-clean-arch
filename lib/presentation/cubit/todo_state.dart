import 'package:todo_clean_arch/domain/entities/todo.dart';

abstract class ToDoState {}

class ToDoInitial extends ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoLoaded extends ToDoState {
  final List<ToDo> todos;

  ToDoLoaded(this.todos);
}

class ToDoError extends ToDoState {
  final String message;

  ToDoError(this.message);
}
