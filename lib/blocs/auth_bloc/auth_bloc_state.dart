part of 'auth_bloc_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  bool isAuthComplete;
  bool isBiometricsAvailable;

  AuthLoaded({
    required this.isAuthComplete,
    required this.isBiometricsAvailable,
  });
}

final class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}
