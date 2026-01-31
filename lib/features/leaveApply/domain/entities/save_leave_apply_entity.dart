class SaveLeaveApplyEntity {

  SaveLeaveApplyEntity(
      {required this.date,
        required this.leavePeriod,
        required this.noOfDays,
        required this.leaveType,
        required this.paidType,
        required this.leaveTypeId,
        required this.creditDays,
        required this.availed,
        required this.leaveBalance,
        required this.advanceLeave,
        this.remark,
        this.fileName});
  final String date;
  final String leavePeriod;
  final String noOfDays;
  final String leaveType;
  final String paidType;
  final String leaveTypeId;
  final String creditDays;
  final String availed;
  final String leaveBalance;
  final String advanceLeave;
  final String? remark;
  final String? fileName;
}
