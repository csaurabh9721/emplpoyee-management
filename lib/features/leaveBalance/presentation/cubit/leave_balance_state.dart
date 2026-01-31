part of 'leave_balance_cubit.dart';

@immutable
abstract class LeaveBalanceState {
  const LeaveBalanceState();
}

final class LeaveBalanceInitial extends LeaveBalanceState {
  const LeaveBalanceInitial();
}

final class LeaveBalanceLoading extends LeaveBalanceState {
  const LeaveBalanceLoading();
}

final class LeaveBalanceLoaded extends LeaveBalanceState {

  const LeaveBalanceLoaded(this.entity);
  final List<LeaveBalanceEntity> entity;
}

final class LeaveBalanceError extends LeaveBalanceState {

  const LeaveBalanceError(this.message);
  final String message;
}
