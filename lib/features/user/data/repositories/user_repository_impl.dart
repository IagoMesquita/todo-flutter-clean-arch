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
  Future<void> saveUser(User user) async {
    try {
      final userModel = user.toModel();

      await firestore.collection('users').doc(user.uid).set(userModel.toMap());
    } on FirebaseException catch (e, stackTrace) {
      throw FirestoreException(
        message: e.message ?? 'Erro desconhecido',
        code: e.code,
        stackTrace: stackTrace,
        operation: 'saveUser',
      );
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception('Algo deu errado ao consultar um usuario\nMessagem: $e');
    }
  }

  @override
  Future<void> updatePartialUserInfo({
    required String uid,
    String? name,
    String? email,
  }) async {
    try {
      final Map<String, dynamic> updates = {};

      if(name != null) updates['name'] = name;
      if(email != null) updates['email'] = email;

      if(updates.isNotEmpty) {
        await firestore.collection('users').doc(uid).update(updates);
      }

    } on FirebaseException catch (e, stackTrace) {
      throw FirestoreException(
        message: e.message ?? 'Erro desconhecido',
        code: e.code,
        stackTrace: stackTrace,
        operation: 'updatePartialUserInfo',
      );
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception('Algo deu errado ao consultar um usuario\nMessagem: $e');
    }
  }
}
