part of 'leave_status_bloc.dart';

@immutable
abstract class LeaveStatusState extends Equatable {
  const LeaveStatusState();

  @override
  List<Object?> get props => [];
}

final class LeaveStatusInitial extends LeaveStatusState {
  const LeaveStatusInitial();
}

final class LeaveStatusLoading extends LeaveStatusState {
  const LeaveStatusLoading();
}

final class LeaveStatusError extends LeaveStatusState {

  const LeaveStatusError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class LeaveStatusLoaded extends LeaveStatusState {

  const LeaveStatusLoaded({
    required this.leaveStatus,
    this.selectedLeave,
    this.withdrawStatus = APIStatus.initial,
  });
  final List<LeaveStatusEntity> leaveStatus;
  final LeaveStatusEntity? selectedLeave;
  final APIStatus withdrawStatus;

  LeaveStatusLoaded copyWith({
    List<LeaveStatusEntity>? leaveStatus,
    LeaveStatusEntity? selectedLeave,
    APIStatus? withdrawStatus,
  }) {
    return LeaveStatusLoaded(
      leaveStatus: leaveStatus ?? this.leaveStatus,
      selectedLeave: selectedLeave,
      withdrawStatus: withdrawStatus ?? this.withdrawStatus,
    );
  }

  @override
  List<Object?> get props => [leaveStatus, selectedLeave, withdrawStatus];
}
