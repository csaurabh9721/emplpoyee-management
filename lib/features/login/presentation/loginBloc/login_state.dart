part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {

  LoginSuccess({required this.successMessage});
  final String successMessage;
}

final class LoginError extends LoginState {

  LoginError({required this.errorMessage});
  final String errorMessage;
}

final class TogglePasswordState{
  TogglePasswordState({required this.isVisible});
  final bool isVisible;
}