import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_clean_arch/core/exceptions/firebase_exceptions.dart';
import 'package:todo_clean_arch/data/models/todo_model.dart';
import 'package:todo_clean_arch/domain/entities/todo.dart';
import 'package:todo_clean_arch/domain/repositories/todo_repository.dart';
import 'package:todo_clean_arch/extensions/todo_mapper.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final FirebaseFirestore firestore;

  ToDoRepositoryImpl(this.firestore);

  @override
  Future<List<ToDo>> getToDos() async {
    try {
      final snapShot = await firestore.collection('todos').get();

      return snapShot.docs.map((doc) {
        final todoModel =  ToDoModel.fromMap(doc.data(), doc.id);
        return todoModel.toEntity();
      }).toList();
    } on FirebaseException catch (e, stackTrace) {
      throw FirestoreException(
        message: e.message ?? 'Erro desconhecido',
        code: e.code,
        stackTrace: stackTrace,
        operation: 'getToDos',
      );
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception('Algo deu errado ao consultar as todos');
    }
  }

  @override
  Future<void> addToDo(ToDo todo) async {
    try {
      final todoModel =  todo.fromEntity(todo);
      await firestore.collection('todos').add(todoModel.toMap());
    } on FirebaseException catch (e, stackTrace) {
      throw FirestoreException(
        message: e.message ?? 'Erro desconhecido',
        code: e.code,
        stackTrace: stackTrace,
        operation: 'addToDO',
      );
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception('Algo deu errado ao adicinar as todos');
    }
  }

  @override
  Future<void> toggleToDoStatus(String id) async {
    try {
      final docRef = firestore.collection('todos').doc(id);
      final doc = await docRef.get();

      if (!doc.exists) {
        throw FirestoreException(
            message: 'Todo com id $id nao encontrado', operation: 'deleteToDo');
      }

      final data = doc.data();
      final updated = {'isDone': !(data!['isDone'] ?? false)};
      await docRef.update(updated);
    } on FirebaseException catch (e, stackTrace) {
      throw FirestoreException(
        message: e.message ?? 'Erro desconhecido',
        code: e.code,
        stackTrace: stackTrace,
        operation: 'deleteToDo',
      );
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception('Erro ao deletar uma todo.');
    }
  }

  @override
  Future<void> deleteToDo(String id) async {
    try {
      await firestore.collection('todos').doc(id).delete();
    } on FirebaseException catch (e, stackTrace) {
      throw FirestoreException(
          message: e.message ?? 'Erro desconhecido',
          code: e.code,
          stackTrace: stackTrace,
          operation: 'toggleToDoStatus');
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception('Erro ao alterar status da todo.');
    }
  }
}
