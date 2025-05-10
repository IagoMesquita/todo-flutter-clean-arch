import 'package:todo_clean_arch/domain/entities/todo.dart';

abstract class ToDoRepository {
  Future<List<ToDo>> getToDos();
  Future<void> addToDo(ToDo todo);
  Future<void> toggleToDoStatus(String id);
  Future<void> deleteToDo(String id);
}

//  Isso define o contrato da regra de negócio. 
//  A camada data vai implementar esse contrato, e a presentation vai depender apenas da interface.