import 'package:todo_clean_arch/features/auth/domain/entities/auth.dart';
import 'package:todo_clean_arch/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;

  GetCurrentUserUseCase(this.authRepository);

  Future<Auth?> call() async {
    return await authRepository.getCurrentUser();
  } 
}