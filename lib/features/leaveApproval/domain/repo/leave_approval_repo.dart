abstract class LeaveApprovalRepo {
  Future<String> approveLeave(String empId, String leaveId, String? remark);

  Future<String> rejectLeave(String empId, String leaveId, String? remark);
}
