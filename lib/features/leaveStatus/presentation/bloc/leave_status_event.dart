part of 'leave_status_bloc.dart';

@immutable
abstract class LeaveStatusEvent extends Equatable {
  const LeaveStatusEvent();

  @override
  List<Object> get props => [];
}

final class LeaveStatusLoadedEvent extends LeaveStatusEvent {

  const LeaveStatusLoadedEvent(
      {required this.startDate,
      required this.endDate,
      required this.leaveType,
      required this.leaveStatus});
  final String startDate;
  final String endDate;
  final String leaveType;
  final String leaveStatus;

  @override
  List<Object> get props => [startDate, endDate, leaveType, leaveStatus];
}

final class LeaveStatusViewToggleEvent extends LeaveStatusEvent {

  const LeaveStatusViewToggleEvent({this.chosenLeave});
  final LeaveStatusEntity? chosenLeave;
}

final class LeaveStatusWithdrawEvent extends LeaveStatusEvent {

  const LeaveStatusWithdrawEvent(this.leaveApplicationNo,this.withdrawReason);
  final String leaveApplicationNo;
  final String withdrawReason;
}
