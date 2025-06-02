import 'package:todo_clean_arch/features/user/domain/repositories/user_repository.dart';

class UpdateUserInfo {
  final UserRepository repository;

  UpdateUserInfo(this.repository);

  Future<void> call({required String uid, String? name, String? email}) {
    return repository.updatePartialUserInfo(
      uid: uid,
      name: name,
      email: email,
    );
  }
}
