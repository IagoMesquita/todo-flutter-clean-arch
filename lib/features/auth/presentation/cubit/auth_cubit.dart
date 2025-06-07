import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_arch/features/auth/domain/usecases/get_current_user.dart';
import 'package:todo_clean_arch/features/auth/domain/usecases/logout.dart';
import 'package:todo_clean_arch/features/auth/domain/usecases/send_phone_code.dart';
import 'package:todo_clean_arch/features/auth/domain/usecases/verify_code.dart';
import 'package:todo_clean_arch/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SendPhoneCodeUseCase sendPhoneCodeUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.getCurrentUserUseCase,
    required this.sendPhoneCodeUseCase,
    required this.verifyCodeUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  Future<void> checkAuhStatus() async {
    emit(AuthLoading());

    final user = await getCurrentUserUseCase();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> requestPhoneCode(String phoneNumber) async {
    emit(AuthLoading());

    await sendPhoneCodeUseCase(
      phoneNumber: phoneNumber,
      codeSent: (verificationId) {
        emit(AuthCodeSent(verificationId));
      },
      onError: (message) {
        emit(AuthError(message));
      },
    );
  }

  Future<void> confirmCode(String verificationId, String smsCode) async {
    emit(AuthLoading());

    try {
      final user = await verifyCodeUseCase(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(const AuthError('Falha ao autenticar. Tente novamente'));
    }
  }

  Future<void> singOut() async {
    emit(AuthLoading());

    await logoutUseCase();

    emit(AuthLoggedOut());
  }
}
