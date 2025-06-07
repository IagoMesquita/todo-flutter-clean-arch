import 'package:todo_clean_arch/features/auth/domain/entities/auth.dart';
import 'package:todo_clean_arch/features/auth/domain/repositories/auth_repository.dart';

class VerifyCodeUseCase {
  final AuthRepository authRepository;

  VerifyCodeUseCase(this.authRepository);

  Future<Auth> call({
    required String verificationId,
    required String smsCode,
  }) async {
    return await authRepository.verifyCode(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }
}
