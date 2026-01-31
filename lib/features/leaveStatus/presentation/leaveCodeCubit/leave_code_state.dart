part of 'leave_code_cubit.dart';

@immutable
abstract class LeaveCodeState {
  const LeaveCodeState();
}

final class LeaveCodeInitial extends LeaveCodeState {
  const LeaveCodeInitial();
}

final class LeaveCodeLoading extends LeaveCodeState {
  const LeaveCodeLoading();
}

final class LeaveCodeLoaded extends LeaveCodeState {

  const LeaveCodeLoaded(this.leaveCodes);
  final List<LeaveCode> leaveCodes;
}

final class LeaveCodeError extends LeaveCodeState {

  const LeaveCodeError(this.message);
  final String message;
}
