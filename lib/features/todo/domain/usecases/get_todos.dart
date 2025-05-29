import 'package:todo_clean_arch/features/todo/domain/entities/todo.dart';
import 'package:todo_clean_arch/features/todo/domain/repositories/todo_repository.dart';

class GetToDos {
  final ToDoRepository repository;

  GetToDos(this.repository);

  Future<List<ToDo>> call() async {
    return await repository.getToDos();
  }
}