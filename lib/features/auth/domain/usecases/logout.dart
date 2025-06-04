import 'package:todo_clean_arch/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<void> call() async {
    await authRepository.logout();
  }
}
