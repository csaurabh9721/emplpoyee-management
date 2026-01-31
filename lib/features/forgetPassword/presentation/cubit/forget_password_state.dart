part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class InitialState extends ForgetPasswordState {}

final class LoadingState extends ForgetPasswordState {}

final class SuccessState extends ForgetPasswordState {
  SuccessState({required this.successMessage});
  final String successMessage;
}

final class ErrorState extends ForgetPasswordState {

  ErrorState({required this.errorMessage});
  final String errorMessage;
}
