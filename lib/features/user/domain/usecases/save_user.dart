import 'package:todo_clean_arch/features/user/domain/entities/user.dart';
import 'package:todo_clean_arch/features/user/domain/repositories/user_repository.dart';

class SaveUser {
  final UserRepository repository;

  SaveUser(this.repository);

  Future<void> call(User user)  {
    return repository.saveUser(user);
  }
}