part of 'continuous_paid_leave_cubit.dart';

@immutable
abstract class ContinuousPaidLeaveState {
  const ContinuousPaidLeaveState();
}

final class ContinuousPaidLeaveInitial extends ContinuousPaidLeaveState {}

final class ContinuousPaidLeaveLoading extends ContinuousPaidLeaveState {
  const ContinuousPaidLeaveLoading();
}

class ContinuousPaidLeaveSuccess extends ContinuousPaidLeaveState {

  const ContinuousPaidLeaveSuccess({required  this.continuousPaidLeave,});
  final Map<int, String>? continuousPaidLeave;
}

class ContinuousPaidLeaveError extends ContinuousPaidLeaveState {

  const ContinuousPaidLeaveError(this.message);
  final String message;
}
