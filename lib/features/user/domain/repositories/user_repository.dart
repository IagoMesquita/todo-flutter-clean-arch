import 'package:todo_clean_arch/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUserById(String uid); 
  Future<void> saveUser(User user); // Cria ou sobreescre
  Future<void> updatePartialUserInfo({ // atualiza parcialmente
    required String uid,
    String? name,
    String? email,
  });
}
