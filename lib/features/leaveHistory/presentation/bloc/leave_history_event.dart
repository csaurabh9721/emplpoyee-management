part of 'leave_history_bloc.dart';

@immutable
abstract class LeaveHistoryEvent extends Equatable {
  const LeaveHistoryEvent();

  @override
  List<Object> get props => [];
}

final class LoadLeaveHistoryEvent extends LeaveHistoryEvent {

  const LoadLeaveHistoryEvent({required this.startDate, required this.endDate});
  final String startDate;
  final String endDate;

  @override
  List<Object> get props => [startDate, endDate];
}
