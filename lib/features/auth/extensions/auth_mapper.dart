import 'package:todo_clean_arch/features/auth/data/models/auth_model.dart';
import 'package:todo_clean_arch/features/auth/domain/entities/auth.dart';

extension AuthModelMapper on AuthModel {
  Auth toEntity() {
    return Auth(
      uid: uid,
      phoneNumer: phoneNumer,
    );
  }
}

extension AuthEntityMapper on Auth {
  AuthModel toModel() {
    return AuthModel(
      uid: uid,
      phoneNumer: phoneNumer,
    );
  }
}
