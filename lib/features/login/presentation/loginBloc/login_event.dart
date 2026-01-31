part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({required this.userLoginEntity});
  final UserLoginEntity userLoginEntity;

  @override
  List<Object?> get props => [userLoginEntity];
}
