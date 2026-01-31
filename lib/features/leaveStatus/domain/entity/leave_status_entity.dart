class LeaveStatusEntity {

  LeaveStatusEntity({
    required this.leaveDescription,
    required this.reasonForLeave,
    required this.noOfDays,
    required this.leaveApplicationNo,
    required this.leaveStartDate,
    required this.leaveTypeCode,
    required this.currentApprovalNo,
    required this.approverName,
    required this.leaveEndDate,
    required this.remarks,
    required this.status,
  });
  final String leaveDescription;
  final String reasonForLeave;
  final String noOfDays;
  final String leaveApplicationNo;
  final String leaveStartDate;
  final String leaveTypeCode;
  final String currentApprovalNo;
  final String approverName;
  final String leaveEndDate;
  final String remarks;
  final String status;
}
