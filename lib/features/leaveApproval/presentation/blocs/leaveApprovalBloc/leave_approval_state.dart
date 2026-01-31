part of 'leave_approval_bloc.dart';

@immutable
final class LeaveApprovalState {

  const LeaveApprovalState(
      {this.approved = const ApprovalResponse(message: '', status: ApiStatus.initial),
      this.reject = const ApprovalResponse(message: '', status: ApiStatus.initial)});
  final ApprovalResponse approved;
  final ApprovalResponse reject;

  LeaveApprovalState copyWith({ApprovalResponse? approved, ApprovalResponse? reject}) {
    return LeaveApprovalState(
      approved: approved ?? this.approved,
      reject: reject ?? this.reject,
    );
  }
}

class ApprovalResponse {
  const ApprovalResponse({ this.message="", required this.status});
  final String message;
  final ApiStatus status;
}
