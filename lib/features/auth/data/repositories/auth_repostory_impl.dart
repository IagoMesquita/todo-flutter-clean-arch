import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_clean_arch/features/auth/data/models/auth_model.dart';
import 'package:todo_clean_arch/features/auth/domain/entities/auth.dart';
import 'package:todo_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:todo_clean_arch/features/auth/extensions/auth_mapper.dart';

class AuthRepostoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepostoryImpl(this._firebaseAuth);
  
  @override
  Future<Auth?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;

    if(user != null && user.phoneNumber != null) {
      return AuthModel.fromFirebaseUser(user).toEntity();
    }
    return null;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> sendPhoneCode({required String phoneNumer, required Function(String verificationId) codeSent, required Function(String message) onError}) {
    // TODO: implement sendPhoneCode
    throw UnimplementedError();
  }

  @override
  Future<Auth> verifyCode({required String verificationId, required String smsCode}) {
    // TODO: implement verifyCode
    throw UnimplementedError();
  }


}