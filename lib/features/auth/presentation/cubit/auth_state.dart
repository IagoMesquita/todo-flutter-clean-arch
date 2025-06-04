import 'package:equatable/equatable.dart';
import 'package:todo_clean_arch/features/auth/domain/entities/auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCodeSent extends AuthState {
  final String verificationId;
  const AuthCodeSent(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

class AuthAuthenticated extends AuthState {
  final Auth auth;
  const AuthAuthenticated(this.auth);

  @override
  List<Object?> get props => [auth];
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoggedOut extends AuthState {}