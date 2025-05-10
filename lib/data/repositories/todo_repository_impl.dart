import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_clean_arch/data/models/todo_model.dart';
import 'package:todo_clean_arch/domain/entities/todo.dart';
import 'package:todo_clean_arch/domain/repositories/todo_repository.dart';

class ToDoRepositoryImpl implements ToDoRepository {

  final FirebaseFirestore firestore;

  ToDoRepositoryImpl(this.firestore);

  @override
  Future<List<ToDo>> getToDos() async {
    try {
      final snapShot = await firestore.collection('todo').get();

      return snapShot.docs.map((doc) {
        return ToDoModel.fromMap(doc.data(), doc.id).toEntity();
      }).toList();
    } catch (e) {
      throw Exception('Erro ao buscar tarefas: $e');
    }
  }
  
  @override
  Future<void> addToDo(ToDo todo) {
    // TODO: implement addToDo
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteToDo(String id) {
    // TODO: implement deleteToDo
    throw UnimplementedError();
  }
  
  @override
  Future<void> toggleToDoStatus(String id) {
    // TODO: implement toggleToDoStatus
    throw UnimplementedError();
  }


}