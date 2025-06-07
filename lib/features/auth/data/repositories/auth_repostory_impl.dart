import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_clean_arch/core/exceptions/firebase_exceptions.dart';
import 'package:todo_clean_arch/features/auth/data/models/auth_model.dart';
import 'package:todo_clean_arch/features/auth/domain/entities/auth.dart';
import 'package:todo_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:todo_clean_arch/features/auth/extensions/auth_mapper.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<Auth?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user != null && user.phoneNumber != null) {
        return AuthModel.fromFirebaseUser(user).toEntity();
      }
      return null;
    } catch (e, StackTrace) {
      throw FirestoreException(
        message: 'Erro ao buscar um usuário',
        stackTrace: StackTrace,
        operation: 'getCurrentUser',
      );
    }
  }

  @override
  Future<void> sendPhoneCode({
    required String phoneNumber,
    required Function(String verificationId) codeSent,
    required Function(String message) onError,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? 'Erro Desconhecido');
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Autenticação automática (Android): não usaremos nesse fluxo
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Pode ser usado se quiser tratar tempo de expiração
      },
    );
  }

  @override
  Future<Auth> verifyCode(
      {required String verificationId, required String smsCode}) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      final result = await _firebaseAuth.signInWithCredential(credential);
      final user = result.user;

      if (user != null && user.phoneNumber != null) {
        return AuthModel.fromFirebaseUser(user).toEntity();
      }

      throw FirestoreException(
        message: 'Usuário inválido ou sem número de telefone.',
        code: 'invalid-user',
        operation: 'verifyCode',
        stackTrace: StackTrace.current,
      );
    } on FirebaseAuthException catch (e, StackTrace) {
      throw FirestoreException(
        message: e.message ?? 'Erro ao verificar código',
        code: e.code,
        operation: 'verifyCode',
        stackTrace: StackTrace,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e, StackTrace) {
      throw FirestoreException(
        message: 'Erro ao deslogar usuário',
        stackTrace: StackTrace,
        operation: 'logout',
      );
    }
  }
}
