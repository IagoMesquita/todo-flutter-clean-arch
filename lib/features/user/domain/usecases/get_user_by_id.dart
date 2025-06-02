import 'package:todo_clean_arch/features/user/domain/entities/user.dart';
import 'package:todo_clean_arch/features/user/domain/repositories/user_repository.dart';

class GetUserById {
  final UserRepository repository;

  GetUserById(this.repository);

  Future<User?> call(String uid) {
    return repository.getUserById(uid);
  }
  
}