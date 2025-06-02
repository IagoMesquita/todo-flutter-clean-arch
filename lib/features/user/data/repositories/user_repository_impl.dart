import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_clean_arch/core/exceptions/firebase_exceptions.dart';
import 'package:todo_clean_arch/features/user/data/models/user_model.dart';
import 'package:todo_clean_arch/features/user/domain/entities/user.dart';
import 'package:todo_clean_arch/features/user/domain/repositories/user_repository.dart';
import 'package:todo_clean_arch/features/user/extensions/user_mapper.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl(this.firestore);

  @override
  Future<User?> getUserById(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc).toEntity();
      }
      return null;
    } on FirebaseException catch (e, stackTrace) {
      throw FirestoreException(
        message: e.message ?? 'Erro desconhecido',
        code: e.code,
        stackTrace: stackTrace,
        operation: 'getUserById',
      );
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception('Algo deu errado ao consultar um usuario\nMessagem: $e');
    }
  }

  @override
  Future<void> saveUser(User user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
