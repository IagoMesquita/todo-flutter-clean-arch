import 'package:todo_clean_arch/features/auth/domain/entities/auth.dart';

abstract class AuthRepository {
  /// Retorna usuario autenticado de existir.
  Future<Auth?> getCurrentUser();

  /// Envia o codigo de verificacao (OTP) para o numero de telefone.
  Future<void> sendPhoneCode({
    required String phoneNumber,
    required Function(String verificationId) codeSent,
    required Function(String message) onError,
  });

  /// Verifica o codigo recebido (OTP) e autentoca o usuario.
  Future<Auth> verifyCode({
    required String verificationId,
    required String smsCode,
  });

  /// Logout do usuario atual.
  Future<void> logout();
}

