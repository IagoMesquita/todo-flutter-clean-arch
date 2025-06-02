import 'package:todo_clean_arch/features/user/data/models/user_model.dart';
import 'package:todo_clean_arch/features/user/domain/entities/user.dart';

extension UserModelMappar on UserModel {
  User toEntity() {
    return User(
      uid: uid,
      phoneNumber: phoneNumber,
      name: name,
      email: email,
    );
  }
}

extension UserEntity on User {
  UserModel toModel() {
    return UserModel(
      uid: uid,
      phoneNumber: phoneNumber,
      name: name,
      email: email,
    );
  }
}
