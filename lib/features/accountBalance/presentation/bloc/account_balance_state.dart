part of 'account_balance_cubit.dart';

@immutable
abstract class AccountBalanceState extends Equatable {
  const AccountBalanceState();

  @override
  List<Object> get props => [];
}

final class AccountBalanceInitial extends AccountBalanceState {
  const AccountBalanceInitial();
}

final class AccountBalanceLoading extends AccountBalanceState {
  const AccountBalanceLoading();
}

final class AccountBalanceLoaded extends AccountBalanceState {

  const AccountBalanceLoaded(this.entity);
  final List<AccountBalanceEntity> entity;

  @override
  List<Object> get props => [entity];
}

final class AccountBalanceError extends AccountBalanceState {

  const AccountBalanceError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
