part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class InitialState extends ChangePasswordState {}

final class LoadingState extends ChangePasswordState {}

final class SuccessState extends ChangePasswordState {
  SuccessState({required this.successMessage});
  final String successMessage;
}

final class ErrorState extends ChangePasswordState {

  ErrorState({required this.errorMessage});
  final String errorMessage;
}
