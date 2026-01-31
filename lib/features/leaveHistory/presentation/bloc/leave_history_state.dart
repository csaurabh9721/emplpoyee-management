part of 'leave_history_bloc.dart';

@immutable
abstract class LeaveHistoryState extends Equatable {
  const LeaveHistoryState();

  @override
  List<Object> get props => [];
}

final class LeaveHistoryInitial extends LeaveHistoryState {}

final class LeaveHistoryLoading extends LeaveHistoryState {}

final class LeaveHistoryLoaded extends LeaveHistoryState {

  const LeaveHistoryLoaded(this.entities);
  final List<LeaveHistoryEntity> entities;

  @override
  List<Object> get props => [entities];
}

final class LeaveHistoryError extends LeaveHistoryState {

  const LeaveHistoryError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
