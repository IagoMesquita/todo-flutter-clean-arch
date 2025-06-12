import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/features/user/domain/entities/user.dart';
import 'package:todo_clean_arch/features/user/domain/usecases/get_user_by_id.dart';
import 'package:todo_clean_arch/features/user/domain/usecases/save_user.dart';
import 'package:todo_clean_arch/features/user/domain/usecases/update_user_info.dart';
import 'package:todo_clean_arch/features/user/presentation/cubit/UserState.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserById getUserById;
  final SaveUser saveUser;
  final UpdateUserInfo updateUserInfo;

  UserCubit({
    required this.getUserById,
    required this.saveUser,
    required this.updateUserInfo,
  }) : super(UserInitial());

  Future<void> loadUser(String uid) async {
    emit(UserLoading());

    try {
      final userData = await getUserById(uid);
      if (userData != null) {
        emit(UserLoaded(userData));
      } else {
        emit(const UserError('Usiario nao encontrado'));
      }
    } catch (e) {
      emit(const UserError('Erro ao carregar dados do usuário'));
    }
  }

  Future<void> saveNewUser(User user) async {
    emit(UserLoading());

    try {
      await saveUser(user);
      emit(UserLoaded(user));
    } catch (e) {
      emit(const UserError('Erro ao salvar dados do usuario'));
    }
  }

  Future<void> updateUser(
      {required String uid, String? name, String? email}) async {
    emit(UserLoading());
    try {
      await updateUserInfo(
        uid: uid,
        name: name,
        email: email,
      );

      final updatedUser = await getUserById(uid);

      if(updatedUser != null) {
        emit(UserLoaded(updatedUser));
      } else {
        emit( UserError('Error ao atualizar: usuario $uid nao encontrado'));
      }

    } catch (e) {
      emit(const UserError('Erro ao atualizar dados do usuario'));
    }
  }
}
