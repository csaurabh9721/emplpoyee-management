part of 'leave_approval_bloc.dart';

@immutable
abstract class LeaveApprovalEvent {
  const LeaveApprovalEvent();
}

final class LeaveApprovalApproveEvent implements LeaveApprovalEvent {

  const LeaveApprovalApproveEvent({required this.empId, required this.leaveId, this.remark});
  final String empId;
  final String leaveId;
  final String? remark;
}

final class LeaveApprovalRejectEvent implements LeaveApprovalEvent {

  const LeaveApprovalRejectEvent({required this.empId, required this.leaveId, this.remark});
  final String empId;
  final String leaveId;
  final String? remark;
}
