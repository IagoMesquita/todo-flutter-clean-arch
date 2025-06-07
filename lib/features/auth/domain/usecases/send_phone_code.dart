import 'package:todo_clean_arch/features/auth/domain/repositories/auth_repository.dart';

class SendPhoneCodeUseCase {
  final AuthRepository authRepository;

  SendPhoneCodeUseCase(this.authRepository);

  final _codeBR = '+55';

  Future<void> call(
      {required String phoneNumber,
      required Function(String verificationId) codeSent,
      required Function(String message) onError}) async {
    return await authRepository.sendPhoneCode(
      phoneNumber: '$_codeBR$phoneNumber',
      codeSent: codeSent,
      onError: onError,
    );
  }
}
