import 'package:todo_clean_arch/features/todo/domain/repositories/todo_repository.dart';

class ToggleToDo {
  final ToDoRepository repository;

  ToggleToDo(this.repository);

  Future<void> call(String id) async {
    await repository.toggleToDoStatus(id);
  }
}