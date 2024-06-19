part of 'auth_cubit.dart';


sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthLoadedState extends AuthState {}

final class NavChangeState extends AuthState {}


class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});
}