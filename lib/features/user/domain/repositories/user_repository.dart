import 'package:todo_clean_arch/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUserById(String uid); // Cria ou sobreescre
  Future<void> saveUser(User user); // atualiza parcialmente
  Future<void> updateUser(User user);
}