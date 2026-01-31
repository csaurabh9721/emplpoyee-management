part of 'get_leave_balance_cubit.dart';

@immutable
abstract class GetLeaveBalanceState extends Equatable {
  const GetLeaveBalanceState();

  @override
  List<Object?> get props => [];
}

final class GetLeaveBalanceInitial extends GetLeaveBalanceState {
  const GetLeaveBalanceInitial();
}

final class GetLeaveBalanceLoading extends GetLeaveBalanceState {
  const GetLeaveBalanceLoading();
}

class GetLeaveBalanceSuccess extends GetLeaveBalanceState {

  const GetLeaveBalanceSuccess({required this.leaveBalanceEntity});
  final ApplyLeaveBalanceEntity leaveBalanceEntity;

  @override
  List<Object?> get props => [
        leaveBalanceEntity,
      ];
}

class GetLeaveBalanceError extends GetLeaveBalanceState {

  const GetLeaveBalanceError(this.message);
  final String message;
}
