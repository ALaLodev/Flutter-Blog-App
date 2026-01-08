part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthEventInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user; // Devolvemos el usuario si tuvo éxito
  const AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message; // Devolvemos el mensaje de error si falló
  const AuthFailure(this.message);
}
