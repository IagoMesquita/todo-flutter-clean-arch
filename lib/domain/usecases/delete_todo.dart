import 'package:todo_clean_arch/domain/repositories/todo_repository.dart';

class DeleteToDo {
  final ToDoRepository repository;

  DeleteToDo(this.repository);

  Future<void> call(String id) async {
    await repository.deleteToDo(id);
  }
}